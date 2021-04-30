using System;
using System.Collections.Generic;
using System.Net.Http;
using System.Text;

namespace R2PTransformation.src {
    public class MulesoftPush {
        private static readonly HttpClient client = new HttpClient();

        private static string ProductionUrl { get; set; }
        private static string ProductionUser { get; set; }
        private static string ProductionPW { get; set; }
        private static string InventoryUrl { get; set; }
        private static string InventoryUser { get; set; }
        private static string InventoryPW { get; set; }

        public static void SetConnection(string productionUrl, string productionUser, string productionPW, string inventoryUrl, string inventoryUser, string inventoryPW) {
            ProductionUrl = productionUrl; ProductionUser = productionUser; ProductionPW = productionPW;
            InventoryUrl = inventoryUrl; InventoryUser = inventoryUser; InventoryPW = inventoryPW;
        }

        // Pushes a Json payload to Mulesoft
        public static Boolean PostProduction(string json) {
            if (String.IsNullOrEmpty(ProductionUrl)) return false;
            var byteArray = Encoding.ASCII.GetBytes(ProductionUser + ":" + ProductionPW); 
            client.DefaultRequestHeaders.Authorization = new System.Net.Http.Headers.AuthenticationHeaderValue("Basic", Convert.ToBase64String(byteArray));

            var data = new StringContent(json, Encoding.UTF8, "application/json");
            var response = client.PostAsync(ProductionUrl, data);

//            Console.WriteLine(response.Result);
            if (response.Result.StatusCode.ToString() != "OK") 
                throw new Exception("Mulesoft push failed : " + response.Result.ToString());

            return true;
        }

        public static Boolean PostInventory(string json) {
            if (String.IsNullOrEmpty(InventoryUrl)) return false;
            var byteArray = Encoding.ASCII.GetBytes(InventoryUser + ":" + InventoryPW);
            client.DefaultRequestHeaders.Authorization = new System.Net.Http.Headers.AuthenticationHeaderValue("Basic", Convert.ToBase64String(byteArray));

            var data = new StringContent(json, Encoding.UTF8, "application/json");
            var response = client.PostAsync(InventoryUrl, data);

            //            Console.WriteLine(response.Result);
            if (response.Result.StatusCode.ToString() != "Created")
                throw new Exception("Mulesoft push failed : " + response.Result.ToString());

            return true;
        }
    }
}
