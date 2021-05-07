using Microsoft.Extensions.Configuration;
using Newtonsoft.Json;
using NUnit.Framework;
using R2PTransformation.src;
using R2PTransformation.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.IO;
using System.Linq;
using Microsoft.EntityFrameworkCore;

namespace STransformNUnit {
    public class CustodyTicketsTests {
        [SetUp]
        public void Setup() {
            DBContextWithConnectionString.CreateTestContext();
        }

        // NOT RUN
        public void LoadCSV() {
            // for Loading sample data
//            string cs = "Data Source=aaasbxarmsrvuw2015.database.windows.net;Initial Catalog=NLSandbox;User ID=tempR2PIntegration;password=NorthernLights2021";
            string cs = "Data Source=inmdevarmsvruw2001.database.windows.net;Initial Catalog=inmdevarmsqluw2001;User ID=suncorsqladmin;password=AdvancedAnalytics2020;";
            DataTable dt = Utilities.ConvertCSVFiletoDataTable(@"..\..\..\..\sampleFiles\CustodyTicket\ct.csv");
            dt.TableName = "custodyticket";
            foreach (DataRow row in dt.AsEnumerable()) {
                foreach(DataColumn col in dt.Columns) {
                    if (row[col].ToString() == "") row[col] = DBNull.Value;
                }
            }

            Utilities.Save(cs, dt);
            Assert.IsTrue(dt.Rows.Count > 0);
        }

        [Test]
        public void CreateJson() {
            List<CustodyTicket> tix = null;
            using (var context = DBContextWithConnectionString.Create()) {
                tix = context.CustodyTicket.ToList();
            }

            string json = JsonConvert.SerializeObject(tix);
        }

        [Test]
        public void TestInmemory() {
            DBContextWithConnectionString.CreateTestContext();

            using (var context = DBContextWithConnectionString.Create()) {
                Assert.AreEqual(context.StandardUnit.ToList().Count, 2);
            }

            Assert.AreEqual(AzureModel.GetUnits().Count, 2);
            Assert.AreEqual(AzureModel.GetUnits().Count, 2);
            Assert.AreEqual(AzureModel.GetUnits().Count, 2);
        }

        [Test]
        public void TestSample() {
            string json = File.ReadAllText(@"..\..\..\..\sampleFiles\CustodyTicket\CustodyTicket_Azure_Sample_Request.json");
            List<CustodyTicket> tix = CustodyTicketController.GetTixFromJson(json);
            Assert.AreEqual(1, tix.Count);
            String generated = CustodyTicketController.CreateHoneywellPBFile(tix);
            generated = generated.Replace("\n", "").Replace("\r", "");
            Assert.AreEqual("<<PRODUCT MOVEMENT IFC>><_DEFAULTS_>DATEFORMAT, DD/MM/YYYYDATETIMEFORMAT, DD/MM/YYYY HH24:MI:SS<ENDDEFAULTS><START MOVEMENT REC>MOVEMENT_ID,MOVEMENT_TYPE,MSTART_DATE_TIME,02/02/2021 12:00:00END_DATE_TIME,02/02/2021 12:00:00TEMPLATE_NAME,T-SAPREFERENCE,S_TTNOTES,<END MOVEMENT REC><START MOVEMENT DETAIL REC>MOVEMENT_ID,SOURCE_OR_DESTINATION,SEQUIPMENT,PRODUCT,10072PACKAGE,START_QTY,END_QTY,10.000NET_QTY,10.000PACKAGE_COUNT,UNITS,LCOMPANY,REFERENCE,723.0000<END MOVEMENT DETAIL REC><START MOVEMENT DETAIL REC>MOVEMENT_ID,SOURCE_OR_DESTINATION,DEQUIPMENT,PRODUCT,10072PACKAGE,START_QTY,END_QTY,NET_QTY,10.000PACKAGE_COUNT,UNITS,LCOMPANY,REFERENCE,3343434<END MOVEMENT DETAIL REC><<PRODUCT MOVEMENT IFC>><<END OF FILE MARKER>>", generated);

            PBFile generatedFile = CustodyTicketController.CreateHoneywellPBFile(json);
        }

        [Test]
        public void TestSample3() {
            string json = File.ReadAllText(@"..\..\..\..\sampleFiles\CustodyTicket\Custody Ticket3.json");
            List<CustodyTicket> tix = CustodyTicketController.GetTixFromJson(json);
            Assert.AreEqual(3, tix.Count);
            String generated = CustodyTicketController.CreateHoneywellPBFile(tix);
            generated = generated.Replace("\n", "").Replace("\r", "");
            //            Assert.AreEqual("<<PRODUCT MOVEMENT IFC>><_DEFAULTS_>DATEFORMAT, DD/MM/YYYYDATETIMEFORMAT, DD/MM/YYYY HH24:MI:SS<ENDDEFAULTS><START MOVEMENT REC>MOVEMENT_ID,MOVEMENT_TYPE,MSTART_DATE_TIME,02/02/2021 12:00:00END_DATE_TIME,02/02/2021 12:00:00TEMPLATE_NAME,T-SAPREFERENCE,S_TTNOTES,<END MOVEMENT REC><START MOVEMENT DETAIL REC>MOVEMENT_ID,SOURCE_OR_DESTINATION,SEQUIPMENT,PRODUCT,10072PACKAGE,START_QTY,END_QTY,10.000NET_QTY,10.000PACKAGE_COUNT,UNITS,LCOMPANY,REFERENCE,723.0000<END MOVEMENT DETAIL REC><START MOVEMENT DETAIL REC>MOVEMENT_ID,SOURCE_OR_DESTINATION,DEQUIPMENT,PRODUCT,10072PACKAGE,START_QTY,END_QTY,NET_QTY,10.000PACKAGE_COUNT,UNITS,LCOMPANY,REFERENCE,3343434<END MOVEMENT DETAIL REC><<PRODUCT MOVEMENT IFC>><<END OF FILE MARKER>>", generated);

            PBFile generatedFile = CustodyTicketController.CreateHoneywellPBFile(json);
        }

        //fix        [Test]
        public void TestBuilder() {
            string targetFile = File.ReadAllText(@"..\..\..\..\sampleFiles\CustodyTicket\SampleTicket.txt");
            CustodyTicket ct1 = new CustodyTicket(){ PostingDateTime = new DateTime(2020, 09, 14, 07, 43, 13),  EnteredBy = "170552311-1",  S4MaterialDocument = "123", NetQuantitySizeInUoe = 13507, BolNumber = "166438_", Density = 0.7260M };
            CustodyTicket ct2 = new CustodyTicket() { PostingDateTime = new DateTime(2020, 09, 14, 07, 44, 13), EnteredBy = "170552311-2", S4MaterialDocument = "123", NetQuantitySizeInUoe = 12961, BolNumber = "166438_", Density = 0.8660M };

            List<CustodyTicket> tix = new List<CustodyTicket>();
            tix.Add(ct1);
            tix.Add(ct2);
            String generated = CustodyTicketController.CreateHoneywellPBFile(tix);
            Assert.AreEqual(targetFile, generated);
        }
    }
}
