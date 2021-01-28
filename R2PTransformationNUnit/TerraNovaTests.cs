using NUnit.Framework;
using R2PTransformation.src;
using R2PTransformation.src.db;
using System;
using System.Globalization;
using System.IO;
using System.Linq;

namespace STransformNUnit {
    public class TerraNovaTests {
        string ROOTDIR = @"..\..\..\..\sampleFiles\Terra Nova\";
        [SetUp]
        public void Setup() {
            DBContextWithConnectionString.SetConnectionString("");
        }

        [Test]
        public void testBase() {
            string dir = Directory.GetCurrentDirectory();
            TerraNovaFile ms = new TerraNovaParser().LoadFile(ROOTDIR + "OIL-STORAGE-CORR-LD_Raw.csv", "EP01", new DateTime(2019, 10, 03));
            Assert.AreEqual(3, ms.GetTagBalanceRecords().Count);
            Assert.AreEqual(7075.41, ms.GetTagBalanceRecords().Single(t=>t.BalanceDate == new DateTime(2019, 10,2)).Quantity);
        }

        [Test]
        public void test10dayPivot1() {
            TerraNovaFile ms = new TerraNovaParser().LoadFile(ROOTDIR + "OIL-STORAGE-CORR-LD_Raw.csv", "EP01", new DateTime(2019, 11, 01));
            Assert.AreEqual(32, ms.GetTagBalanceRecords().Count);
            Assert.AreEqual(1.887, ms.GetTagBalanceRecords().Single(t => t.BalanceDate == new DateTime(2019, 11, 1)).Quantity);
            Assert.AreEqual(3261.14, ms.GetTagBalanceRecords().Single(t => t.BalanceDate == new DateTime(2019, 10, 31)).Quantity);
        }

        [Test]
        public void test10daytest() {
            TerraNovaFile ms = new TerraNovaParser().LoadFile(ROOTDIR + "OIL-STORAGE-CORR-LD_Raw.csv", "EP01", new DateTime(2019, 10, 19));
            Assert.AreEqual(19, ms.GetTagBalanceRecords().Count);
            Assert.AreEqual(70.177, ms.GetTagBalanceRecords().Single(t => t.BalanceDate == new DateTime(2019, 10, 17)).Quantity);
        }

        [Test]
        public void test10dayPivot2() {
            TerraNovaFile ms = new TerraNovaParser().LoadFile(ROOTDIR + "OIL-STORAGE-CORR-LD_Raw.csv", "EP01", new DateTime(2019, 11, 11));  // after 10day pivot
            Assert.AreEqual(1, ms.GetTagBalanceRecords().Count);
            Assert.IsNull(ms.GetTagBalanceRecords().SingleOrDefault(t => t.BalanceDate == new DateTime(2019, 10, 31)));
        }

        [Test]
        public void test10dayPivot4() {
            TerraNovaFile ms = new TerraNovaParser().LoadFile(ROOTDIR + "OIL-STORAGE-CORR-LD_Raw.csv", "EP01", new DateTime(2019, 11, 9));  // before 10day pivot
            Assert.AreEqual(32, ms.GetTagBalanceRecords().Count);
            Assert.IsNotNull(ms.GetTagBalanceRecords().SingleOrDefault(t => t.BalanceDate == new DateTime(2019, 10, 31)));
        }

    }
}
