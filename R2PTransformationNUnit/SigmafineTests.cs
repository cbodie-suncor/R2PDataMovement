using NUnit.Framework;
using R2PTransformation.src;
using R2PTransformation.Models;
using System;
using System.Data;
using System.Globalization;
using System.IO;
using System.Linq;

namespace STransformNUnit {
    public class SigmafineTests {
        string ROOTDIR = @"..\..\..\..\sampleFiles\CommerceCity\";
        [SetUp]
        public void Setup() {
//            DBContextWithConnectionString.SetConnectionString("");
            DBContextWithConnectionString.SetConnectionString("Data Source=inmdevarmsvruw2001.database.windows.net;Initial Catalog=inmdevarmsqluw2001;User ID=suncorsqladmin;password=AdvancedAnalytics2020;");

        }
        /*  THSE TESTS ARE OBSOLETE....  WAS RELEVANT WHEN ACCESS THE SuncorReports database in denver, but decided to use the output from Crystal Reports 
        [Test]
        public void testSingleDay() {
            SigmafineFile ms = new SigmafineParser().Load(null, "GP02", new DateTime(2020, 7, 11));
            ms.SaveRecords();
            decimal found = ms.Products.Single(t =>t.BalanceDate == new DateTime(2020, 11,7) && t.Tag == "E_FCCGASOLN" ).Quantity.Value;
            Assert.AreEqual(-1173, found);
        }

        [Test]
        public void testAll() {
            SigmafineFile ms = new SigmafineParser().Load(null, "GP02", new DateTime(2020, 7, 11));
             ms.SaveRecords();
            string json = ms.ExportR2PJson();
            System.Console.WriteLine(json);
        }

        [Test]
        public void testOverrideWest() {
            SigmafineFile ms = new SigmafineParser().Load(ROOTDIR + "sigmafine20210101.csv", "GP01", new DateTime(2021, 1, 01));
            ms.SavedRecords = ms.GetTagBalanceRecords();
            string json = ms.ExportR2PJson();
            System.Console.WriteLine(json);
            ms.SaveRecords();
        }

        [Test]
        public void testOverrideAll() {
            SigmafineFile ms = new SigmafineParser().Load(ROOTDIR + "decjan.csv", "GP01", new DateTime(2021, 1, 01));
            ms.SavedRecords = ms.GetTagBalanceRecords();
            string json = ms.ExportR2PJson();
            System.Console.WriteLine(json);
            ms.SaveRecords();
        }
        [Test]
        public void testOverrideAll2() {
            SigmafineFile ms = new SigmafineParser().Load(ROOTDIR + "decjanTableDump.csv", "GP01", new DateTime(2021, 1, 01));
            ms.SavedRecords = ms.GetTagBalanceRecords();
            string json = ms.ExportR2PJson();
            System.Console.WriteLine(json);
            ms.SaveRecords();
        }
        [Test]
        public void testOverrideWest2() {
            SigmafineFile ms = new SigmafineParser().Load(ROOTDIR + "sigmafine2021106.csv", "GP01", new DateTime(2020, 7, 11));
            ms.SavedRecords = ms.GetTagBalanceRecords();
            string json = ms.ExportR2PJson();

        System.Console.WriteLine(json);
            ms.SaveRecords();
        }
        */

        [Test]
        public void testExcelLoadEP() {
            SuncorProductionFile ms = new SigmafineParser().LoadProductionExcel(ROOTDIR + "Jan 1 2021 EP.xls", "GP01", new DateTime(2021, 01, 31));
            ms.SavedRecords = ms.GetTagBalanceRecords();
            string json = ms.ExportProductionJson();
            System.Console.WriteLine(json);
            Assert.IsTrue(json.Length > 100);  // this ensure the json is more than just the header
            Assert.IsTrue(ms.SavedRecords.Count > 0);
            Assert.AreEqual("EP Sweet Crude Trucks", ms.SavedRecords[0].Tag);
            Assert.AreEqual(25474.019, ms.SavedRecords[0].Quantity);
            Assert.AreEqual(152064.373, ms.SavedRecords[0].OpeningInventory);
            Assert.AreEqual(152592.354, ms.SavedRecords[0].ClosingInventory);
            Assert.AreEqual(0, ms.SavedRecords[0].Shipment);
            Assert.AreEqual(26002, ms.SavedRecords[0].Receipt);
            //            ms.SaveRecords();
        }

        [Test]
        public void testExcelLoadWP() {
            SuncorProductionFile ms = new SigmafineParser().LoadProductionExcel(ROOTDIR + "Jan 1 2021 WP.xls", "GP02", new DateTime(2021, 01, 31));
            ms.SavedRecords = ms.GetTagBalanceRecords();
            string json = ms.ExportProductionJson();
            System.Console.WriteLine(json);
            Assert.IsTrue(json.Length > 100);  // this ensure the json is more than just the header
            Assert.IsTrue(ms.SavedRecords.Count > 0);
            Assert.AreEqual("Asphalt Unit Crude", ms.SavedRecords[0].Tag);
            Assert.AreEqual(36557.741, ms.SavedRecords[0].Quantity);
            //            ms.SaveRecords();
        }

        [Test]
        public void testInventoryLoad() {
            SuncorProductionFile ms = new SigmafineParser().LoadInventoryExcel(ROOTDIR + "031021 INVENTORY (with material codes).xls", "COMMERCECITY", new DateTime(2021, 03, 10));
            AzureModel.SaveInventory("asb", ms, ms.Inventory);
//            ms.SavedRecords = ms.GetTagBalanceRecords();
            string json = ms.ExportInventory();
            System.Console.WriteLine(json);
            Assert.IsTrue(json.Length > 100);  // this ensure the json is more than just the header
            Assert.IsTrue(ms.SavedInventoryRecords.Count > 0);
            Assert.AreEqual("ASPH_SOUR", ms.Inventory[0].Tag);
//            Assert.AreEqual("TK776", ms.SavedRecords[0].Tank);
            Assert.AreEqual(80874.578, ms.Inventory[0].Quantity);
            //            ms.SaveRecords();
        }

        [Test]
        public void testInventoryLoad2() {
            SuncorProductionFile ms = new SigmafineParser().LoadInventoryExcel(ROOTDIR + "031021 INVENTORY (with material codes)_WP.xls", "COMMERCECITY", new DateTime(2021, 03, 10));
            AzureModel.SaveInventory("asb", ms, ms.Inventory);
            //            ms.SavedRecords = ms.GetTagBalanceRecords();
            string json = ms.ExportInventory();
            System.Console.WriteLine(json);
            Assert.IsTrue(json.Length > 100);  // this ensure the json is more than just the header
            Assert.IsTrue(ms.SavedInventoryRecords.Count > 0);
            Assert.AreEqual("ASPH_SOUR", ms.Inventory[0].Tag);
            //            Assert.AreEqual("TK776", ms.SavedRecords[0].Tank);
            Assert.AreEqual(80874.578, ms.Inventory[0].Quantity);
            //            ms.SaveRecords();
        }
    }
}
