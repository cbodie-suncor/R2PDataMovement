using Newtonsoft.Json;
using NUnit.Framework;
using R2PTransformation.src.db;
using R2PTransformation;
using R2PTransformation.src;
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
//            AzureModel.SetConnection("Data Source=(local);Initial Catalog=suncor;Integrated Security=True;MultipleActiveResultSets=True;");
            DBContextWithConnectionString.SetConnectionString("Data Source=(local);Initial Catalog=suncor;Integrated Security=True;MultipleActiveResultSets=True;");
        }

        [Test]
        public void Test1() {
            HoneywellPBFile pf = new HoneywellPBParser().LoadFile(ROOTDIR + "NPUpld-20200928-005900M.txt", "CP01");
            Assert.IsTrue(pf.Values.ContainsKey("ACCOUNT_DATE"));
            Assert.IsTrue(pf.Values.ContainsKey("REFINERY_GAIN_LOSS"));
            Assert.IsTrue(pf.Defaults.ContainsKey("DATEFORMAT"));
            Assert.IsTrue(pf.BalanceRecords[0].Values.ContainsKey("BALANCE_GROUP_NAME"));
            Assert.IsTrue(pf.BalanceRecords[0].ProductionRecords.Count > 0);
//            Assert.IsTrue(pf.BalanceRecords[0].ProductionRecords.Count == 38);
            foreach (var pr in pf.BalanceRecords[0].ProductionRecords) {
                decimal netYield = pr.GetDecimalValue("NET_YIELD");
                decimal AMMDT = pr.GetAMMDTQuantity();
                if (netYield == 0) {
                }
            }
        }

        [Test]
        public void Test2() {
            string[] files = Directory.GetFiles(ROOTDIR, "*.txt");
            foreach (string file in files) {
                HoneywellPBFile pf = new HoneywellPBParser().LoadFile(file, "CP01");
                Assert.IsTrue(pf.Values.ContainsKey("ACCOUNT_DATE"));
                Assert.IsTrue(pf.Values.ContainsKey("REFINERY_GAIN_LOSS"));
                Assert.IsTrue(pf.Defaults.ContainsKey("DATEFORMAT"));
                Assert.IsTrue(pf.BalanceRecords[0].Values.ContainsKey("BALANCE_GROUP_NAME"));
                Assert.IsTrue(pf.BalanceRecords[0].ProductionRecords.Count > 0);

                System.Console.WriteLine("processing file " + file);
                foreach (var pr in pf.BalanceRecords[0].ProductionRecords) {
                    decimal netYield = pr.GetDecimalValue("NET_YIELD");
                    decimal AMMDT = pr.GetAMMDTQuantity();
                }
                pf.SaveRecords();
                string json = pf.ExportR2PJson();
                System.Console.WriteLine(json);
                Assert.IsTrue(json.Length > 0);
            }
        }

        [Test]
        public void HoneywellPBLoadOnly() {
            HoneywellPBFile pf = new HoneywellPBParser().LoadFile(ROOTDIR + "NPUpld-20200928-005900M.txt", "CP01");
            Assert.IsTrue(pf.Values.ContainsKey("ACCOUNT_DATE"));
            Assert.IsTrue(pf.Values.ContainsKey("REFINERY_GAIN_LOSS"));
            Assert.IsTrue(pf.Defaults.ContainsKey("DATEFORMAT"));
            Assert.IsTrue(pf.BalanceRecords[0].Values.ContainsKey("BALANCE_GROUP_NAME"));
            Assert.IsTrue(pf.BalanceRecords[0].ProductionRecords.Count > 0);
        }

        [Test]
        public void ReadAllTagBalance() {
            var items = AzureModel.GetAllTagBalances();
            Assert.IsTrue(items.Count > 0);
        }

        [Test]
        public void CreateAllJsonR2P() {
            var data = AzureModel.GetAllTagBalances().Select(t => new {
                Date = t.BalanceDate,
                Tag = t.Tag,
                System = t.System,
                MovementType = t.MovementType,
                Material = t.Material,
                Plant = t.Plant,
                WorkCenter = t.WorkCenter,
                ValType = t.ValType,
                Tank = t.Tank,
                QuantityTimestamp = t.QuantityTimestamp,
                BalanceDate = t.BalanceDate,
                Quantity = t.Quantity,
                StandardUnit = t.StandardUnit
            });
            string json = JsonConvert.SerializeObject(data);
            Assert.IsTrue(json.Length > 0);
        }

        [Test]
        public void PersistBogusTagBalance() {
            List<TagBalance> items = new List<TagBalance>();
            var tb = new TagBalance();
            tb.MovementType = "Production";
            tb.System = "Honeywell PB";

            tb.Tag = "asdf";
            tb.Created = DateTime.Now;
            tb.BalanceDate = DateTime.Now;
            tb.QuantityTimestamp = DateTime.Now;
            tb.CreatedBy = "cab";
            tb.StandardUnit = "BBL";
            tb.Plant = "cab";
            tb.ValType = "cab";
            tb.WorkCenter = "cab";
            tb.Material = "123";
            items.Add(tb);

            AzureModel.SaveTagBalance("aaa", new HoneywellPBFile("aaa", "CP01"), items);
            Assert.IsTrue(items.Count > 0);
        }

        [Test]
        public void LoadHoneyWellSingleFileAndPersist1() {
            string json = "";
            try {
                HoneywellPBFile pf = new HoneywellPBParser().LoadFile(ROOTDIR + "NPUpld-20200129-005900M_EDM.txt", "CP04");
                pf.SaveRecords();
                json = pf.ExportR2PJson();
                System.Console.WriteLine(json);
                SuncorProductionFile.LogSuccess(pf.FileName, pf, pf.SavedRecords.Count, pf.FailedRecords.Count);
            } catch (Exception ex) {
                SuncorProductionFile.Log("CP04", ex);
            }
            File.WriteAllText(@"D:\projects\suncor\sampleFiles\NPUpld-20200129-005900M_EDM.json", json);
            Assert.IsTrue(json.Length > 0);
        }

        [Test]
        public void LoadHoneyWellSingleFileAndPersist2() {
            string json = "";
            try {
                HoneywellPBFile pf = new HoneywellPBParser().LoadFile(ROOTDIR + "NPUpld-20200930-005900M_MTL.txt", "CP01");
                pf.SaveRecords();
                json = pf.ExportR2PJson();
                System.Console.WriteLine(json);
                SuncorProductionFile.LogSuccess(pf.FileName, pf, pf.SavedRecords.Count, pf.FailedRecords.Count);
            } catch (Exception ex) {
                SuncorProductionFile.Log("CP01", ex);
            }
            File.WriteAllText(@"D:\projects\suncor\sampleFiles\NPUpld-20200930-005900M_MTL.json", json);
            Assert.IsTrue(json.Length > 0);
        }

        [Test]
        public void testParseDate() {
//            var accountDate = DateTime.ParseExact("28/09/2020 00:59:00", "DD/MM/YYYY HH24:MI:SS", CultureInfo.InvariantCulture);
            var accountDate = DateTime.ParseExact("28/09/2020 13:59:00", "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture);
        }
    }
}
