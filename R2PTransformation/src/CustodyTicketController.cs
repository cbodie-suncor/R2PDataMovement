using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using R2PTransformation.Models;
using System;
using System.Collections.Generic;
using System.Text;

namespace R2PTransformation.src {

    public class PBFile {
        public String Filename { get; set; }
        public String Json { get; set; }
        public String Plant { get; set; }
        public String AzurePath { get; set; }
        public String Contents { get; set; }
        public int SuccessFulRecords { get; set; }
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

        public static PBFile CreateHoneywellPBFile(string json) {
            if (string.IsNullOrWhiteSpace(json)) throw new Exception("Json is empty");
            PBFile file = new PBFile();
            List<WarningMessage> Warnings = new List<WarningMessage>();

            List<CustodyTicket> tixs = GetTixFromJson(json);
            AzureModel.AddCustodyTickets(tixs);
            file.Json = json;
            file.Contents = CreateHoneywellPBFile(tixs);
            file.SuccessFulRecords = tixs.Count;
            return file;
        }

        public static string CreateHoneywellPBFile(List<CustodyTicket> tix) {
            string doc = HEADER;
            foreach (CustodyTicket ticket in tix) {
                doc += GetMovement(ticket, ticket.EnteredBy);
            }
            return doc + FOOTER;
        }

        public static List<CustodyTicket> GetTixFromJson(string json) {
            List<CustodyTicket> tix = new List<CustodyTicket>();
            object data = JsonConvert.DeserializeObject(json);
            JObject batch = (JObject)data;
            string batchId = batch["batchId"].ToString();
            JArray custodyTickets = (JArray)batch["custodyTicket"];
            foreach (var v in custodyTickets) {
                CustodyTicket ct = new CustodyTicket() {
                    S4MaterialDocument = GetStringValue(v, "materialDocument"),
                    BolNumber = GetStringValue(v,"bolNumber"),
                    MovemonmentTypeDescription = GetStringValue(v, "movementTypeDescription"),
                    Sign = GetStringValue(v, "sign"),
                    NetQuantitySizeInUoe = ParseDecimal(v, "netQuantitySizeinUOE"),
                    NetQuantitySizeInBuoe = ParseDecimal(v, "netQuantitySizeinBUOE"),
                    BaseUnitOfMeasure = GetStringValue(v, "baseUoM"),
                    BaseUnitOfEntry = GetStringValue(v, "unitOfEntry"),
                    Mass = ParseDecimal(v, "mass"),
                    ValuationType = GetStringValue(v, "valuationType"),
                    Density = ParseDecimal(v, "density"),
                    DensityUom = GetStringValue(v,"densityUOM"),
                    Origin = GetStringValue(v,"origin"),
                    Destination = GetStringValue(v,"destination"),
                    Plant = GetStringValue(v,"plant"),
                    Temperature = ParseDecimal(v, "temperature"),
                    TemperatureUnitOfMeasure= GetStringValue(v, "temperatureUom"),
                    MovementType = GetStringValue(v,"movementType"),
                    Mode = ParseInt(v,"mode"),
                    VehicleNumber = GetStringValue(v, "vehicle"),
                    VehicleText = GetStringValue(v, "vehicleText"),
                    Tender = GetStringValue(v,"tender"),
                    LoadStartDateTime = ParseDateTime(v,"loadStartDate"),
                    LoadEndDateTime = ParseDateTime(v,"loadEndDate"),
                    EnteredOnDateTime = ParseDateTime(v, "enteredOnDateTime"),
                    DocumentDateTime = ParseDateTime(v,"documentDate"),
                    PostingDateTime = ParseDateTime(v,"postingDateTime")
                };
                tix.Add(ct);
            }
            return tix;
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
REFERENCE,{ (type == "D" ? ticket.BolNumber : FormatDP(ticket.Density.Value, 4) )}
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

        public static void HandleNewRequest(string jsonContent) {
            throw new NotImplementedException();
        }
    }
}
