using Newtonsoft.Json;
using NUnit.Framework;
using R2PTransformation;
using R2PTransformation.src;
using R2PTransformation.src.db;
using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.IO;
using System.Linq;

namespace STransformNUnit {
    public class GeneralTests {
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
        public void LoadTagMappings() {
            string tags = File.ReadAllText(@"..\..\..\..\sampleFiles\tagMappings.csv");
            DataTable tm = Utilities.ConvertCSVTexttoDataTable(tags);
            string output = AzureModel.UpdateTagMappings("GP01", tm);
            Console.WriteLine(output);
        }
        [Test]
        public void AddingSigmaTagMappings() {
            string tags = File.ReadAllText(@"..\..\..\..\sampleFiles\tagMappingsWithSigma.csv");
            DataTable tm = Utilities.ConvertCSVTexttoDataTable(tags);
            var output = AzureModel.UpdateTagMappings("GP01", tm);
            Console.WriteLine(output);
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
        public void ProcessHoneyPBWithSave() {
            string ROOTDIR = @"..\..\..\..\sampleFiles\honeywellPB\";
            HoneywellPBFile pf = new HoneywellPBParser().LoadFile(ROOTDIR + "NPUpld-20200930-005900M_MTL.txt", "CP01");
            pf.SaveRecords();
            string json = pf.ExportR2PJson();
            pf.RecordSuccess("sampleHoneyPB.xlsx");
        }

        [Test]
        public void PostMulesoftTest() {
//            string json = "{\n  \"BatchId\": \"76347512-0c9e-47f5-9123-b9266218404b\",\n  \"Created\": \"2019-10-01T00:00:00\",\n  \"CreatedBy\": \"AzureIot\",\n  \"TagBalance\": [\n    {\n      \"Tag\": \"EP01_OIL-STORAGE-CORR-LD\",\n      \"Material\": \"11234\",\n      \"Plant\": \"EP01\",\n      \"WorkCenter\": \"PRODEP01\",\n      \"ValType\": \"RTFTest2\",\n      \"BalanceDate\": \"2019-10-01T00:00:00\",\n      \"Quantity\": \"7075\",\n      \"Uom\": \"M3\"\n    },\n    {\n      \"Tag\": \"EP01_OIL-STORAGE-CORR-LD\",\n      \"Material\": \"10327\",\n      \"Plant\": \"EP02\",\n      \"WorkCenter\": \"PRODEP02\",\n      \"ValType\": \"SUNCORTN\",\n      \"BalanceDate\": \"2019-10-01T00:00:00\",\n      \"Quantity\": \"7075.4100\",\n      \"Uom\": \"M3\"\n    }\n  ]\n}";
            string json = "{\n  \"BatchId\": \"76347512-0c9e-47f5-9123-b9266218404b\",\n  \"Created\": \"2021-02-05T09:00:00\",\n  \"CreatedBy\": \"R2P\",\n  \"TagBalance\": [\n    {\n      \"Tag\": \"EP01_OIL-STORAGE-CORR-LD\",\n      \"Material\": \"11234\",\n      \"Plant\": \"EP01\",\n      \"WorkCenter\": \"PRODEP01\",\n      \"ValType\": \"RTFTest2\",\n      \"BalanceDate\": \"2019-10-01T00:00:00\",\n      \"Quantity\": \"7075\",\n      \"Uom\": \"M3\"\n    },\n    {\n      \"Tag\": \"EP01_OIL-STORAGE-CORR-LD\",\n      \"Material\": \"10327\",\n      \"Plant\": \"EP02\",\n      \"WorkCenter\": \"PRODEP02\",\n      \"ValType\": \"SUNCORTN\",\n      \"BalanceDate\": \"2019-10-01T00:00:00\",\n      \"Quantity\": \"9999.999\",\n      \"Uom\": \"M3\"\n    }\n  ]\n}";

            MulesoftPush.PostProduction(json);
        }
    }
}
