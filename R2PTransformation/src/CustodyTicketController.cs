using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using R2PTransformation.Models;
using System;
using System.Collections.Generic;
using System.Linq;

namespace R2PTransformation.src {

    public class CustodyTicketBatch {
        public CustodyTicketBatch() {
            this.Warnings = new List<WarningMessage>();
        }

        public String Json { get; set; }
        public List<CustodyTicket> Tickets { get; set; }
        public List<WarningMessage> Warnings { get; set; }
        public int SuccessFulRecords { get { return this.Tickets.Count; } }
        public object BatchId { get; set; }

        public String GeneratedHoneywellPBContent(string plant) {
            string contents = CustodyTicketController.CreateHoneywellPBFile(this.Tickets.Where(t => t.Plant == plant).ToList());
            return contents;
        }

        public String GetAzurePath(string plant) {
            return $"{plant}/custodyTickets/{DateTime.Now.ToString("yyyyMMddHHmmss")}.txt"; ;
        }
    }
    public class CustodyTicketController : SuncorController {
        public static string FOOTER = @"<<PRODUCT MOVEMENT IFC>>
<<END OF FILE MARKER>>
";
        public static string HEADER = @"<<PRODUCT MOVEMENT IFC>>
<_DEFAULTS_>
DATEFORMAT, DD/MM/YYYY
DATETIMEFORMAT, DD/MM/YYYY HH24:MI:SS
<ENDDEFAULTS>
";

        public static CustodyTicketBatch CreateHoneywellPBFile(string json) {
            if (string.IsNullOrWhiteSpace(json)) throw new Exception("Json is empty");
            CustodyTicketBatch file = new CustodyTicketBatch();
            file.Json = json;
            file.Tickets = GetTixFromJson(file);
            AzureModel.SaveCustodyTickets(file);
            return file;
        }

        public static string CreateHoneywellPBFile(List<CustodyTicket> tix) {
            if (tix.Count == 0) return null;
            string doc = HEADER;
            foreach (CustodyTicket ticket in tix) {
                doc += GetMovement(ticket, ticket.EnteredBy);
            }
            return doc + FOOTER;
        }

        private static List<CustodyTicket> GetTixFromJson(CustodyTicketBatch file) {
            List<CustodyTicket> tix = new List<CustodyTicket>();
            object data = JsonConvert.DeserializeObject(file.Json);
            JObject batch = (JObject)data;
            file.BatchId = batch["batchId"].ToString();
            JArray custodyTickets = (JArray)batch["custodyTicket"];
            foreach (var v in custodyTickets) {
                try {
                    CustodyTicket ct = new CustodyTicket() {
                        S4MaterialDocument = GetStringValue(v, "materialDocument"),
                        S4Bol = GetStringValue(v, "bolNumber"),
                        MovementTypeDescription = GetStringValue(v, "movementTypeDescription"),
                        Sign = GetStringValue(v, "sign"),
                        NetQuantitySizeInUoe = ParseDecimal(v, "netQuantitySizeinUOE"),
                        NetQuantitySizeInBuoe = ParseDecimal(v, "netQuantitySizeinBUOE"),
                        BaseUnitOfMeasure = GetStringValue(v, "baseUoM"),
                        BaseUnitOfEntry = GetStringValue(v, "unitOfEntry"),
                        Mass = ParseDecimal(v, "mass"),
                        ValuationType = GetStringValue(v, "valuationType"),
                        Density = ParseDecimal(v, "density"),
                        DensityUom = GetStringValue(v, "densityUOM"),
                        Origin = GetStringValue(v, "origin"),
                        Destination = GetStringValue(v, "destination"),
                        Plant = GetStringValue(v, "plant"),
                        Temperature = ParseDecimal(v, "temperature"),
                        TemperatureUnitOfMeasure = GetStringValue(v, "temperatureUom"),
                        MovementType = GetStringValue(v, "movementType"),
                        Mode = GetStringValue(v, "mode"),
                        VehicleNumber = GetStringValue(v, "vehicle"),
                        VehicleText = GetStringValue(v, "vehicleText"),
                        Tender = GetStringValue(v, "tender"),
                        LoadStartDateTime = ParseDateTimeCanBeNull(v, "loadStartDate"),
                        LoadEndDateTime = ParseDateTimeCanBeNull(v, "loadEndDate"),
                        EnteredOnDateTime = ParseDateTimeCanBeNull(v, "enteredOnDateTime"),
                        DocumentDateTime = ParseDateTimeCanBeNull(v, "documentDate"),
                        PostingDateTime = ParseDateTime(v, "postingDateTime")
                    };
                    CalculateHoneywellBOL(ct);
                    tix.Add(ct);
                } catch (Exception ex) {
                    string bolNumber = GetStringValue(v, "bolNumber");
                    string enteredOnDateTime = GetStringValue(v, "enteredOnDateTime");
                    file.Warnings.Add(new WarningMessage(MessageType.Error, "{bolNumber:\"" + bolNumber + "\",enteredOnDateTime:\"" + enteredOnDateTime + "\",error:\"" + ex.Message + "\"}"));
                }
            }
            return tix;
        }

        public static void CalculateHoneywellBOL(CustodyTicket ct) {
            switch(ct.VehicleText) {
                case "Pipeline": ct.HoneywellBol = ct.Tender + "_" + ct.S4Bol; break;
                case "Rail": ct.HoneywellBol = ct.VehicleNumber; break;
                case "Truck": ct.HoneywellBol = ct.S4Bol; break;
                default: ct.HoneywellBol = ct.S4Bol; break;
            }
        }

        private static string GetMovement(CustodyTicket ticket, string movementId) {
            string rec = GetMovementHeader(ticket, movementId);
            rec += GetMovementDetail(ticket, movementId, "S");
            rec += GetMovementDetail(ticket, movementId, "D");
            return rec;
        }

        private static string GetMovementHeader(CustodyTicket ticket, string movementId) {
            string result = "<START MOVEMENT REC>\r\n";
            result += @$"MOVEMENT_ID,{movementId}
MOVEMENT_TYPE,M
START_DATE_TIME,{GetDateTime(ticket.PostingDateTime)}
END_DATE_TIME,{GetDateTime(ticket.PostingDateTime)}
TEMPLATE_NAME,T-SAP
REFERENCE,S_TT
NOTES,
";
            result += "<END MOVEMENT REC>\r\n";
            return result;
        }

        private static string GetMovementDetail(CustodyTicket ticket, string movementId, string type) {
            string product = ticket.S4MaterialDocument;
            string result = "<START MOVEMENT DETAIL REC>\r\n";
            result += @$"MOVEMENT_ID,{movementId}
SOURCE_OR_DESTINATION,{type}
EQUIPMENT,
PRODUCT,{product}
PACKAGE,
START_QTY,
END_QTY,{ (type == "D" ? "" : FormatDP(ticket.NetQuantitySizeInBuoe, 3))}
NET_QTY,{ FormatDP(ticket.NetQuantitySizeInBuoe, 3)}
PACKAGE_COUNT,
UNITS,L
COMPANY,
REFERENCE,{ ticket.HoneywellBol }
";
            result += "<END MOVEMENT DETAIL REC>\r\n";
            return result;
        }

        private static string FormatDP(decimal quantity, int dp) {
            string zeros = "0000000000".Substring(0, dp);
            return String.Format("{0:0."+zeros+"}", quantity);
        }

        private static string GetDateTime(DateTime startDateTime) {
            return startDateTime.ToString("dd/MM/yyyy hh:mm:ss");
        }
    }
}
