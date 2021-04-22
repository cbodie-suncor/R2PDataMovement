using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using NUnit.Framework;
using R2PTransformation.src;
using R2PTransformation.Models;
using System;
using System.Collections.Generic;
using System.IO;
using System.Net.Http;
using System.Text;
using Microsoft.Extensions.Primitives;

namespace R2PTransformationNUnit {
    public class MaterialMovementTest {
        static string baseTestURL = "https://aaasbxarmfapuw2015.azurewebsites.net/api/";
        string ROOTDIR = @"..\..\..\..\sampleFiles\MaterialMovement\";

        [SetUp]
        public void Setup() {
        }

        [Test]
        public void JsonTest() {
            string json = File.ReadAllText(ROOTDIR + "sample.json");
            object obj = JsonConvert.DeserializeObject(json);
            Assert.True(1 == 1); ;
        }

        [Test]
        public void JsonTest2() {
//            DBContextWithConnectionString.SetConnectionString("Data Source=inmdevarmsvruw2001.database.windows.net;Initial Catalog=inmdevarmsqluw2001;User ID=suncorsqladmin;password=AdvancedAnalytics2020;");
            DBContextWithConnectionString.SetConnectionString("Data Source=aaasbxarmsrvuw2015.database.windows.net;Initial Catalog=NLSandbox;User ID=tempR2PIntegration;password=NorthernLights2021");
            string json = File.ReadAllText(ROOTDIR + "sample2e.json");
            new ProductionMatDocController().Persist(json);
            Assert.True(1 == 1); ;
        }

        [Test]
        public void JsonTest3() {
            //            DBContextWithConnectionString.SetConnectionString("Data Source=inmdevarmsvruw2001.database.windows.net;Initial Catalog=inmdevarmsqluw2001;User ID=suncorsqladmin;password=AdvancedAnalytics2020;");
            DBContextWithConnectionString.SetConnectionString("Data Source=aaasbxarmsrvuw2015.database.windows.net;Initial Catalog=NLSandbox;User ID=tempR2PIntegration;password=NorthernLights2021");
            string json = File.ReadAllText(ROOTDIR + "sample3.json");
            new ProductionMatDocController().Persist(json);
            Assert.True(1 == 1); ;
        }

        [Test]
        public void SimpleMaterialMovementSend() {
            HttpClient client = new HttpClient();
            string json = File.ReadAllText(ROOTDIR + "sample2e.json");
            var data = new StringContent(json, Encoding.UTF8, "application/json");
            data.Headers.Add("x-functions-key", "2Mps74EWSjAamb8FCVrOGjbtB/g7CNqEJrZjhwpkaa6xDw1sR6hQaw==");

            var response = client.PostAsync(baseTestURL + "MaterialMovement", data);
            Console.WriteLine(response.Result);
            string output = response.Result.Content.ReadAsStringAsync().Result;
            Console.WriteLine(output);

            if (response.Result.StatusCode.ToString() != "OK")
                throw new Exception("MM push failed : " + response.Result.ToString());
        }

        [Test]
        public void SimpleHierarchy() {
            HttpClient client = new HttpClient();
            string json = File.ReadAllText(ROOTDIR + "Hierarchy.json");
            var data = new StringContent(json, Encoding.UTF8, "application/json");
            data.Headers.Add("x-functions-key", "2Mps74EWSjAamb8FCVrOGjbtB/g7CNqEJrZjhwpkaa6xDw1sR6hQaw==");

            var response = client.PostAsync(baseTestURL + "Hierarchy", data);
            string output = response.Result.Content.ReadAsStringAsync().Result;
            Console.WriteLine(output);

            if (response.Result.StatusCode.ToString() != "OK")
                throw new Exception("Hierarchy push failed : " + response.Result.ToString());
        }

        [Test]
        public void SimpleMaterialLedger() {
            HttpClient client = new HttpClient();
            string json = File.ReadAllText(ROOTDIR + "MaterialLedger.json");
            var data = new StringContent(json, Encoding.UTF8, "application/json");
            data.Headers.Add("x-functions-key", "2Mps74EWSjAamb8FCVrOGjbtB/g7CNqEJrZjhwpkaa6xDw1sR6hQaw==");

            var response = client.PostAsync(baseTestURL + "MaterialLedger", data);
            string output = response.Result.Content.ReadAsStringAsync().Result;
            Console.WriteLine(output);

            if (response.Result.StatusCode.ToString() != "OK")
                throw new Exception("Material Ledger push failed : " + response.Result.ToString());
        }

        [Test]
        public void SimpleCustodyTicket() {
            HttpClient client = new HttpClient();
            string json = File.ReadAllText(ROOTDIR + "CustodyTicketProdMatDoc.json");
            var data = new StringContent(json, Encoding.UTF8, "application/json");
            data.Headers.Add("x-functions-key", "2Mps74EWSjAamb8FCVrOGjbtB/g7CNqEJrZjhwpkaa6xDw1sR6hQaw==");

            var response = client.PostAsync(baseTestURL + "CustodyTicket", data);
            string output = response.Result.Content.ReadAsStringAsync().Result;
            Console.WriteLine(output);

            if (response.Result.StatusCode.ToString() != "OK")
                throw new Exception("CustodyTicket push failed : " + response.Result.ToString());
        }

        [Test]
        public void SimpleCustodyTicket2() {
            HttpClient client = new HttpClient();
            string json = File.ReadAllText(ROOTDIR + "CustodyTicket2.json");
            var data = new StringContent(json, Encoding.UTF8, "application/json");
            data.Headers.Add("x-functions-key", "2Mps74EWSjAamb8FCVrOGjbtB/g7CNqEJrZjhwpkaa6xDw1sR6hQaw==");

            var response = client.PostAsync(baseTestURL + "CustodyTicket", data);
            string output = response.Result.Content.ReadAsStringAsync().Result;
            Console.WriteLine(output);

            if (response.Result.StatusCode.ToString() != "OK")
                throw new Exception("CustodyTicket push failed : " + response.Result.ToString());
        }

        [Test]
        public void GenerateCustodyTicket() {
            HttpClient client = new HttpClient();
            string json = File.ReadAllText(ROOTDIR + "CustodyTicketProdMatDoc.json");
            PBFile file = CustodyTicketController.CreateHoneywellPBFile(json);
        }
    }
}
