using NUnit.Framework;
using R2PTransformation.src;
using R2PTransformation.src.db;
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
            DBContextWithConnectionString.SetConnectionString("");
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
            SigmafineFile ms = new SigmafineParser().LoadExcel(ROOTDIR + "Jan 1 2021 EP.xls", "GP01");
            ms.SavedRecords = ms.GetTagBalanceRecords();
            string json = ms.ExportR2PJson();
            System.Console.WriteLine(json);
            Assert.IsTrue(json.Length > 100);  // this ensure the json is more than just the header
            Assert.IsTrue(ms.SavedRecords.Count > 0);
            Assert.AreEqual("EP Sweet Crude Trucks", ms.SavedRecords[0].Tag);
            Assert.AreEqual(25474, ms.SavedRecords[0].Quantity);
            //            ms.SaveRecords();
        }

        [Test]
        public void testExcelLoadWP() {
            SigmafineFile ms = new SigmafineParser().LoadExcel(ROOTDIR + "Jan 1 2021 WP.xls", "GP02");
            ms.SavedRecords = ms.GetTagBalanceRecords();
            string json = ms.ExportR2PJson();
            System.Console.WriteLine(json);
            Assert.IsTrue(json.Length > 100);  // this ensure the json is more than just the header
            Assert.IsTrue(ms.SavedRecords.Count > 0);
            Assert.AreEqual("Asphalt Unit Crude", ms.SavedRecords[0].Tag);
            Assert.AreEqual(36558, ms.SavedRecords[0].Quantity);
            //            ms.SaveRecords();
        }
    }
}
