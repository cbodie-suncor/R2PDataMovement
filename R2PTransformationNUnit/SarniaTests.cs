using NUnit.Framework;
using R2PTransformation;
using R2PTransformation.src;
using R2PTransformation.Models;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Linq;
using static R2PTransformation.src.SarniaParser;

namespace STransformNUnit {
    public class SarniaTests {
        string ROOTDIR = @"..\..\..\..\sampleFiles\CP03\";
        [SetUp]
        public void Setup() {
//            DBContextWithConnectionString.SetConnectionString("");
            DBContextWithConnectionString.SetConnectionString("Data Source=inmdevarmsvruw2001.database.windows.net;Initial Catalog=inmdevarmsqluw2001;User ID=suncorsqladmin;password=AdvancedAnalytics2020;");
        }

        [Test]
        public void testULSD() {
            string dir = Directory.GetCurrentDirectory();
            List<ShellSplit> ss = SarniaParser.LoadULSDSplits(ROOTDIR + "PHD Sarnia ULSD Processing - March2021 rev2_WITH LOGIC_V2.xlsm");
            Assert.AreEqual(150, ss.Count);
            Assert.AreEqual(912.248, ss.First(t => t.Day == new DateTime(2021, 03, 03) && t.ProductCode == "DIESEL").Volume);
        }

        [Test]
        public void testULSDWithUpdate() {
            string dir = Directory.GetCurrentDirectory();
            List<ShellSplit> ss = SarniaParser.LoadULSDSplits(ROOTDIR + "PHD Sarnia ULSD Processing - March 2021.forupdate.xlsm");
            Assert.AreEqual(75, ss.Count);
            Assert.AreEqual(3.111, ss.First(t => t.Day == new DateTime(2021, 03, 03) && t.ProductCode == "DIESEL").Volume);
        }

        [Test]
        public void HoneywellPBLoadOnly() {
            HoneywellPBFile pf = new HoneywellPBParser().LoadFile(ROOTDIR + "NPUpld-20210104.txt", "CP03", new DateTime(2021, 3, 25));
            Assert.IsTrue(pf.Values.ContainsKey("ACCOUNT_DATE"));
            Assert.IsTrue(pf.Values.ContainsKey("REFINERY_GAIN_LOSS"));
            Assert.IsTrue(pf.Defaults.ContainsKey("DATEFORMAT"));
            Assert.IsTrue(pf.BalanceRecords[0].Values.ContainsKey("BALANCE_GROUP_NAME"));
            Assert.IsTrue(pf.BalanceRecords[0].ProductionRecords.Count > 0);
            Assert.AreEqual(-102164224, pf.GetTagBalanceRecords().First(t => t.Tag == "DIESEL").Quantity);
        }

        [Test]
        public void HoneywellPBLoadAndTestSplit() {
            DateTime currentDay = new DateTime(2021, 3, 25);
            HoneywellPBFile pf = new HoneywellPBParser().LoadFile(ROOTDIR + "NPUpld-20210104.txt", "CP03", currentDay);
            List<ShellSplit> ss = SarniaParser.LoadULSDSplits(ROOTDIR + "PHD Sarnia ULSD Processing - March2021 rev2_WITH LOGIC_V2.xlsm");
            Assert.AreEqual(-102164224, pf.GetTagBalanceRecords().Single(t => t.Tag == "DIESEL").Quantity);
            SarniaParser.ApplyShellSplits(pf, ss);
            Assert.AreEqual(912.248, ss.First(t => t.Day == new DateTime(2021, 03, 03) && t.ProductCode == "DIESEL").Volume);
            Assert.AreEqual(-102164224, pf.GetTagBalanceRecords().Single(t => t.Tag == "DIESEL" && t.ValType == "Presplit").Quantity);
            Assert.AreEqual(271.682, pf.GetTagBalanceRecords().Single(t => t.Tag == "DIESEL" && t.ValType == "Shell").Quantity);
            Assert.AreEqual(-102164495.682, pf.GetTagBalanceRecords().Single(t => t.Tag == "DIESEL" && t.ValType == "SUNCOR").Quantity);


            //            SarniaParser.UpdateShellSplits(ss, currentDay);
            Assert.IsTrue(pf.BalanceRecords[0].ProductionRecords.Count > 0);
            Assert.AreEqual(-102164224, pf.GetTagBalanceRecords().First(t => t.Tag == "DIESEL").Quantity);
        }
    }
}
