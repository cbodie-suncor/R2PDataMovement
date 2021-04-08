using Newtonsoft.Json;
using NUnit.Framework;
using R2PTransformation;
using R2PTransformation.src;
using R2PTransformation.Models;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Linq;

namespace STransformNUnit {
    public class HoneywellPBTests {
        string ROOTDIR = @"..\..\..\..\sampleFiles\honeywellPB\";
        [SetUp]
        public void Setup() {
            DBContextWithConnectionString.SetConnectionString("");
        }

        [Test]
        public void Test1() {
            HoneywellPBFile pf = new HoneywellPBParser().LoadFile(ROOTDIR + "NPUpld-20200928-005900M.txt", "CP01", DateTime.Now);
            Assert.IsTrue(pf.Values.ContainsKey("ACCOUNT_DATE"));
            Assert.IsTrue(pf.Values.ContainsKey("REFINERY_GAIN_LOSS"));
            Assert.IsTrue(pf.Defaults.ContainsKey("DATEFORMAT"));
            Assert.IsTrue(pf.BalanceRecords[0].Values.ContainsKey("BALANCE_GROUP_NAME"));
            Assert.IsTrue(pf.BalanceRecords[0].ProductionRecords.Count > 0);
//            Assert.IsTrue(pf.BalanceRecords[0].ProductionRecords.Count == 38);
            foreach (var pr in pf.BalanceRecords[0].ProductionRecords) {
                decimal netYield = pr.GetDecimalValue("NET_YIELD");
                decimal AMMDT = pr.GetAMMDTQuantity();
            }
        }

        [Test]
        public void HoneywellPBLoadOnly() {
            HoneywellPBFile pf = new HoneywellPBParser().LoadFile(ROOTDIR + "NPUpld-20200928-005900M.txt", "CP01", DateTime.Now);
            Assert.IsTrue(pf.Values.ContainsKey("ACCOUNT_DATE"));
            Assert.IsTrue(pf.Values.ContainsKey("REFINERY_GAIN_LOSS"));
            Assert.IsTrue(pf.Defaults.ContainsKey("DATEFORMAT"));
            Assert.IsTrue(pf.BalanceRecords[0].Values.ContainsKey("BALANCE_GROUP_NAME"));
            Assert.IsTrue(pf.BalanceRecords[0].ProductionRecords.Count > 0);
        }

        [Test]
        public void LoadHoneyWell3() {
            HoneywellPBFile pf = new HoneywellPBParser().LoadFile(ROOTDIR + "NPUpld-20200129-005900M_EDM.txt", "CP04", new DateTime(2020, 01,31));
            Assert.AreEqual(38, pf.GetTagBalanceRecords().Count);
            Assert.AreEqual(0, pf.FailedRecords);
            Assert.AreEqual(-1105871.000, pf.GetTagBalanceRecords().Single(t => t.BalanceDate.Date == new DateTime(2020, 1, 29) && t.Tag == "BCNRL").Quantity);
        }

        [Test]
        public void LoadHoneyWell4() {
            HoneywellPBFile pf = new HoneywellPBParser().LoadFile(ROOTDIR + "NPUpld-20200129-005900M_EDM.txt", "CP04", new DateTime(2020, 01, 31));
            Assert.AreEqual(38, pf.GetTagBalanceRecords().Count);
            Assert.AreEqual(0, pf.FailedRecords);
            Assert.AreEqual(2303, pf.GetTagBalanceRecords().Single(t => t.BalanceDate.Date == new DateTime(2020, 1, 29) && t.Tag == "MGO").Quantity);
            Assert.AreEqual(2564005, pf.GetTagBalanceRecords().Single(t => t.BalanceDate.Date == new DateTime(2020, 1, 29) && t.Tag == "MGO").OpeningInventory);
            Assert.AreEqual(2464331, pf.GetTagBalanceRecords().Single(t => t.BalanceDate.Date == new DateTime(2020, 1, 29) && t.Tag == "MGO").ClosingInventory);
            Assert.AreEqual(101977, pf.GetTagBalanceRecords().Single(t => t.BalanceDate.Date == new DateTime(2020, 1, 29) && t.Tag == "MGO").Shipment);
            Assert.AreEqual(0, pf.GetTagBalanceRecords().Single(t => t.BalanceDate.Date == new DateTime(2020, 1, 29) && t.Tag == "MGO").Receipt);
            Assert.AreEqual(36266, pf.GetTagBalanceRecords().Single(t => t.BalanceDate.Date == new DateTime(2020, 1, 29) && t.Tag == "PEFLGNF").Consumption);
        }
        [Test]
        public void LoadHoneyWell5() {
            HoneywellPBFile pf = new HoneywellPBParser().LoadFile(ROOTDIR + "NPUpld-20200930-005900M_MTL.txt", "CP01", new DateTime(2020, 09, 30));
            Assert.AreEqual(129, pf.GetTagBalanceRecords().Count);
            Assert.AreEqual(800342.050M, pf.GetTagBalanceRecords().Single(t => t.BalanceDate.Date == new DateTime(2020, 9, 30) && t.Tag == "14GZ_COMB_RAFFR").Quantity);
        }
    }
}
