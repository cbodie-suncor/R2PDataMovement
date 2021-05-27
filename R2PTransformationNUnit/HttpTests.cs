using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using NUnit.Framework;
using R2PTransformation.Models;
using System;
using System.IO;
using System.Net.Http;
using System.Text;

namespace STransformNUnit {
    public class HttpTests {
        static string baseTestURL = "https://aaasbxarmfapuw2015.azurewebsites.net/api/";
        string ROOTDIR = @"..\..\..\..\sampleFiles\MaterialMovement\";

        [SetUp]
        public void Setup() {
            DBContextWithConnectionString.CreateTestContext();
        }

        [Test]
        public void SimpleHierarchy() {
            HttpClient client = new HttpClient();
            string json = File.ReadAllText(ROOTDIR + "Hierarchy2.json");
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
            string json = File.ReadAllText(ROOTDIR + "MaterialLedger3.json");
            var data = new StringContent(json, Encoding.UTF8, "application/json");
            data.Headers.Add("x-functions-key", "2Mps74EWSjAamb8FCVrOGjbtB/g7CNqEJrZjhwpkaa6xDw1sR6hQaw==");

            var response = client.PostAsync(baseTestURL + "MaterialLedger", data);
            string output = response.Result.Content.ReadAsStringAsync().Result;
            Console.WriteLine(output);

            if (response.Result.StatusCode.ToString() != "OK")
                throw new Exception("Material Ledger push failed : " + response.Result.ToString());
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
        public void SimpleCustodyTicket() {
            string ROOTDIR2 = @"..\..\..\..\sampleFiles\CustodyTicket\";
            HttpClient client = new HttpClient();
            string json = File.ReadAllText(ROOTDIR2 + "CustodyTicket_Azure_Sample_Request.json");
            var data = new StringContent(json, Encoding.UTF8, "application/json");
            data.Headers.Add("x-functions-key", "2Mps74EWSjAamb8FCVrOGjbtB/g7CNqEJrZjhwpkaa6xDw1sR6hQaw==");

            var response = client.PostAsync(baseTestURL + "CustodyTicket", data);
            string output = response.Result.Content.ReadAsStringAsync().Result;
            Console.WriteLine(output);

            if (response.Result.StatusCode.ToString() != "OK")
                throw new Exception("CustodyTicket push failed : " + response.Result.ToString());
        }

        [Test]
        public void BadCustodyTicket() {
            string ROOTDIR2 = @"..\..\..\..\sampleFiles\CustodyTicket\";
            HttpClient client = new HttpClient();
            string json = File.ReadAllText(ROOTDIR2 + "Custody Ticket5.json");
            var data = new StringContent(json, Encoding.UTF8, "application/json");
            data.Headers.Add("x-functions-key", "2Mps74EWSjAamb8FCVrOGjbtB/g7CNqEJrZjhwpkaa6xDw1sR6hQaw==");

            var response = client.PostAsync(baseTestURL + "CustodyTicket", data);
            string output = response.Result.Content.ReadAsStringAsync().Result;
            Console.WriteLine(output);

            Assert.IsTrue(response.Result.StatusCode.ToString() == "BadRequest");
            Assert.AreEqual("{\"errors\":[{bolNumber:\"SHPBOL-1\",enteredOnDateTime:\"2021-03-25 02:57:45\",error:\"Invalid Number for mass\"}]}", output) ;
        }

        [Test]
        public void SimpleInventory() {
            string BASEDIR = @"..\..\..\..\sampleFiles\";
            string json = File.ReadAllText(BASEDIR + "/inventorySnapshot/invFromMulesoft4.json");

            HttpClient client = new HttpClient();

//            baseTestURL = "https://pbidevarmfncuw2001.azurewebsites.net/api/";
            var data = new StringContent(json, Encoding.UTF8, "application/json");
            data.Headers.Add("x-functions-key", "2Mps74EWSjAamb8FCVrOGjbtB/g7CNqEJrZjhwpkaa6xDw1sR6hQaw==");
//            data.Headers.Add("x-functions-key", "RcydLOUJ/4h1PLF09sRFnPlf4RaTGFQLTygL/IVgbGZvWe3kebGqjA==");

            var response = client.PostAsync(baseTestURL + "Inventory", data);
            string output = response.Result.Content.ReadAsStringAsync().Result;
            Console.WriteLine(output);

            Assert.IsTrue(response.Result.StatusCode.ToString() == "BadRequest");
            JObject responseObject = (JObject)JsonConvert.DeserializeObject(output);
            JArray items = (JArray)responseObject["errors"];
            Assert.AreEqual(16, items.Count);
        }
    }
}
