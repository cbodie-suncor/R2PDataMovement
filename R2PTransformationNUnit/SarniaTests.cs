using NUnit.Framework;
using R2PTransformation;
using R2PTransformation.src;
using R2PTransformation.src.db;
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
            DBContextWithConnectionString.SetConnectionString("");
        }

        [Test]
        public void testBase() {
            string dir = Directory.GetCurrentDirectory();
            List<ShellSplit> ss = SarniaParser.LoadULSDSplits(ROOTDIR + "PHD Sarnia ULSD Processing - March2021 rev2_WITH LOGIC_V2.xlsm", new DateTime(2021, 3, 25));
            Assert.AreEqual(150, ss.Count);
            Assert.AreEqual(912.248, ss.First(t => t.Day == new DateTime(2021, 03, 03) && t.ProductCode == "DIESEL").Volume);
       }

        [Test]
        public void HoneywellPBLoadOnly() {
            HoneywellPBFile pf = new HoneywellPBParser().LoadFile(ROOTDIR + "NPUpld-20210104.txt", "CP03", new DateTime(2021, 3, 25));
            Assert.IsTrue(pf.Values.ContainsKey("ACCOUNT_DATE"));
            Assert.IsTrue(pf.Values.ContainsKey("REFINERY_GAIN_LOSS"));
            Assert.IsTrue(pf.Defaults.ContainsKey("DATEFORMAT"));
            Assert.IsTrue(pf.BalanceRecords[0].Values.ContainsKey("BALANCE_GROUP_NAME"));
            Assert.IsTrue(pf.BalanceRecords[0].ProductionRecords.Count > 0);
        }
    }
}
