using NUnit.Framework;
using R2PTransformation.src;
using R2PTransformation.src.db;
using System;
using System.Globalization;
using System.IO;
using System.Linq;

namespace STransformNUnit {
    public class DPSTests {
        string ROOTDIR = @"..\..\..\..\sampleFiles\Oilsands\";

        [SetUp]
        public void Setup() {
        }

        [Test]
        public void testAP01() {
            DPSFile ms = new DPSParser().LoadFile(ROOTDIR + "Base Plant Sample_AP01.xlsx", "AP01", new DateTime(2020, 10, 25));
            Assert.AreEqual(9, ms.GetTagBalanceRecords().Count);
        }

        [Test]
        public void testAP02() {
            DPSFile ms = new DPSParser().LoadFile(ROOTDIR + "Firebag Sample_AP02.xlsx", "AP02", new DateTime(2020, 10, 31));
            Assert.AreEqual(3, ms.GetTagBalanceRecords().Count);
            Assert.AreEqual(-466.231, ms.GetTagBalanceRecords().Single(t => t.BalanceDate == new DateTime(2020, 10, 24)).Quantity);
        }

        [Test]
        public void testAP03() {
            DPSFile ms = new DPSParser().LoadFile(ROOTDIR + "Mackay River Sample_AP03.xlsx", "AP03", new DateTime(2020, 10, 31));
            Assert.AreEqual(6, ms.GetTagBalanceRecords().Count);
        }

        [Test]
        public void testDateParseForDPS() {
            DateTime dt = DateTime.ParseExact("24/01/2013", "dd/MM/yyyy", CultureInfo.InvariantCulture);
            DateTime dt2 = DateTime.ParseExact("22-10-2020", "dd-MM-yyyy", CultureInfo.InvariantCulture);
        }
    }
}
