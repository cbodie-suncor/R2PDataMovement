using System;
using System.IO;
using System.Threading.Tasks;
using System.Web.Http;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Azure.WebJobs;
using Microsoft.Azure.WebJobs.Extensions.Http;
using Microsoft.Extensions.Logging;
using Newtonsoft.Json;
using R2PFunction;
using R2PTransformation.src;
using R2PTransformation.Models;
using SuncorR2P.src;
using System.Linq;
using static R2PTransformation.src.SimplePersistentController;

namespace SuncorR2P
{
    public static class R2PLoader {

        [FunctionName("R2PLoader")]
        public static void Run([TimerTrigger("0 */1 * * * *")] TimerInfo myTimer, ExecutionContext context, ILogger log) {  // triggering every minute
            var productVersion = typeof(R2PLoader).Assembly.GetName().Version.ToString();
            Boolean ULSDChanges = false;
            try {
                FoundFile.SetConnection(log);
                FoundFile.SaveHearbeat(log);

                AzureFileHelper.ProcessModifiedTagMappings(productVersion);
                AzureFileHelper.ProcessConversions(productVersion);
                ULSDChanges = AzureFileHelper.UpdateULSDSplits(log, productVersion);

                if (AzureFileHelper.DoesRetriggerFileExist()) AzureFileHelper.ProcessInventoryFromHistorian(log);
            } catch (Exception ex) {
                LogHelper.LogSystemError(log, productVersion, ex); 
            }

            AzureFileHelper.CheckForFilesToBeProcessed(productVersion, log);
            if (ULSDChanges) {
                FoundFile.CleanUpCurrentDateFile("CP03");
            }

            foreach (DriveInfo drive in DriveInfo.GetDrives().Where(d => d.IsReady)) {
                log.LogInformation($"{drive.Name}: {drive.TotalFreeSpace / 1024 / 1024} MB");
            }
        }

        [FunctionName("R2PHistorianLoader")]
        public static void R2PHistorianLoader([TimerTrigger("0 30 6 * * *")] TimerInfo myTimer, ExecutionContext context, ILogger log) {  // at 9:30 AM every day ("0 30 9 * * *")
            var productVersion = typeof(R2PLoader).Assembly.GetName().Version.ToString();
            try {
                FoundFile.SetConnection(log);
                log.LogInformation("starting historian");
                AzureFileHelper.ProcessInventoryFromHistorian(log);
            } catch (Exception ex) {
                LogHelper.LogSystemError(log, productVersion, ex);
            }
        }

        [FunctionName("MaterialLedger")]
        public static async Task<IActionResult> RunMaterialLedger([HttpTrigger(AuthorizationLevel.Function)] HttpRequest req, ILogger log) {
            var productVersion = typeof(R2PLoader).Assembly.GetName().Version.ToString();
            log.LogInformation("C# HTTP trigger Material Ledger request processed.");
            string requestBody = String.Empty;
            int generatedFile = 0;
            try {
                FoundFile.SetConnection(log);
                using (StreamReader streamReader = new StreamReader(req.Body)) { requestBody = await streamReader.ReadToEndAsync(); }
                generatedFile = SimplePersistentController.PersistMaterialLedger(requestBody);
            } catch (Exception ex) {
                LogHelper.LogSystemError(log, productVersion, ex);
                AzureModel.RecordFatalLoad("Material Ledger", null, ex, requestBody);
                string msg = ex.Message + (ex.InnerException == null ? "" : " - " + ex.InnerException.Message);
                return (ActionResult)new BadRequestErrorMessageResult($"Material Ledger failed." + msg);
            }

            return (ActionResult)new OkObjectResult($"Material Ledger processed successfully {generatedFile} records");
        }

        [FunctionName("Inventory")]
        public static async Task<IActionResult> RunInventory([HttpTrigger(AuthorizationLevel.Function)] HttpRequest req, ILogger log) {
            var productVersion = typeof(R2PLoader).Assembly.GetName().Version.ToString();
            log.LogInformation("C# HTTP trigger Inventory request processed.");
            string requestBody = String.Empty;
            S4InventoryBatch batch = null;
            try {
                FoundFile.SetConnection(log);
                using (StreamReader streamReader = new StreamReader(req.Body)) { requestBody = await streamReader.ReadToEndAsync(); }
                batch = SimplePersistentController.PersistS4Inventory(requestBody);
            } catch (Exception ex) {
                LogHelper.LogSystemError(log, productVersion, ex);
                AzureModel.RecordFatalLoad("Inventory", null, ex, requestBody);
                string msg = ex.Message + (ex.InnerException == null ? "" : " - " + ex.InnerException.Message);
                return (ActionResult)new BadRequestErrorMessageResult($"Inventory failed." + msg);
            }
            if (batch.OnlyErrors.Count() > 0) {
                string msg = string.Join(',', batch.OnlyErrors.Select(t => t.GetJsonMessage));
                return (ActionResult)new BadRequestObjectResult("{\"errors\":[" + msg + "]}");
            } else {
                return (ActionResult)new OkObjectResult($"Inventory processed successfully {batch.SuccessFulRecords} records");
            }
        }

