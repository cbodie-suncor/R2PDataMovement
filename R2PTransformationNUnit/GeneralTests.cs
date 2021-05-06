using Microsoft.Extensions.Configuration;
using Newtonsoft.Json;
using NUnit.Framework;
using R2PTransformation.Models;
using R2PTransformation.src;
using R2PTransformation;
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
            DBContextWithConnectionString.CreateTestContext();
        }

        [Test]
        public void testParseDate() {
            //            var accountDate = DateTime.ParseExact("28/09/2020 00:59:00", "DD/MM/YYYY HH24:MI:SS", CultureInfo.InvariantCulture);
            var accountDate = DateTime.ParseExact("28/09/2020 13:59:00", "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture);
        }

        [Test]
        public void testGetHeartbeat() {
            String contents = @"Next Heartbeat:2021-01-31 12:51
Last Heartbeat:2021-01-31 12:51
Missed Heartbeats
=================
2021-01-31 12:51
2021-01-31 12:51
2021-01-31 12:52
";
            foreach (TimeZoneInfo z in TimeZoneInfo.GetSystemTimeZones())
                Console.WriteLine(z.Id);

            DateTime localDt = DateTime.Now;
            TimeZoneInfo timeInfo = TimeZoneInfo.FindSystemTimeZoneById("Mountain Standard Time");
            DateTime mtTime = TimeZoneInfo.ConvertTime(localDt, timeInfo);

            string hbHistory = Utilities.GetHBHistory(contents, mtTime);
        }

        [Test]
        public void LoadTagMappings() {
            string tags = File.ReadAllText(@"..\..\..\..\sampleFiles\tagMappings.GP01.csv");
            DataTable tm = Utilities.ConvertCSVTexttoDataTable(tags);
            List<WarningMessage> output = AzureModel.UpdateTagMappings("GP01", tm, "Prod");
            Console.WriteLine(String.Join(',', output.Select(t=>t.ToString()) ));
        }
        [Test]
        public void AddingSigmaTagMappings() {
            string tags = File.ReadAllText(@"..\..\..\..\sampleFiles\tagMappingsWithSigma.csv");
            DataTable tm = Utilities.ConvertCSVTexttoDataTable(tags);
            List<WarningMessage> output = AzureModel.UpdateTagMappings("GP01", tm, "Prod");
            Console.WriteLine(String.Join(',', output.Select(t => t.ToString())));
        }

 //fix       [Test]
        public void LoadConversions() {
            string converts = File.ReadAllText(@"..\..\..\..\sampleFiles\conversion.csv");
            DataTable tm = Utilities.ConvertCSVTexttoDataTable(converts);
            int changes = AzureModel.UpdateConversions(tm);
            Console.WriteLine("update " + changes + " rows");
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
                QuantityTimestamp = t.LastUpdated,
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
            tb.LastUpdated = DateTime.Now;
            tb.BalanceDate = DateTime.Now;
            tb.CreatedBy = "cab";
            tb.StandardUnit = "BBL";
            tb.Plant = "cab";
            tb.ValType = "cab";
            tb.WorkCenter = "cab";
            tb.Material = "123";
            items.Add(tb);

            AzureModel.SaveTagBalance("filename", new HoneywellPBFile("CP01"), items);
            Assert.IsTrue(items.Count > 0);
        }

        [Test]
        public void ProcessHoneyPBWithSave() {
            string ROOTDIR = @"..\..\..\..\sampleFiles\honeywellPB\";
            HoneywellPBFile pf = new HoneywellPBParser().LoadFile(File.ReadAllText(ROOTDIR + "NPUpld-20200930-005900M_MTL.txt"), "CP01", DateTime.Now);
            pf.SaveRecords("filename");
            string json = pf.ExportProductionJson();
            pf.RecordSuccess("sampleHoneyPB.xlsx", "R2PLoad", 2, null);
        }

        [Test]
        public void PostProductionMulesoftTest() {
            MulesoftPush.SetConnection("https://api-rtfdev.sequt.com/azureiot-experience-api/api/v1/azureiot-experience-api/production-posting", "20da7837f9574f03adb6fca17301f75a", "63e0E42AaDbA4815bD6B002E70E9B321", null,null,null);
            // good
            string jsonGood = "{\n  \"BatchId\": \"76347512-0c9e-47f5-9123-b9266218404b\",\n  \"Created\": \"2021-02-05T09:00:00\",\n  \"CreatedBy\": \"R2P\",\n  \"TagBalance\": [\n    {\n      \"Tag\": \"EP01_OIL-STORAGE-CORR-LD\",\n      \"Material\": \"11234\",\n      \"Plant\": \"EP01\",\n      \"WorkCenter\": \"PRODEP01\",\n      \"ValType\": \"RTFTest2\",\n      \"BalanceDate\": \"2019-10-01T00:00:00\",\n      \"Quantity\": \"7075\",\n      \"Uom\": \"M3\"\n    } ]\n}";
            string jsonFailure = "{\"BatchId\":\"890703ed-45f0-4c60-89c8-4dce394d9e53\",\"Created\": \"2021-02-05T09:00:00\", \"CreatedBy\": \"R2P\", \"TagBalance\":[{\"Date\":\"2021-02-17T00:59:00\",\"Tag\":\"BCNRL\",\"System\":\"Honeywell PB\",\"MovementType\":\"Production\",\"Material\":\"10029\",\"Plant\":\"CP04\",\"WorkCenter\":\"PRODCP04\",\"ValType\":\"SUNCOR\",\"BalanceDate\":\"2021-02-17T00:59:00\",\"Quantity\":-1113075.000,\"StandardUnit\":\"M15\"},{\"Date\":\"2021-02-17T00:59:00\",\"Tag\":\"BSUNOSP\",\"System\":\"Honeywell PB\",\"MovementType\":\"Production\",\"Material\":\"10025\",\"Plant\":\"CP04\",\"WorkCenter\":\"PRODCP04\",\"ValType\":\"SUNCOR\",\"BalanceDate\":\"2021-02-17T00:59:00\",\"Quantity\":-5000.000,\"StandardUnit\":\"M15\"}]}";
            string json = "{\"BatchId\":\"890703ed-45f0-4c60-89c8-4dce394d9e53\",\"Created\": \"2021-02-05T09:00:00\", \"CreatedBy\": \"R2P\",\"TagBalance\":[{\"Date\":\"2021-02-17T00:59:00\",\"Tag\":\"BCNRL\",\"System\":\"Honeywell PB\",\"MovementType\":\"Production\",\"Material\":\"10029\",\"Plant\":\"CP04\",\"WorkCenter\":\"PRODCP04\",\"ValType\":\"SUNCOR\",\"BalanceDate\":\"2021-02-17T00:59:00\",\"Quantity\":\"-1113075.000\",\"Uom\":\"M15\"}]}";

            MulesoftPush.PostProduction(json);
        }

        [Test]
        public void PostInventorynMulesoftTest() {
            MulesoftPush.SetConnection("https://api-rtfdev.sequt.com/azureiot-experience-api/api/v1/azureiot-experience-api/production-posting", "20da7837f9574f03adb6fca17301f75a", "63e0E42AaDbA4815bD6B002E70E9B321", "https://api-rtfdev.sequt.com/azureiot-experience-api/api/v1/azureiot-experience-api/physical-inventory", "20da7837f9574f03adb6fca17301f75a", "63e0E42AaDbA4815bD6B002E70E9B321");
            string ROOTDIR = @"..\..\..\..\sampleFiles\InventorySnapshot\";
            string fileName = "SamplePayload-April2021.txt";

            string json = File.ReadAllText(ROOTDIR + fileName);

            MulesoftPush.PostInventory(json);
        }

        [Test]
        public void PostInventorynMulesoftTest2() {
            MulesoftPush.SetConnection("https://api-rtfdev.sequt.com/azureiot-experience-api/api/v1/azureiot-experience-api/physical-inventory", "20da7837f9574f03adb6fca17301f75a", "63e0E42AaDbA4815bD6B002E70E9B321", "https://api-rtfdev.sequt.com/azureiot-experience-api/api/v1/azureiot-experience-api/physical-inventory", "20da7837f9574f03adb6fca17301f75a", "63e0E42AaDbA4815bD6B002E70E9B321");
            string ROOTDIR = @"..\..\..\..\sampleFiles\InventorySnapshot\";
            string fileName = "SamplePayload-April2021.2.txt";

            string json = File.ReadAllText(ROOTDIR + fileName);

            MulesoftPush.PostInventory(json);
        }
        /*
        [Test]
        public void ats() {
            string url = "https://www1.aer.ca/GISConversionTools/WellIDConverter.aspx";

            StringBuilder postData = new StringBuilder();
            NameValueCollection myNameValueCollection = new NameValueCollection();

            myNameValueCollection.Add("lsd", "1");
            myNameValueCollection.Add("section", "1");
            myNameValueCollection.Add("township", "1");
            myNameValueCollection.Add("meridian", "1");
            myNameValueCollection.Add("range", "1");
            myNameValueCollection.Add("position", "C");
            myNameValueCollection.Add("feet_west", "0");
            myNameValueCollection.Add("feet_east", "0");

            WebClient myWebClient = new WebClient();
            Console.WriteLine("\nUploading to {0} ...", url);
            myWebClient.Headers[HttpRequestHeader.ContentType] = "application/x-www-form-urlencoded";
            // 'The Upload(String,NameValueCollection)' implicitly method sets HTTP POST as the request method.            
            byte[] responseArray = myWebClient.UploadValues(url, "POST", myNameValueCollection);
        }
        */
        [Test]
        public void SendBogusTagBalanceToMuleSoft() {
            MulesoftPush.SetConnection("https://api-rtfdev.sequt.com/azureiot-experience-api/api/v1/azureiot-experience-api/production-posting", "20da7837f9574f03adb6fca17301f75a", "63e0E42AaDbA4815bD6B002E70E9B321", null,null,null);

            HoneywellPBFile pf = new HoneywellPBFile("CP04");
            List<TagBalance> items = new List<TagBalance>();
            var tb = new TagBalance();
            tb.MovementType = "Production";
            tb.System = "Honeywell PB";

            tb.Tag = "asdf";
            tb.Quantity = 44;
            tb.LastUpdated = DateTime.Now;
            tb.BalanceDate = DateTime.Now;
            tb.CreatedBy = "cab";
            tb.StandardUnit = "BBL";
            tb.Plant = "cab";
            tb.ValType = "cab";
            tb.WorkCenter = "cab";
            tb.Material = "123";
            items.Add(tb);
            pf.SavedRecords = new List<TagBalance>();
            pf.SavedRecords.Add(tb);
            var json = pf.ExportProductionJson();
            Console.WriteLine(json);
            MulesoftPush.PostProduction(json);
        }
    }
}
