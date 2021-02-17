using System;
using System.Collections.Generic;
using System.Net.Http;
using System.Text;

namespace R2PTransformation.src {
    public class MulesoftPush {
        private static readonly HttpClient client = new HttpClient();

        private static string Url { get; set; }
        private static string User { get; set; }
        private static string PW { get; set; }

        public static void SetConnection(string url, string user, string pw) {
            Url = url; User = user; PW = pw; 
        }

        // Pushes a Json payload to Mulesoft
        public static void PostProduction(string json) {
            var byteArray = Encoding.ASCII.GetBytes(User + ":" + PW); 
            client.DefaultRequestHeaders.Authorization = new System.Net.Http.Headers.AuthenticationHeaderValue("Basic", Convert.ToBase64String(byteArray));

            var data = new StringContent(json, Encoding.UTF8, "application/json");
            var response = client.PostAsync(Url, data);

//            Console.WriteLine(response.Result);
            if (response.Result.StatusCode.ToString() != "OK") 
                throw new Exception("Mulesoft push failed : " + response.Result.ToString());
        }
    }
}
