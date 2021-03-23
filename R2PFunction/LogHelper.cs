using Microsoft.Extensions.Logging;
using SuncorR2P;
using System;
using System.Collections.Generic;
using System.Text;

namespace R2PFunction {
    public class LogHelper {
        public static void LogSystemError(ILogger log, string version, Exception ex) {
            log.LogError(ex, $"R2PLoader failed at: {DateTime.Now}");
            string msg = DateTime.Now.ToUniversalTime() + ":" + version + ":" + ex.Message + (ex.InnerException == null ? "" : ex.InnerException.Message);
            AzureFileHelper.WriteFile("master/AzureDataLoader.log", msg, true);
        }

        public static void LogSystemError(ILogger log, string version, string  output) {
            log.LogError(output, $"R2PLoader failed at: {DateTime.Now}");
            string msg = DateTime.Now.ToUniversalTime() + ":" + version + ":" + output;
            AzureFileHelper.WriteFile("master/AzureDataLoader.log", msg, true);
        }
        public static void LogMessage(string plant, string version, string msg) {
            WriteLogFile(plant, DateTime.Now.ToUniversalTime() + ":" + version + ":" + msg);
        }

        public static void WriteLogFile(string plant, string msg) {
            string parentDirectory = plant;
            if (plant == "GP01" || plant == "GP02") parentDirectory = "CommerceCity";
            if (!string.IsNullOrEmpty(plant))
                AzureFileHelper.WriteFile(parentDirectory + "/system/" + "AzureDataLoader." + parentDirectory + ".log", msg, true);
            else
                AzureFileHelper.WriteFile("master/AzureDataLoader.log", msg, true);
        }
    }
}
