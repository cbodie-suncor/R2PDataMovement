using R2PTransformation.src.db;
using System;
using System.Collections.Generic;
using System.Text;

namespace R2PTransformation.src {
    public class CustodyTicketController {
        public static string FOOTER = @"<<PRODUCT MOVEMENT IFC>>
<<END OF FILE MARKER>>
";
        public static string HEADER = @"<<PRODUCT MOVEMENT IFC>>
<_DEFAULTS_>
DATEFORMAT, DD/MM/YYYY
DATETIMEFORMAT, DD/MM/YYYY HH24:MI:SS
<ENDDEFAULTS>
";

        public static string CreateHoneywellPBFile(List<CustodyTicket> tix) {
            string doc = HEADER;
            foreach(CustodyTicket ticket in tix) {
                doc += GetMovement(ticket, ticket.EnteredBy  );
            }
            return doc + FOOTER;
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
            string product = ticket.S4Material;
            string result = "<START MOVEMENT DETAIL REC>\r\n";
            result += @$"MOVEMENT_ID,{movementId}
SOURCE_OR_DESTINATION,{type}
EQUIPMENT,
PRODUCT,{product}
PACKAGE,
START_QTY,
END_QTY,{ (type == "D" ? "" : FormatDP(ticket.NetQuantitySize, 3))}
NET_QTY,{ FormatDP(ticket.NetQuantitySize, 3)}
PACKAGE_COUNT,
UNITS,L
COMPANY,
REFERENCE,{ (type == "D" ? ticket.BolNumber : FormatDP(ticket.Density, 4) )}
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
