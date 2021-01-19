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
            DBContextWithConnectionString.SetConnectionString("Data Source=(local);Initial Catalog=suncor;Integrated Security=True;MultipleActiveResultSets=True;");
        }

        [Test]
        public void testParseDate() {
//            var accountDate = DateTime.ParseExact("28/09/2020 00:59:00", "DD/MM/YYYY HH24:MI:SS", CultureInfo.InvariantCulture);
            var accountDate = DateTime.ParseExact("28/09/2020 13:59:00", "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture);
        }

        [Test]
        public void testMontrealSulphurSBS() {
            string json = "";
            try { 
            MontrealSulphurFile ms = new MontrealSulphurParser().LoadFile(ROOTDIR + "2 - 2020 SBS Production.xlsx", "CP02", "2", testDate);
                ms.SaveRecords();
                json = ms.ExportR2PJson();
                System.Console.WriteLine(json);
                SuncorProductionFile.LogSuccess(ms.FileName, ms, ms.GetTagBalanceRecords().Count, ms.FailedRecords.Count);
            } catch (Exception ex) {
                SuncorProductionFile.Log("CP02", ex);
            }
            File.WriteAllText(ROOTDIR + "2 - 2020 SBS Production.json", json);
            Assert.IsTrue(json.Length > 0);
        }

        DateTime testDate = new DateTime(2021, 01, 08);
        [Test]
        public void testMontrealSulphur() {
            string json = "";
            try {
                MontrealSulphurFile ms = new MontrealSulphurParser().LoadFile(ROOTDIR + "3 - 2021 Sulphur Production.xlsx", "CP02", "3", testDate);
                ms.SaveRecords();
                json = ms.ExportR2PJson();
                System.Console.WriteLine(json);
                SuncorProductionFile.LogSuccess(ms.FileName, ms, ms.GetTagBalanceRecords().Count, ms.FailedRecords.Count);
            } catch (Exception ex) {
                SuncorProductionFile.Log("CP02", ex);
            }
            File.WriteAllText(ROOTDIR + "2 - 2020 SBS Production.json", json);
            Assert.IsTrue(json.Length > 0);
        }

        [Test]
        public void testMontrealSulphurCaustic() {
            string json = "";
            MontrealSulphurFile ms = new MontrealSulphurParser().LoadFile(ROOTDIR + "5 - 2021 Caustic Consumption.xlsx", "CP02", "5", testDate);
            ms.SaveRecords();
            json = ms.ExportR2PJson();
            System.Console.WriteLine(json);
            SuncorProductionFile.LogSuccess(ms.FileName, ms, ms.GetTagBalanceRecords().Count, ms.FailedRecords.Count);
            File.WriteAllText(@"D:\projects\suncor\sampleFiles\2 - 2020 SBS Production.json", json);
            Assert.IsTrue(json.Length > 0);
            Assert.AreEqual(-11.036, ms.Products.Single(t => t.BalanceDate == new DateTime(2021, 1, 6)).Quantity);
        }
    }
}
