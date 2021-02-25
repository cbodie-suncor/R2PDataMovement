using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Logging;
using Microsoft.Azure.WebJobs;
using R2PFunction;
using R2PTransformation.src;
using System;
using System.IO;

namespace SuncorR2P.src {
    public class FoundFile {
        public string TempFileName;
        public string AzureFileName;
        public string AzureFullPathName;
        public SuncorProductionFile ProducitionFile;

        public string ParentDiectory {
            get {
                DirectoryInfo d = new FileInfo(AzureFullPathName).Directory;
                return d.Parent.Name;
            }
    }
        public string PlantName {
            get {
                DirectoryInfo d = new FileInfo(AzureFullPathName).Directory;
                string plant = d.Parent.Name;
                if (plant == "DENVER") {
                    plant = AzureFullPathName.ToLower().Contains("wp") ? "GP01" : "GP02";
                }
                if (plant.Length != 4) throw new Exception("Can't find plant code in fileName " + AzureFileName);
                return plant;
            }
        }

        public string ProductCode {
            get {
                // for Montreal Sulphur, the product code is the 1st digit of the file
                // ie 2 - 2020 SBS Production.xlsx
                // ie 3 - 2020 Sulphur Production.xlsx
                // ie 5 - 2020 Caustic Consumption.xlsx
                string onlyFilename = new FileInfo(AzureFullPathName).Name;
                int code = int.Parse(onlyFilename.Substring(0, 1));
                return code.ToString();
            }
        }

        public string GetSuffix() {
            return new FileInfo(AzureFileName).Extension;
        }

        public string GetFileNameWithTimestampAppendedBeforeSuffix() {
            String currentTime = DateTime.Now.ToString("yyyyMMddHHmmss");
            string newName = AzureFileName.Replace(GetSuffix(), "") + "." + currentTime + GetSuffix();
            return newName;
        }

        public void DisposeOfFile(Boolean fatal = false) {
            string destination = this.ParentDiectory + "\\" + (this.SuccessfulRecords == 0 || fatal ? "rejected" : "archived") + "\\" + this.GetFileNameWithTimestampAppendedBeforeSuffix();
            AzureFileHelper.CopyToAzureFileShare(this.TempFileName, destination);
            AzureFileHelper.DeleteFile(this.AzureFullPathName);
            File.Delete(this.TempFileName);
        }

        public void ProcessFile() {
            SuncorProductionFile.SetLogFileWriter(LogHelper.WriteLogFile);
            this.ProducitionFile = null;
            DateTime day = GetCurrentDay(this.PlantName);

            if (this.IsHoneywellPB)         { this.ProducitionFile = new HoneywellPBParser().LoadFile(this.TempFileName, this.PlantName, day); }
            if (this.IsMontrealSulphur)     { this.ProducitionFile = new MontrealSulphurParser().LoadFile(this.TempFileName, this.PlantName, this.ProductCode, day); }
            if (this.IsDPS)                 { this.ProducitionFile = new DPSParser().LoadFile(this.TempFileName, this.PlantName, day); }
            if (this.IsDenver)              { this.ProducitionFile = new SigmafineParser().LoadExcel(this.TempFileName, this.PlantName, day); }
            if (this.IsTerraNova)           { this.ProducitionFile = new TerraNovaParser().LoadFile(this.TempFileName, this.PlantName, day); }
            if (this.IsSarnia)              { }
            if (this.ProducitionFile != null) {
                this.ProducitionFile.SaveRecords();
                this.SuccessfulRecords = this.ProducitionFile.SavedRecords.Count;
                this.FailedRecords = this.ProducitionFile.FailedRecords.Count;
                if (this.ProducitionFile.SavedRecords.Count > 0) {
                    string json = this.ProducitionFile.ExportR2PJson();
                    MulesoftPush.PostProduction(json);
                    AzureFileHelper.WriteFile(this.AzureFullPathName.Replace("immediateScan", "tempJsonOutput") + ".json", json, false);
                }
            }
        }

        internal void RecordSuccess() {
            ProducitionFile.RecordSuccess(this.AzureFullPathName);
        }

        public static DateTime GetCurrentDay(string plant) {
            DateTime day = DateTime.Today;
            string fileName = $"system/currentDate.{plant}.txt";
            string currentDateString = AzureFileHelper.ReadFile(fileName);
            // only use the first line
            if (!String.IsNullOrEmpty(currentDateString)) {
                string currentDateString1stLine = currentDateString.Split('\n')[0];
                try {
                    day = DateTime.Parse(currentDateString1stLine);
                } catch (Exception ex) {
                    throw new Exception("Invalid Date Format for system/currentDate." + plant + ".txt");
                }
                // move the currentDate.txt to processed
                AzureFileHelper.WriteFile(fileName.Replace(".txt", ".processed.txt"), currentDateString, false);
                AzureFileHelper.DeleteFile(fileName);
            }
            return day;
        }

        public static void SetConnection(ExecutionContext context, ILogger log) {
            IConfiguration iconfig = new ConfigurationBuilder()
            .AddEnvironmentVariables()  // needed for the ConnectionString - comes from local.settings.json or Azure Function Configuration 
//            .AddJsonFile("local.settings.json", true, true)
            .Build();
            string cs = iconfig["ConnectionStrings:DataHub"];

            string aw = Utilities.GetEnvironmentVariable("AzureWebJobsStorage");
            //            log.LogInformation($"Connection String:" + cs);
            //log.LogInformation($"AW Storage:" + aw);
            //AzureFileHelper.WriteFile("system/" + ".AzureDataHubProduction.SS.log", cs == null ? "empty - connection" : "cs:" + cs, true);
            //AzureFileHelper.WriteFile("system/" + ".AzureDataHubProduction.SS.log", aw == null ? "empty - storage" : "env:" + aw, true);
            DBContextWithConnectionString.SetConnectionString(cs);

            string Url = iconfig["MuleSoftUrl"];
            string User = iconfig["MuleSoftUser"];
            string PW = iconfig["MuleSoftPassword"];

            MulesoftPush.SetConnection(Url, User, PW);
        }

        public FoundFile(string azureFileName, string azureFullPathName, string tempFileName) {
            this.AzureFileName = azureFileName;
            this.TempFileName = tempFileName;
            this.AzureFullPathName = azureFullPathName;
        }
        public Boolean IsHoneywellPB { get { return PlantName.ToUpper() == "CP01" || PlantName.ToUpper() == "CP04"; } }
        public Boolean IsMontrealSulphur { get { return PlantName.ToUpper() == "CP02"; } }
        public Boolean IsSarnia { get { return PlantName.ToUpper() == "CP03"; } }
        public Boolean IsDPS { get { return PlantName.ToUpper().Contains("AP"); } }
        public Boolean IsDenver { get { return PlantName.ToUpper().Contains("GP"); } }
        public Boolean IsTerraNova { get { return PlantName.ToUpper().Contains("EP"); } }

        public int FailedRecords { get; internal set; }
        public int SuccessfulRecords { get; internal set; }
    }
}
