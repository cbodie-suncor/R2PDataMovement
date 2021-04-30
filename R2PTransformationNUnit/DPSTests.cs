using NUnit.Framework;
using R2PTransformation.src;
using R2PTransformation.Models;
using System;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Text;
using ExcelDataReader;
using System.Data;

namespace STransformNUnit {
    public class DPSTests {
        string ROOTDIR = @"..\..\..\..\sampleFiles\Oilsands\";

        [SetUp]
        public void Setup() {
            DBContextWithConnectionString.CreateTestContext();
        }

        [Test]
        public void testAP01() {
            try {
                var bytes = File.ReadAllBytes(ROOTDIR + "Base Plant Sample_AP01_V2.xlsx");
                SuncorProductionFile ms = new DPSParser().LoadFile(bytes, "AP01", new DateTime(2020, 10, 25));
            } catch (Exception ex) {
                Assert.AreEqual("The sheet 'Azure Load' does not exist", ex.Message);
                return;
            }
            Assert.Fail();
        }

        [Test]
        public void testAP01_2() {
            var bytes = File.ReadAllBytes(ROOTDIR + "Base Plant Sample_AP01withInventories.xlsx");
            SuncorProductionFile ms = new DPSParser().LoadFile(bytes, "AP01", new DateTime(2021, 03, 25));
            Assert.AreEqual(25, ms.GetTagBalanceRecords().Count);
            Assert.AreEqual(2540.972, ms.GetTagBalanceRecords().Single(y=>y.BalanceDate == new DateTime(2021,3,25)).ClosingInventory);
            Assert.AreEqual(81, ms.GetTagBalanceRecords().Single(y => y.BalanceDate == new DateTime(2021, 3, 25)).Quantity);
        }

        [Test]
        public void testAP02() {
            var bytes = File.ReadAllBytes(ROOTDIR + "Firebag Sample_AP02.xlsx");
            SuncorProductionFile ms = new DPSParser().LoadFile(bytes, "AP02", new DateTime(2020, 10, 31));
            Assert.AreEqual(3, ms.GetTagBalanceRecords().Count);
            Assert.AreEqual(-466.231, ms.GetTagBalanceRecords().Single(t => t.BalanceDate == new DateTime(2020, 10, 24)).Quantity);
        }

        [Test]
        public void testAP03() {
            var bytes = File.ReadAllBytes(ROOTDIR + "Mackay River Sample_AP03.xlsx");
            SuncorProductionFile ms = new DPSParser().LoadFile(bytes, "AP03", new DateTime(2020, 10, 31));
            Assert.AreEqual(6, ms.GetTagBalanceRecords().Count);
        }

        [Test]
        public void testAP03Failed() {
            var bytes = File.ReadAllBytes(ROOTDIR + "Mackay River Sample_AP03.20210225015419.xlsx");
            SuncorProductionFile ms = new DPSParser().LoadFile(bytes, "AP03", new DateTime(2020, 10, 31));
            Assert.AreEqual(6, ms.GetTagBalanceRecords().Count);
        }

        [Test]
        public void testDateParseForDPS() {
            DateTime dt = DateTime.ParseExact("24/01/2013", "dd/MM/yyyy", CultureInfo.InvariantCulture);
            DateTime dt2 = DateTime.ParseExact("22-10-2020", "dd-MM-yyyy", CultureInfo.InvariantCulture);
        }
        /*
        [Test]
        public void tesMemory() {
            byte[] allBytes = File.ReadAllBytes(ROOTDIR + "Firebag Sample_AP02.xlsx");
                Encoding.RegisterProvider(CodePagesEncodingProvider.Instance);
            MemoryStream stream = new MemoryStream(allBytes);
            using (var reader = ExcelReaderFactory.CreateReader(stream)) {
                var result = reader.AsDataSet(new ExcelDataSetConfiguration() {
                    ConfigureDataTable = (data) => new ExcelDataTableConfiguration() {
                        UseHeaderRow = true
                    }
                });

                DataTableCollection table = result.Tables;
                if (table.IndexOf("Azure Load") == -1) throw new Exception("The sheet 'Azure Load' does not exist");
                DataTable currentMonthSheet = table["Azure Load"];
                Assert.IsTrue(currentMonthSheet.Rows.Count > 0);
                //                        LoadProductionRecords(currentMonthSheet, ms, currentDay);
            }
        }
        */
    }
}
