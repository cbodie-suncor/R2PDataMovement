using NUnit.Framework;
using R2PTransformation.src;
using R2PTransformation.src.db;
using System;
using System.Globalization;
using System.IO;
using System.Linq;

namespace STransformNUnit {
    public class DPSTests {
        [SetUp]
        public void Setup() {
            DBContextWithConnectionString.SetConnectionString("Data Source=(local);Initial Catalog=suncor;Integrated Security=True;MultipleActiveResultSets=True;");
        }

        [Test]
        public void testAP01() {
            string json = "";
            try {
                DPSFile ms = new DPSParser().LoadFile(@"D:\projects\suncor\sampleFiles\Oil Sands\Base Plant Sample_AP01.xlsx", "AP01", new DateTime(2020, 09, 01));
                ms.SaveRecords();
                json = ms.ExportR2PJson();
                System.Console.WriteLine(json);
                SuncorProductionFile.LogSuccess(ms.FileName, ms, ms.GetTagBalanceRecords().Count, ms.FailedRecords.Count);
            } catch (Exception ex) {
                SuncorProductionFile.Log("AP01", ex);
            }
            File.WriteAllText(@"D:\projects\suncor\sampleFiles\Oil Sands\Base Plant Sample_AP01.json", json);
            Assert.IsTrue(json.Length > 0);
        }

        [Test]
        public void testAP02() {
            string json = "";
            try {
                DPSFile ms = new DPSParser().LoadFile(@"D:\projects\suncor\sampleFiles\Oil Sands\Firebag Sample_AP02.xlsx", "AP02", new DateTime(2020, 09, 01));
                ms.SaveRecords();
                json = ms.ExportR2PJson();
                System.Console.WriteLine(json);
                SuncorProductionFile.LogSuccess(ms.FileName, ms, ms.GetTagBalanceRecords().Count, ms.FailedRecords.Count);
            } catch (Exception ex) {
                SuncorProductionFile.Log("AP02", ex);
            }
            File.WriteAllText(@"D:\projects\suncor\sampleFiles\Oil Sands\Firebag Sample_AP02.json", json);
            Assert.IsTrue(json.Length > 0);
        }

        [Test]
        public void testAP03() {
            string json = "";
            try {
                DPSFile ms = new DPSParser().LoadFile(@"D:\projects\suncor\sampleFiles\Oil Sands\Mackay River Sample_AP03.xlsx", "AP03", new DateTime(2020, 09, 01));
                ms.SaveRecords();
                json = ms.ExportR2PJson();
                System.Console.WriteLine(json);
                SuncorProductionFile.LogSuccess(ms.FileName, ms, ms.GetTagBalanceRecords().Count, ms.FailedRecords.Count);
            } catch (Exception ex) {
                SuncorProductionFile.Log("AP03", ex);
            }
            File.WriteAllText(@"D:\projects\suncor\sampleFiles\Oil Sands\Mackay River Sample_AP03.json", json);
            Assert.IsTrue(json.Length > 0);
        }

        [Test]
        public void testDateParseForDPS() {
//            var date = DateTime.Parse("22-10-2020", );
            DateTime dt = DateTime.ParseExact("24/01/2013", "dd/MM/yyyy", CultureInfo.InvariantCulture);
            DateTime dt2 = DateTime.ParseExact("22-10-2020", "dd-MM-yyyy", CultureInfo.InvariantCulture);
        }
    }
}
