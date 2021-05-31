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

/*
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
        }*/

        [Test]
        public void TestInmemory() {
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
            CustodyTicketBatch tix = CustodyTicketController.CreateHoneywellPBFile(json);
            Assert.AreEqual(2, tix.Tickets.Count);
            List<CustodyTicketPBFile> generated = tix.GeneratedHoneywellPBContent();
            string contents = generated[0].Contents.Replace("\n", "").Replace("\r", "");
            Assert.AreEqual("<<PRODUCT MOVEMENT IFC>><_DEFAULTS_>DATEFORMAT, DD/MM/YYYYDATETIMEFORMAT, DD/MM/YYYY HH24:MI:SS<ENDDEFAULTS><START MOVEMENT REC>MOVEMENT_ID,10072MOVEMENT_TYPE,MSTART_DATE_TIME,02/02/2021 12:00:00END_DATE_TIME,02/02/2021 12:00:00TEMPLATE_NAME,T-SAPREFERENCE,S_TTNOTES,<END MOVEMENT REC><START MOVEMENT DETAIL REC>MOVEMENT_ID,10072SOURCE_OR_DESTINATION,SEQUIPMENT,PRODUCT,RBOB8PACKAGE,START_QTY,END_QTY,10.000NET_QTY,10.000PACKAGE_COUNT,UNITS,LCOMPANY,REFERENCE,RAIL7529<END MOVEMENT DETAIL REC><START MOVEMENT DETAIL REC>MOVEMENT_ID,10072SOURCE_OR_DESTINATION,DEQUIPMENT,PRODUCT,RBOB8PACKAGE,START_QTY,END_QTY,NET_QTY,10.000PACKAGE_COUNT,UNITS,LCOMPANY,REFERENCE,RAIL7529<END MOVEMENT DETAIL REC><<PRODUCT MOVEMENT IFC>><<END OF FILE MARKER>>", contents);
        }

        [Test]
        public void TestSample4() {
            string json = File.ReadAllText(@"..\..\..\..\sampleFiles\CustodyTicket\Custody Ticket4.json");
            CustodyTicketBatch tix = CustodyTicketController.CreateHoneywellPBFile(json);
            Assert.AreEqual(2, tix.Tickets.Count);
        }

        [Test]
        public void TestSample5() {
            string json = File.ReadAllText(@"..\..\..\..\sampleFiles\CustodyTicket\Custody Ticket5.json");
            CustodyTicketBatch tixs = CustodyTicketController.CreateHoneywellPBFile(json);
            AzureModel.SaveCustodyTickets(tixs);
            Assert.AreEqual(1, tixs.Tickets.Count);
            Assert.AreEqual(1, tixs.Warnings.Count);
        }

        [Test]
        public void TestSample6() {
            string json = File.ReadAllText(@"..\..\..\..\sampleFiles\CustodyTicket\Custody Ticket6.json");
            CustodyTicketBatch tixs = CustodyTicketController.CreateHoneywellPBFile(json);
            AzureModel.SaveCustodyTickets(tixs);
            Assert.AreEqual(1, tixs.Tickets.Count);
            Assert.AreEqual(0, tixs.Warnings.Count);
        }

        [Test]
        public void TestBuilder() {
            string targetFile = File.ReadAllText(@"..\..\..\..\sampleFiles\CustodyTicket\SampleTicket.txt");
            CustodyTicket ct1 = new CustodyTicket(){ PostingDateTime = new DateTime(2020, 09, 14, 07, 43, 13), Plant = "CP03", ValuationType = "SUNCOR", EnteredBy = "",  S4MaterialDocument = "170552311-1", NetQuantitySizeInBuoe = 13507, HoneywellBol = "166438", Density = 0.7260M };
            CustodyTicket ct2 = new CustodyTicket() { PostingDateTime = new DateTime(2020, 09, 14, 07, 44, 13), Plant = "CP03", ValuationType = "SUNCOR", EnteredBy = "cbodie", S4MaterialDocument = "170552311-2", NetQuantitySizeInBuoe = 12961, HoneywellBol = "166438", Density = 0.8660M };
            ct1.LookupTag();
            ct2.LookupTag();

            List<CustodyTicket> tix = new List<CustodyTicket>();
            tix.Add(ct1);
            tix.Add(ct2);
            String generated = CustodyTicketController.CreateHoneywellPBFile(tix);
            Assert.AreEqual(targetFile, generated);
        }
    }
}
