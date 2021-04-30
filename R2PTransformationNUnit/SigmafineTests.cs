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
            DBContextWithConnectionString.CreateTestContext();
        }

        [Test]
        public void testExcelLoadEP() {
            var bytes = File.ReadAllBytes(ROOTDIR + "Jan 1 2021 EP.xls");
            SuncorProductionFile ms = new SigmafineParser().LoadProductionExcel(bytes, "GP01", new DateTime(2021, 01, 31));
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
            var bytes = File.ReadAllBytes(ROOTDIR + "Jan 1 2021 WP.xls");
            SuncorProductionFile ms = new SigmafineParser().LoadProductionExcel(bytes, "GP02", new DateTime(2021, 01, 31));
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
            var bytes = File.ReadAllBytes(ROOTDIR + "031021 INVENTORY (with material codes).xls");
            SuncorProductionFile ms = new SigmafineParser().LoadInventoryExcel(bytes, "COMMERCECITY", new DateTime(2021, 03, 10));
            AzureModel.SaveInventory("filename", ms, ms.Inventory);
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
            var bytes = File.ReadAllBytes(ROOTDIR + "031021 INVENTORY (with material codes)_WP.xls");
            SuncorProductionFile ms = new SigmafineParser().LoadInventoryExcel(bytes, "COMMERCECITY", new DateTime(2021, 03, 10));
            AzureModel.SaveInventory("filename", ms, ms.Inventory);
            //            ms.SavedRecords = ms.GetTagBalanceRecords();
            string json = ms.ExportInventory();
            System.Console.WriteLine(json);
            Assert.IsTrue(json.Length > 140);  // this ensure the json is more than just the header
            Assert.IsTrue(ms.SavedInventoryRecords.Count > 0);
            Assert.AreEqual("ASPH_SOUR", ms.Inventory[0].Tag);
            //            Assert.AreEqual("TK776", ms.SavedRecords[0].Tank);
            Assert.AreEqual(80874.578, ms.Inventory[0].Quantity);
            //            ms.SaveRecords();
        }
    }
}
