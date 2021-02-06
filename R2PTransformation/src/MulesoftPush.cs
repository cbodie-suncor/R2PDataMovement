using System;
using System.Collections.Generic;
using System.Net.Http;
using System;
using System.Net.Http;
using System.Threading.Tasks;
using Newtonsoft.Json;
using System.Text;

namespace R2PTransformation.src {
    public class MulesoftPush {
        private static readonly HttpClient client = new HttpClient();
        private static readonly string URL = "https://api-rtfdev.sequt.com/azureiot-experience-api/api/v1/azureiot-experience-api/production-posting";


        public static void PostProduction(string json) {
            var byteArray = Encoding.ASCII.GetBytes("20da7837f9574f03adb6fca17301f75a:63e0E42AaDbA4815bD6B002E70E9B321");
            client.DefaultRequestHeaders.Authorization = new System.Net.Http.Headers.AuthenticationHeaderValue("Basic", Convert.ToBase64String(byteArray));

            var data = new StringContent(json, Encoding.UTF8, "application/json");
            var response = client.PostAsync(URL, data);

            Console.WriteLine(response.Result);
        }
    }
}
