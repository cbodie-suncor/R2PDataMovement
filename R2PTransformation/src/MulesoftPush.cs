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
        public static void PostProduction() {
            var values = new Dictionary<string, string>
            {
                { "thing1", "hello" },
                { "thing2", "world" }
            };

            var content = new FormUrlEncodedContent(values);
            var response = client.PostAsync("http://www.example.com/recepticle.aspx", content);

            var result = client.PostAsync(URL, content).Result;

//            var responseString = await response.Content.ReadAsStringAsync();
        }
        /*
        public void PostProduction2() {
            byte[] data = Encoding.ASCII.GetBytes(
                $"username={user}&password={password}");

            WebRequest request = WebRequest.Create("http://localhost/s/test3.php");
            request.Method = "POST";
            request.ContentType = "application/x-www-form-urlencoded";
            request.ContentLength = data.Length;
            using (Stream stream = request.GetRequestStream()) {
                stream.Write(data, 0, data.Length);
            }

            string responseContent = null;

            using (WebResponse response = request.GetResponse()) {
                using (Stream stream = response.GetResponseStream()) {
                    using (StreamReader sr99 = new StreamReader(stream)) {
                        responseContent = sr99.ReadToEnd();
                    }
                }
            }

            MessageBox.Show(responseContent);
        }
        */
        public static void PostProduction3() {
            var httpClient = new HttpClient();
            var url = "https://www.duolingo.com/2016-04-13/login?fields=";
            var data = new { identifier = "username", password = "password" };
            var values = new Dictionary<string, string>
            {
                { "thing1", "hello" },
                { "thing2", "world" }
            };

            var content = new FormUrlEncodedContent(values);
            var result = httpClient.PostAsync(URL, content);
        }

        public static void PostProduction4(string json) {
//            var httpClient = new HttpClient();
            var byteArray = Encoding.ASCII.GetBytes("20da7837f9574f03adb6fca17301f75a:63e0E42AaDbA4815bD6B002E70E9B321");
            client.DefaultRequestHeaders.Authorization = new System.Net.Http.Headers.AuthenticationHeaderValue("Basic", Convert.ToBase64String(byteArray));

            var values = new Dictionary<string, string>
            {
                { "thing1", "hello" },
                { "thing2", "world" }
            };

//            var content = new FormUrlEncodedContent(json);
            var data = new StringContent(json, Encoding.UTF8, "application/json");
            var response = client.PostAsync(URL, data);

//            string result = response.Content.ReadAsStringAsync().Result;
//            response.Result;
            Console.WriteLine(response.Result);
        }
    }
}
