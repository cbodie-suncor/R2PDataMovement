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
        public void SimpleInventory() {
            string BASEDIR = @"..\..\..\..\sampleFiles\";
            string json = File.ReadAllText(BASEDIR + "/inventorySnapshot/invFromMulesoft3.json");

            HttpClient client = new HttpClient();
            var data = new StringContent(json, Encoding.UTF8, "application/json");
            data.Headers.Add("x-functions-key", "2Mps74EWSjAamb8FCVrOGjbtB/g7CNqEJrZjhwpkaa6xDw1sR6hQaw==");

            var response = client.PostAsync(baseTestURL + "Inventory", data);
            string output = response.Result.Content.ReadAsStringAsync().Result;
            Console.WriteLine(output);

            if (response.Result.StatusCode.ToString() != "OK")
                throw new Exception("CustodyTicket push failed : " + response.Result.ToString());
        }
    }
}
