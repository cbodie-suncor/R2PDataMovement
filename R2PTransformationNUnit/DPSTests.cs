using NUnit.Framework;
using R2PTransformation.src;
using R2PTransformation.Models;
using System;
using System.Globalization;
using System.IO;
using System.Linq;

namespace STransformNUnit {
    public class DPSTests {
        string ROOTDIR = @"..\..\..\..\sampleFiles\Oilsands\";

        [SetUp]
        public void Setup() {
            DBContextWithConnectionString.SetConnectionString(null);
        }

        [Test]
        public void testAP01() {
            SuncorProductionFile ms = new DPSParser().LoadFile(ROOTDIR + "Base Plant Sample_AP01_V2.xlsx", "AP01", new DateTime(2020, 10, 25));
            Assert.AreEqual(9, ms.GetTagBalanceRecords().Count);
        }

        [Test]
        public void testAP01_2() {
            SuncorProductionFile ms = new DPSParser().LoadFile(ROOTDIR + "Base Plant Sample_AP01withInventories.xlsx", "AP01", new DateTime(2021, 03, 25));
            Assert.AreEqual(25, ms.GetTagBalanceRecords().Count);
            Assert.AreEqual(2540.972, ms.GetTagBalanceRecords().Single(y=>y.BalanceDate == new DateTime(2021,3,25)).ClosingInventory);
            Assert.AreEqual(81, ms.GetTagBalanceRecords().Single(y => y.BalanceDate == new DateTime(2021, 3, 25)).Quantity);
        }

        [Test]
        public void testAP02() {
            SuncorProductionFile ms = new DPSParser().LoadFile(ROOTDIR + "Firebag Sample_AP02.xlsx", "AP02", new DateTime(2020, 10, 31));
            Assert.AreEqual(3, ms.GetTagBalanceRecords().Count);
            Assert.AreEqual(-466.231, ms.GetTagBalanceRecords().Single(t => t.BalanceDate == new DateTime(2020, 10, 24)).Quantity);
        }

        [Test]
        public void testAP03() {
            SuncorProductionFile ms = new DPSParser().LoadFile(ROOTDIR + "Mackay River Sample_AP03.xlsx", "AP03", new DateTime(2020, 10, 31));
            Assert.AreEqual(6, ms.GetTagBalanceRecords().Count);
        }

        [Test]
        public void testAP03Failed() {
            SuncorProductionFile ms = new DPSParser().LoadFile(ROOTDIR + "Mackay River Sample_AP03.20210225015419.xlsx", "AP03", new DateTime(2020, 10, 31));
            Assert.AreEqual(6, ms.GetTagBalanceRecords().Count);
        }

        [Test]
        public void testDateParseForDPS() {
            DateTime dt = DateTime.ParseExact("24/01/2013", "dd/MM/yyyy", CultureInfo.InvariantCulture);
            DateTime dt2 = DateTime.ParseExact("22-10-2020", "dd-MM-yyyy", CultureInfo.InvariantCulture);
        }
    }
}
