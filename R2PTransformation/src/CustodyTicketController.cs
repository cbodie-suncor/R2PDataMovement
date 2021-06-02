using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using R2PTransformation.Models;
using System;
using System.Collections.Generic;
using System.Linq;

namespace R2PTransformation.src {

    public class CustodyTicketPBFile {
        // a file will be created for unique plants and posting dates
        public string Contents { get; set; }
        public List<CustodyTicket> Tickets { get; set; }
        public string Plant { get; set; }
        public DateTime PostingDate { get; set; }

        public String GetAzurePath { get {
                return $"{Plant}/custodyTickets/{ (Plant == "CP01" ? "EDM" : (Plant == "CP03" ? "SRN" : "MTL")) }_MBGMCR_{PostingDate.ToString("yyyyMMddHHmmss")}_{DateTime.Now.ToString("yyyyMMddHHmmss")}.txt";
            }
        }
    }
    
    public class CustodyTicketBatch {
        public CustodyTicketBatch() {
            this.Warnings = new List<WarningMessage>();
        }

        public String Json { get; set; }
        public List<CustodyTicket> Tickets { get; set; }
        public List<WarningMessage> Warnings { get; set; }
        public int SuccessFulRecords { get { return this.Tickets.Count; } }
        public object BatchId { get; set; }

        public List<CustodyTicketPBFile> GeneratedHoneywellPBContent() {
            List<CustodyTicketPBFile> files = new List<CustodyTicketPBFile>();
            // only create files for 3 plants (CP01, CP03, CP04)
            var groups = Tickets.Where(t => t.Plant == "CP01" || t.Plant == "CP03" || t.Plant == "CP04").GroupBy(t => new { t.Plant, t.PostingDateTime }, (key, elements) => new { Key = key, Items = elements.ToList()  });
            foreach (var group in groups) {
                files.Add(new CustodyTicketPBFile() { Plant = group.Key.Plant, PostingDate = group.Key.PostingDateTime, Tickets = group.Items, Contents = CustodyTicketController.CreateHoneywellPBFile(group.Items) } );
            }
            return files;
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
                doc += GetMovement(ticket);
            }
            return doc + FOOTER;
        }

        private static List<CustodyTicket> GetTixFromJson(CustodyTicketBatch group) {
            List<CustodyTicket> tix = new List<CustodyTicket>();
            object data = JsonConvert.DeserializeObject(group.Json);
            JObject batch = (JObject)data;
            group.BatchId = batch["batchId"].ToString();
            JArray custodyTickets = (JArray)batch["custodyTicket"];
            foreach (var v in custodyTickets) {
                try {
                    CustodyTicket ct = new CustodyTicket() {
                        S4MaterialDocument = GetStringValue(v, "materialDocument"),
                        S4Bol = GetStringValue(v, "bolNumber"),
                        Material = GetStringValue(v, "material"),
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
                    ct.CalculateHoneywellBOL();
                    ct.LookupTag();
                    if (ct.Tag == null) {
                        group.Warnings.Add(new WarningMessage(MessageType.Info, "material:\"" + ct.Material + "\",plant:\"" + ct.Plant + "\",valuationType:\"" + ct.ValuationType + "\",date:\"" + ct.PostingDateTime + "\"", "No TagMapping"));
                    } else {
                        tix.Add(ct);
                    }
                } catch (Exception ex) {
                    string bolNumber = GetStringValue(v, "bolNumber");
                    string enteredOnDateTime = GetStringValue(v, "enteredOnDateTime");
                    group.Warnings.Add(new WarningMessage(MessageType.Error, "{bolNumber:\"" + bolNumber + "\",enteredOnDateTime:\"" + enteredOnDateTime + "\",error:\"" + ex.Message + "\"}"));
                }
            }
            return tix;
        }

        private static string GetMovement(CustodyTicket ticket) {
            string rec = GetMovementHeader(ticket);
            rec += GetMovementDetail(ticket, "S");
            rec += GetMovementDetail(ticket, "D");
            return rec;
        }

        private static string GetMovementHeader(CustodyTicket ticket) {
            string result = "<START MOVEMENT REC>\r\n";
            result += @$"MOVEMENT_ID,{ticket.S4MaterialDocument}
MOVEMENT_TYPE,M
START_DATE_TIME,{GetDateTime(ticket.PostingDateTime)}
END_DATE_TIME,{GetDateTime(ticket.PostingDateTime)}
TEMPLATE_NAME,T-SAP
REFERENCE,{ticket.CalculateHeaderReference()}
NOTES,
";
            result += "<END MOVEMENT REC>\r\n";
            return result;
        }

        private static string GetMovementDetail(CustodyTicket ticket, string type) {
            string result = "<START MOVEMENT DETAIL REC>\r\n";
            result += @$"MOVEMENT_ID,{ticket.S4MaterialDocument}
SOURCE_OR_DESTINATION,{type}
EQUIPMENT,
PRODUCT,{ticket.Tag}
PACKAGE,
START_QTY,
END_QTY,{ (type == "D" ? "" : ticket.GetSign + FormatDP(ticket.NetQuantitySizeInBuoe, 3))}
NET_QTY,{ ticket.GetSign + FormatDP(ticket.NetQuantitySizeInBuoe, 3)}
PACKAGE_COUNT,
UNITS,L
COMPANY,
REFERENCE,{ (type == "S" ? ticket.Density.ToString() : ticket.HoneywellBol ) }
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

namespace R2PTransformation.Models {

    public partial class CustodyTicket {
        public String Tag;
        public void CalculateHoneywellBOL() {
            CustodyTicket ct = this;
            switch (ct.VehicleText) {
                case "Pipeline": ct.HoneywellBol = ct.Tender + "_" + ct.S4Bol; break;
                case "Rail": ct.HoneywellBol = ct.VehicleNumber; break;
                case "Truck": ct.HoneywellBol = ct.S4Bol; break;
                default: ct.HoneywellBol = ct.S4Bol; break;
            }
        }
        public String CalculateHeaderReference() {
            string signPrefix = Sign == "-" ? "S_" : "R_";
            CustodyTicket ct = this;
            switch (ct.Mode) {
                case "Pipeline": return signPrefix + "PP"; break;
                case "Marine": return signPrefix + "MM"; break;
                case "Rail": return signPrefix + "RR"; break;
                case "Truck": return signPrefix + "TT"; break;
                case "Truck (Non-TSW)": return signPrefix + "TT"; break;
                case "Road": return signPrefix + "TT"; break;
                default: return ""; break;
            }
        }

        public void LookupTag() {
            CustodyTicket ct = this;
            TagMap tm = AzureModel.ReverseLookupForTag(ct.Material.ToString(), ct.Plant, ct.ValuationType, "Prod");
            if (tm != null) ct.Tag = tm.Tag;
        }

        public string GetSign { get { return this.Sign == "-" ? "-" : ""; } }
    }
}

