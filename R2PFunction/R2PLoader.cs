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
            try {
                SetConnection(context, log);
                AzureFileHelper.ProcessModifiedTagMapping();
            } catch (Exception ex) { LogSystemError(log, ex); }

            while (true) {
                foundFile = null;
                try {
                    foundFile = AzureFileHelper.ScanForANewFile();
                } catch (Exception ex) { LogSystemError(log, ex); }

                if (foundFile == null) break;

                try {
                    string msg = "Processing the file " + foundFile.PlantName + "," + foundFile.AzureFileName;
                    log.LogInformation("*** " + msg + $" at: {DateTime.Now}");
                    LogMessage(foundFile.PlantName, msg);
                    foundFile.ProcessFile();
                    foundFile.DisposeOfFile();
                } catch (Exception ex) {
                    LogMessage(foundFile.PlantName, "Fatal error with file " + foundFile.AzureFullPathName + " : " + ex.Message + ex.StackTrace);
                    AzureModel.RecordFailure(foundFile.PlantName, foundFile.AzureFileName, foundFile.SuccessfulRecords, foundFile.FailedRecords, ex.Message);
                    try {
                        foundFile.DisposeOfFile(true);
                    } catch (Exception ex2) { LogSystemError(log, ex2); }
                }
            }

            /*
            try {
                if (DateTime.Now.Minute == 20 && DateTime.Now.Hour == 0) FoundFile.ProcessCommerceCity(FoundFile.GetCurrentDay());
            } catch (Exception ex) {
                LogMessage("GP01", "Fatal error with Commerce City : " + ex.Message);
            }*/
        }

        private static void LogSystemError(ILogger log, Exception ex) {
            log.LogError(ex, $"R2PLoader failed at: {DateTime.Now}");
            AzureFileHelper.WriteFile("system/AzureDataHubProduction.System.log", ex.Message, true);
        }

        private static void SetConnection(ExecutionContext context, ILogger log) {
            IConfiguration iconfig = new ConfigurationBuilder()
            .SetBasePath(context.FunctionAppDirectory)
            .AddJsonFile("local.settings.json", optional: true, reloadOnChange: true)
            .AddEnvironmentVariables()
            .Build();
            string cs = iconfig["ConnectionStrings:DataHub"];
            /*
            //                .SetBasePath(Directory.GetCurrentDirectory())
            //                .AddJsonFile("appSettings.json", true, true).Build();

            string aw = GetEnvironmentVariable("AzureWebJobsStorage");
            log.LogInformation($"connectionString:" + cs);
            log.LogInformation($"AW Storage:" + aw);
            AzureFileHelper.WriteFile("system/" + ".AzureDataHubProduction.SS.log", cs == null ? "empty - connection" : "cs:" + cs, true);
            AzureFileHelper.WriteFile("system/" + ".AzureDataHubProduction.SS.log", aw == null ? "empty - storage" : "env:" + aw, true);
            */
            DBContextWithConnectionString.SetConnectionString(cs);
        }

        public static string GetEnvironmentVariable(string name) {
            return System.Environment.GetEnvironmentVariable(name, EnvironmentVariableTarget.Process);
        }

        public static void LogMessage(string plant, string msg) {
            WriteLogFile(plant, DateTime.Now.ToUniversalTime() + ":" + msg);
        }

        public static void WriteLogFile(string plant, string msg) {
            if (!string.IsNullOrEmpty(plant))
                AzureFileHelper.WriteFile("system/" + ".AzureDataHubProduction." + plant + ".log", msg, true);
            else 
                AzureFileHelper.WriteFile("system/AzureDataHubProduction.System.log", msg, true);
        }
    }
}
