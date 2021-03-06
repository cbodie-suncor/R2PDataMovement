using NUnit.Framework;
using R2PTransformation.src;
using R2PTransformation.src.db;
using System;
using System.Globalization;
using System.IO;
using System.Linq;

namespace STransformNUnit {
    public class MontrealSulphurTests {
        string ROOTDIR = @"..\..\..\..\sampleFiles\Montreal Sulphur\";
        [SetUp]
        public void Setup() {
            DBContextWithConnectionString.SetConnectionString("");
        }

        [Test]
        public void TestWrongFileDesignation() {
            try {
                MontrealSulphurFile ms = new MontrealSulphurParser().LoadFile(ROOTDIR + "3 - 2020 Sulphur Production_V2.xlsx", "CP02", "2", new DateTime(2020, 07, 08));
            } catch(Exception ex) {
                Assert.AreEqual("invalid format for montreal sulphur", ex.Message);
                return;
            }
            Assert.Fail();
        }

        [Test]
        public void TestBlankMonth() {
            MontrealSulphurFile ms = new MontrealSulphurParser().LoadFile(ROOTDIR + "3 - 2020 Sulphur Production_V2.xlsx", "CP02", "3", new DateTime(2020, 07, 08));
            Assert.AreEqual(38, ms.GetTagBalanceRecords().Count);
            Assert.AreEqual(66.866, ms.GetTagBalanceRecords().Single(t => t.BalanceDate == new DateTime(2020, 6, 17)).Quantity);
        }

        [Test]
        public void testMontrealSulphurSBS() {
            MontrealSulphurFile ms = new MontrealSulphurParser().LoadFile(ROOTDIR + "2 - 2020 SBS Production.xlsx", "CP02", "2", new DateTime(2020, 12, 12));
            Assert.AreEqual(12, ms.GetTagBalanceRecords().Count);
            Assert.AreEqual(19.028, ms.GetTagBalanceRecords().Single(t => t.BalanceDate == new DateTime(2020, 12, 12)).Quantity);
        }

        [Test]
        public void testMontrealSulphurSBS2() {
            MontrealSulphurFile ms = new MontrealSulphurParser().LoadFile(ROOTDIR + "2 - 2020 SBS Production.xlsx", "CP02", "2", new DateTime(2020, 12, 9));
            Assert.AreEqual(39, ms.GetTagBalanceRecords().Count);
            Assert.AreEqual(23.443, ms.GetTagBalanceRecords().Single(t => t.BalanceDate == new DateTime(2020, 12, 5)).Quantity);
        }

        [Test]
        public void testMontrealSulphur() {
            MontrealSulphurFile ms = new MontrealSulphurParser().LoadFile(ROOTDIR + "3 - 2021 Sulphur Production.xlsx", "CP02", "3", new DateTime(2021, 01, 08));
            Assert.AreEqual(8, ms.GetTagBalanceRecords().Count);
            Assert.AreEqual(30.877, ms.GetTagBalanceRecords().Single(t => t.BalanceDate == new DateTime(2021, 1, 6)).Quantity);
        }

        [Test]
        public void testMontrealSulphurCaustic() {
            MontrealSulphurFile ms = new MontrealSulphurParser().LoadFile(ROOTDIR + "5 - 2021 Caustic Consumption.xlsx", "CP02", "5", new DateTime(2021, 01, 13));
            Assert.AreEqual(13, ms.GetTagBalanceRecords().Count);
            Assert.AreEqual(-9.975, ms.GetTagBalanceRecords().Single(t => t.BalanceDate == new DateTime(2021, 1, 5)).Quantity);
        }
    }
}
