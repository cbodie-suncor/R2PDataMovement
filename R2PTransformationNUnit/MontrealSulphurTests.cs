using NUnit.Framework;
using R2PTransformation.src;
using R2PTransformation.Models;
using System;
using System.Globalization;
using System.IO;
using System.Linq;

namespace STransformNUnit {
    public class MontrealSulphurTests {
        string ROOTDIR = @"..\..\..\..\sampleFiles\Montreal Sulphur\";
        [SetUp]
        public void Setup() {
            DBContextWithConnectionString.CreateTestContext();
        }

        [Test]
        public void TestWrongFileDesignation() {
            try {
                var bytes = File.ReadAllBytes(ROOTDIR + "3 - 2020 Sulphur Production_V2.xlsx");
                MontrealSulphurFile ms = new MontrealSulphurParser().LoadFile(bytes, "CP02", "2", new DateTime(2020, 07, 08));
            } catch(Exception ex) {
                Assert.AreEqual("invalid format for montreal sulphur", ex.Message);
                return;
            }
            Assert.Fail();
        }

        [Test]
        public void TestBlankMonth() {
            var bytes = File.ReadAllBytes(ROOTDIR + "3 - 2020 Sulphur Production_V2.xlsx");
            MontrealSulphurFile ms = new MontrealSulphurParser().LoadFile(bytes, "CP02", "3", new DateTime(2020, 07, 08));
            Assert.AreEqual(38, ms.GetTagBalanceRecords().Count);
            Assert.AreEqual(66.866, ms.GetTagBalanceRecords().Single(t => t.BalanceDate == new DateTime(2020, 6, 17)).Quantity);
        }

        [Test]
        public void testMontrealSulphurSBS() {
            var bytes = File.ReadAllBytes(ROOTDIR + "2 - 2020 SBS Production.xlsx");
            MontrealSulphurFile ms = new MontrealSulphurParser().LoadFile(bytes, "CP02", "2", new DateTime(2020, 12, 12));
            Assert.AreEqual(12, ms.GetTagBalanceRecords().Count);
            Assert.AreEqual(19.028, ms.GetTagBalanceRecords().Single(t => t.BalanceDate == new DateTime(2020, 12, 12)).Quantity);
            Assert.AreEqual(259.66, ms.GetTagBalanceRecords().Single(t => t.BalanceDate == new DateTime(2020, 12, 12)).OpeningInventory);
            Assert.AreEqual(203.476, ms.GetTagBalanceRecords().Single(t => t.BalanceDate == new DateTime(2020, 12, 12)).ClosingInventory);
            Assert.AreEqual(40.378, ms.GetTagBalanceRecords().Single(t => t.BalanceDate == new DateTime(2020, 12, 12)).Shipment);
            Assert.AreEqual(0, ms.GetTagBalanceRecords().Single(t => t.BalanceDate == new DateTime(2020, 12, 12)).Receipt);
        }

        [Test]
        public void testMontrealSulphurSBS2() {
            var bytes = File.ReadAllBytes(ROOTDIR + "2 - 2020 SBS Production.xlsx");
            MontrealSulphurFile ms = new MontrealSulphurParser().LoadFile(bytes, "CP02", "2", new DateTime(2020, 12, 9));
            Assert.AreEqual(39, ms.GetTagBalanceRecords().Count);
            Assert.AreEqual(23.443, ms.GetTagBalanceRecords().Single(t => t.BalanceDate == new DateTime(2020, 12, 5)).Quantity);
        }

        [Test]
        public void testMontrealSulphur() {
            var bytes = File.ReadAllBytes(ROOTDIR + "3 - 2021 Sulphur Production.xlsx");

            MontrealSulphurFile ms = new MontrealSulphurParser().LoadFile(bytes, "CP02", "3", new DateTime(2021, 01, 08));
            Assert.AreEqual(8, ms.GetTagBalanceRecords().Count);
            Assert.AreEqual(30.877, ms.GetTagBalanceRecords().Single(t => t.BalanceDate == new DateTime(2021, 1, 6)).Quantity);
            Assert.AreEqual(558.183, ms.GetTagBalanceRecords().Single(t => t.BalanceDate == new DateTime(2021, 1, 6)).OpeningInventory);
            Assert.AreEqual(589.002, ms.GetTagBalanceRecords().Single(t => t.BalanceDate == new DateTime(2021, 1, 6)).ClosingInventory);
            Assert.AreEqual(32.058, ms.GetTagBalanceRecords().Single(t => t.BalanceDate == new DateTime(2021, 1, 6)).Shipment);
            Assert.AreEqual(32, ms.GetTagBalanceRecords().Single(t => t.BalanceDate == new DateTime(2021, 1, 6)).Receipt);
        }

        [Test]
        public void testMontrealSulphurCaustic() {
            var bytes = File.ReadAllBytes(ROOTDIR + "5 - 2021 Caustic Consumption.xlsx");
            MontrealSulphurFile ms = new MontrealSulphurParser().LoadFile(bytes, "CP02", "5", new DateTime(2021, 01, 13));
            Assert.AreEqual(6, ms.GetTagBalanceRecords().Count);
            Assert.AreEqual(-9.975, ms.GetTagBalanceRecords().Single(t => t.BalanceDate == new DateTime(2021, 1, 5)).Quantity);
            Assert.AreEqual(72.476, ms.GetTagBalanceRecords().Single(t => t.BalanceDate == new DateTime(2021, 1, 5)).OpeningInventory);
            Assert.AreEqual(80.955, ms.GetTagBalanceRecords().Single(t => t.BalanceDate == new DateTime(2021, 1, 5)).ClosingInventory);
            Assert.AreEqual(18.454, ms.GetTagBalanceRecords().Single(t => t.BalanceDate == new DateTime(2021, 1, 5)).Receipt);
            Assert.AreEqual(0, ms.GetTagBalanceRecords().Single(t => t.BalanceDate == new DateTime(2021, 1, 5)).Shipment);
        }
    }
}
