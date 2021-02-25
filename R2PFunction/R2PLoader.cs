using System;
using System.IO;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Azure.WebJobs;
using Microsoft.Azure.WebJobs.Extensions.Http;
using Microsoft.Extensions.Logging;
using Newtonsoft.Json;
using R2PFunction;
using SuncorR2P.src;

namespace SuncorR2P
{
    public static class R2PLoader {

        [FunctionName("R2PLoader")]
        public static void Run([TimerTrigger("0 */1 * * * *")] TimerInfo myTimer, ExecutionContext context, ILogger log) {  // triggering every minute
            var productVersion = typeof(R2PLoader).Assembly.GetName().Version.ToString();
            try {
                FoundFile.SetConnection(context, log);
                AzureFileHelper.ProcessModifiedTagMappings(productVersion);
            } catch (Exception ex) { LogHelper.LogSystemError(log, productVersion, ex); }

            AzureFileHelper.CheckForFilesToBeProcessed(productVersion, log);
        }

        [FunctionName("CustodyTicket")]
        public static async Task<IActionResult> RunCustodyTicket(
        [HttpTrigger(AuthorizationLevel.Anonymous)] HttpRequest req, ILogger log) {
            //            public static async Task<HttpResponseMessage> Run([HttpTrigger(AuthorizationLevel.Anonymous, "get", "post", Route = null)] HttpRequestMessage req, ILogger log) {
            log.LogInformation("C# HTTP trigger function processed a request.");

            string name = req.Query["name"];

            string requestBody = String.Empty;
            using (StreamReader streamReader = new StreamReader(req.Body)) {
                requestBody = await streamReader.ReadToEndAsync();
            }
            dynamic data = JsonConvert.DeserializeObject(requestBody);
            name = name ?? data?.name;

            return name != null
                ? (ActionResult)new OkObjectResult($"Hello, {name}")
                : new BadRequestObjectResult("Please pass a name on the query string or in the request body");
        }

        [FunctionName("MaterialMovement")]
        public static async Task<IActionResult> RunMaterialMovement([HttpTrigger(AuthorizationLevel.Admin, "get", "post", Route = null)] HttpRequest req, ILogger log) {
            log.LogInformation("C# HTTP trigger function processed a request.");

            string name = req.Query["name"];

            string requestBody = String.Empty;
            using (StreamReader streamReader = new StreamReader(req.Body)) {
                requestBody = await streamReader.ReadToEndAsync();
            }
            dynamic data = JsonConvert.DeserializeObject(requestBody);
            name = name ?? data?.name;

            return name != null
                ? (ActionResult)new OkObjectResult($"Hello, {name}")
                : new BadRequestObjectResult("Please pass a name on the query string or in the request body");
        }
    }
}