        [FunctionName("Hierarchy")]
        public static async Task<IActionResult> RunHierarchy([HttpTrigger(AuthorizationLevel.Function)] HttpRequest req, ILogger log) {
            var productVersion = typeof(R2PLoader).Assembly.GetName().Version.ToString();
            log.LogInformation("C# HTTP trigger Hierarchy request processed.");
            string requestBody = String.Empty;
            int generatedFile = 0;
            try {
                FoundFile.SetConnection(log);
                using (StreamReader streamReader = new StreamReader(req.Body)) { requestBody = await streamReader.ReadToEndAsync(); }
                generatedFile = SimplePersistentController.PersistHierarchy(requestBody);
            } catch (Exception ex) {
                LogHelper.LogSystemError(log, productVersion, ex);
                AzureModel.RecordFatalLoad("Hierarchy", null, ex, requestBody);
                string msg = ex.Message + (ex.InnerException == null ? "" : " - " + ex.InnerException.Message);
                return (ActionResult)new BadRequestErrorMessageResult($"Hierarchy failed." + msg);
            }

            return (ActionResult)new OkObjectResult($"Hierarchy processed successfully {generatedFile} records");
        }

        [FunctionName("CustodyTicket")]
        public static async Task<IActionResult> RunCustodyTicket([HttpTrigger(AuthorizationLevel.Function)] HttpRequest req, ILogger log) {
            var productVersion = typeof(R2PLoader).Assembly.GetName().Version.ToString();
            log.LogInformation("C# HTTP trigger Custody Ticket request processed.");
            string requestBody = String.Empty;
            CustodyTicketBatch generatedFile = null;
            try {
                FoundFile.SetConnection(log);
                using (StreamReader streamReader = new StreamReader(req.Body)) { requestBody = await streamReader.ReadToEndAsync(); }
                generatedFile = CustodyTicketController.CreateHoneywellPBFile(requestBody);
                generatedFile.Plant = "CP01";
                generatedFile.AzurePath = $"CP01/custodyTickets/{DateTime.Now.ToString("yyyyMMddHHmmss")}.txt";
                LogHelper.LogSystemError(log, productVersion, "writing file to " + generatedFile.AzurePath);
                LogHelper.LogSystemError(log, productVersion, "wcontents to " + generatedFile.GeneratedHoneywellPBContent);
                AzureFileHelper.WriteFile(generatedFile.AzurePath, generatedFile.GeneratedHoneywellPBContent, true);
            } catch (Exception ex) {
                LogHelper.LogSystemError(log, productVersion, ex);
                AzureModel.RecordFatalLoad("CustodyTicket", null, ex, requestBody);
                string msg = ex.Message + (ex.InnerException == null ? "" : " - " + ex.InnerException.Message);
                return (ActionResult)new BadRequestErrorMessageResult($"CustodyTicket failed." + msg);
            }

            if (generatedFile.Warnings.Count() > 0) {
                string msg = string.Join(',', generatedFile.Warnings.Select(t => t.Message));
                return (ActionResult)new BadRequestObjectResult("{\"errors\":[" + msg + "]}");
            } else { 
                return (ActionResult)new OkObjectResult($"Custody Tickets processed successfully {generatedFile.SuccessFulRecords} records");
            }
        }

        [FunctionName("MaterialMovement")]
        public static async Task<IActionResult> RunMaterialMovement([HttpTrigger(AuthorizationLevel.Function)] HttpRequest req, ILogger log) {
            var productVersion = typeof(R2PLoader).Assembly.GetName().Version.ToString();
            log.LogInformation("C# HTTP trigger MaterialMovement request processed.");
            string requestBody = String.Empty;
            int success = 0;
            try {
                FoundFile.SetConnection(log);
                using (StreamReader streamReader = new StreamReader(req.Body)) {
                    requestBody = await streamReader.ReadToEndAsync();
                }
                success = new ProductionMatDocController().Persist(requestBody);
            } catch (Exception ex) {
                LogHelper.LogSystemError(log, productVersion, ex);
                AzureModel.RecordFatalLoad("MaterialMovement", null, ex, requestBody);
                string msg = ex.Message + (ex.InnerException == null ? "" : " - " + ex.InnerException.Message);
                return (ActionResult)new BadRequestErrorMessageResult($"MaterialMovement failed." + msg);
            }            

            return (ActionResult)new OkObjectResult($"MaterialMovement processed successfully {success} records");
        }
    }
}
