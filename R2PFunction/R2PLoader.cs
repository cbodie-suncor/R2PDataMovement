using System;
using System.Data;
using System.IO;
using Microsoft.Azure.WebJobs;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Logging;
using R2PTransformation.src;
using R2PTransformation.src.db;
using SuncorR2P.src;

namespace SuncorR2P
{
    public static class R2PLoader  {

        [FunctionName("R2PLoader")]
        public static void Run([TimerTrigger("0 */1 * * * *")]TimerInfo myTimer, ExecutionContext context, ILogger log)  {  // triggering every minute
            FoundFile foundFile = null;
            var productVersion = typeof(R2PLoader).Assembly.GetName().Version.ToString();
            try {
                SetConnection(context, log);
                AzureFileHelper.ProcessModifiedTagMappings(productVersion);
            } catch (Exception ex) { LogSystemError(log, productVersion, ex); }

            while (true) {
                foundFile = null;
                try {
                    foundFile = AzureFileHelper.ScanForANewFile();
                } catch (Exception ex) { LogSystemError(log, productVersion, ex); }

                if (foundFile == null) break;

                try {
                    string msg = "Processing the file " + foundFile.PlantName + "," + foundFile.AzureFileName;
                    log.LogInformation("*** " + msg + $" at: {DateTime.Now}" + ":" + productVersion);
                    LogMessage(foundFile.PlantName, productVersion, msg);
                    foundFile.ProcessFile();
                    foundFile.DisposeOfFile();
                    foundFile.RecordSuccess();
                } catch (Exception ex) {
                    LogMessage(foundFile.PlantName, productVersion, "Fatal error with file " + foundFile.AzureFullPathName + " : " + ex.Message + ex.StackTrace);
                    AzureModel.RecordFailure(foundFile.PlantName, foundFile.AzureFullPathName, foundFile.SuccessfulRecords, foundFile.FailedRecords, ex.Message);
                    try {
                        foundFile.DisposeOfFile(true);
                    } catch (Exception ex2) { LogSystemError(log, productVersion, ex2); }
                }
            }

            /*
            try {
                if (DateTime.Now.Minute == 20 && DateTime.Now.Hour == 0) FoundFile.ProcessCommerceCity(FoundFile.GetCurrentDay());
            } catch (Exception ex) {
                LogMessage("GP01", "Fatal error with Commerce City : " + ex.Message);
            }*/
        }

        private static void LogSystemError(ILogger log, string version, Exception ex) {
            log.LogError(ex, $"R2PLoader failed at: {DateTime.Now}");
            string msg = DateTime.Now.ToUniversalTime() + ":" + version + ":" + ex.Message;
            AzureFileHelper.WriteFile("system/AzureDataHubProduction.System.log", msg, true);
        }

        private static void SetConnection(ExecutionContext context, ILogger log) {
            IConfiguration iconfig = new ConfigurationBuilder()
            .AddEnvironmentVariables()  // needed for the ConnectionString - comes from local.settings.json or Azure Function Configuration 
            .Build();
            string cs = iconfig["ConnectionStrings:DataHub"];

            string aw = Utilities.GetEnvironmentVariable("AzureWebJobsStorage");
//            log.LogInformation($"Connection String:" + cs);
            //log.LogInformation($"AW Storage:" + aw);
            //AzureFileHelper.WriteFile("system/" + ".AzureDataHubProduction.SS.log", cs == null ? "empty - connection" : "cs:" + cs, true);
            //AzureFileHelper.WriteFile("system/" + ".AzureDataHubProduction.SS.log", aw == null ? "empty - storage" : "env:" + aw, true);
            DBContextWithConnectionString.SetConnectionString(cs);

            string Url = Utilities.GetEnvironmentVariable("MuleSoftUrl");
            string User = Utilities.GetEnvironmentVariable("MuleSoftUser");
            string PW = Utilities.GetEnvironmentVariable("MuleSoftPassword");

            log.LogInformation($"Mulesoft:" + User + ":" + PW);

            MulesoftPush.SetConnection(Url, User, PW);
        }

        public static void LogMessage(string plant, string version, string msg) {
            WriteLogFile(plant, DateTime.Now.ToUniversalTime() + ":" + version + ":" + msg);
        }

        public static void WriteLogFile(string plant, string msg) {
            if (!string.IsNullOrEmpty(plant))
                AzureFileHelper.WriteFile("system/" + ".AzureDataHubProduction." + plant + ".log", msg, true);
            else 
                AzureFileHelper.WriteFile("system/AzureDataHubProduction.System.log", msg, true);
        }
    }
}
