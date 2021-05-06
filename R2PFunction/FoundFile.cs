using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Logging;
using R2PFunction;
using R2PTransformation.src;
using System;
using System.IO;
using R2PTransformation.Models;
using System.Data;
using Microsoft.Data.SqlClient;
using static R2PTransformation.src.SarniaParser;
using System.Collections.Generic;
using System.Text;

namespace SuncorR2P.src {
    public class FoundFile {
        public string AzureFileName;
        public string AzureFullPathName;
        public byte[] BytesOfFile;

        public SuncorProductionFile ProductionFile;
        public Boolean Inventory = false;

        public string FileContents { get { return Encoding.Default.GetString(BytesOfFile); } }

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
                if (plant == "DENVER" || plant.ToUpper() == "COMMERCECITY") {
                    if (AzureFullPathName.ToLower().Contains("inventory")) {
                        plant = "COMMERCECITY";
                        Inventory = true;
                    } else if (AzureFullPathName.ToLower().Contains("wp")) {
                        plant = "GP01";
                    } else if (AzureFullPathName.ToLower().Contains("ep")) {
                        plant = "GP02";
                    } else {
                        throw new Exception("Invalid file for CommerceCity " + AzureFileName);
                    }
                }
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
            AzureFileHelper.CopyToAzureFileShare(this.BytesOfFile, destination);
        }

        public void DeleteOriginalFile() {
            try {
                AzureFileHelper.DeleteFile(this.AzureFullPathName);
            } catch (Exception) {
                throw new OriginalFileLockException(this.AzureFullPathName + " has a file lock and is NOT PROCESSED");
            }
        }

        public void ProcessFile(ILogger log, string version) {
            SuncorProductionFile.SetLogFileWriter(LogHelper.WriteLogFile);
            this.ProductionFile = null;
            DateTime processingDate = GetCurrentDay(this.PlantName, true);

            if (this.IsHoneywellPB || this.IsSarnia) {
                this.ProductionFile = new HoneywellPBParser().LoadFile(this.FileContents, this.PlantName, processingDate);
                if (this.IsSarnia) {
                    DateTime balancingDate = ((R2PTransformation.HoneywellPBFile)this.ProductionFile).GetAccountDate();

                    if (SuncorProductionFile.IsDayValid(balancingDate, processingDate)) {
                        FoundFile ulsd = AzureFileHelper.GetULSDFileForCP03(balancingDate);
                        if (ulsd == null) throw new Exception("no ULSD file found for the month " + balancingDate.ToString("MMMM yyyy"));
                        List<ShellSplit> ss = SarniaParser.LoadULSDSplits(ulsd.BytesOfFile);
                        SarniaParser.ApplyShellSplits(this.ProductionFile, ss);
                    }
                }
            }
            if (this.IsMontrealSulphur)     { this.ProductionFile = new MontrealSulphurParser().LoadFile(this.BytesOfFile, this.PlantName, this.ProductCode, processingDate); }
            if (this.IsDPS)                 { this.ProductionFile = new DPSParser().LoadFile(this.BytesOfFile, this.PlantName, processingDate); }
            if (this.IsDenver)              { this.ProductionFile = new SigmafineParser().LoadProductionExcel(this.BytesOfFile, this.PlantName, processingDate); }
            if (this.Inventory)             { this.ProductionFile = new SigmafineParser().LoadInventoryExcel(this.BytesOfFile, this.PlantName, processingDate);  }
            if (this.IsTerraNova)           { this.ProductionFile = new TerraNovaParser().LoadFile(this.FileContents, this.PlantName, processingDate); }
            if (this.ProductionFile != null) {
                this.FailedRecords = this.ProductionFile.FailedRecords;

                if (this.Inventory) {
                    AzureModel.SaveInventory(this.AzureFullPathName, this.ProductionFile, this.ProductionFile.Inventory);
                    this.SuccessfulRecords = this.ProductionFile.SavedInventoryRecords.Count;
                    if (this.ProductionFile.SavedInventoryRecords.Count > 0) {
                        string json = this.ProductionFile.ExportInventory();
                        AzureFileHelper.WriteFile(this.AzureFullPathName.Replace("immediateScan", "diagnostic") + ".json", json, false);
                        if (!MulesoftPush.PostInventory(json)) {
                            LogHelper.LogSystemError(log, version, "Json NOT sent to Mulesoft");
                            this.ProductionFile.Warnings.Add(new WarningMessage(MessageType.Error, "Json NOT sent to Mulesoft"));
                        }
                    }

                } else {
                    this.ProductionFile.SaveRecords(this.AzureFullPathName);
                    this.SuccessfulRecords = this.ProductionFile.SavedRecords.Count;
                    if (this.ProductionFile.SavedRecords.Count > 0) {
                        string json = this.ProductionFile.ExportProductionJson();
                        AzureFileHelper.WriteFile(this.AzureFullPathName.Replace("immediateScan", "diagnostic") + ".json", json, false);
                        if (!MulesoftPush.PostProduction(json)) {
                            LogHelper.LogSystemError(log, version, "Json NOT sent to Mulesoft");
                            this.ProductionFile.Warnings.Add(new WarningMessage(MessageType.Error, "Json NOT sent to Mulesoft"));
                        }
                    }
                }
            }
        }

        internal void RecordSuccess() {
            ProductionFile.RecordSuccess(this.AzureFullPathName, this.FileType, this.Inventory ? this.ProductionFile.SavedInventoryRecords.Count : this.ProductionFile.SavedRecords.Count);
        }

        internal static void SaveHearbeat(ILogger log) {
            string fileName = $"/master/heartbeat.txt";
            string contents = AzureFileHelper.ReadFile(fileName);

            TimeZoneInfo timeInfo = TimeZoneInfo.FindSystemTimeZoneById("Mountain Standard Time");
            DateTime mtTime = TimeZoneInfo.ConvertTime(DateTime.Now, timeInfo);
            string hbHistory = Utilities.GetHBHistory(contents, mtTime);

            AzureFileHelper.WriteFile(fileName, "Next Heartbeat:" + mtTime.AddMinutes(1).ToString("yyyy-MM-dd HH:mm:ss") + "\n" +
                "Last Heartbeat:" + mtTime.ToString("yyyy-MM-dd HH:mm:ss") + "\n" +
                "Missed Heartbeats" + "\n" +
                "=================" + "\n" +
                hbHistory, false);
        }

        public static DateTime GetCurrentDay(string plant, Boolean cleanUpFile) {
            DateTime day = DateTime.Today;
            string parentDirectory = plant;
            if (plant == "GP01" || plant == "GP02") parentDirectory = "CommerceCity";
            string fileName = parentDirectory + $"/system/currentDate.{plant}.txt";
            string currentDateString = AzureFileHelper.ReadFile(fileName);
            // only use the first line
            if (!String.IsNullOrEmpty(currentDateString)) {
                string currentDateString1stLine = currentDateString.Split('\n')[0];
                try {
                    day = DateTime.Parse(currentDateString1stLine);
                } catch (Exception ex) {
                    throw new Exception("Invalid Date Format for system/currentDate." + plant + ".txt");
                }
                if (cleanUpFile) CleanUpCurrentDateFile(plant);
            }
            return day;
        }

        public static void CleanUpCurrentDateFile(string plant) {
            string fileName = plant + $"/system/currentDate.{plant}.txt";
            string currentDateString = AzureFileHelper.ReadFile(fileName);
            if (!String.IsNullOrEmpty(currentDateString)) {
                AzureFileHelper.WriteFile(fileName.Replace(".txt", ".processed.txt"), currentDateString, false);
                AzureFileHelper.DeleteFile(fileName);
            }
        }

        public static void SetConnection(ILogger log) {
            IConfiguration iconfig = new ConfigurationBuilder()
            .AddEnvironmentVariables()  // needed for the ConnectionString - comes from local.settings.json or Azure Function Configuration 
//            .AddJsonFile("local.settings.json", true, true)
            .Build();
            string cs = iconfig["ConnectionStrings:DataHub"];
//            TestConectivity(log, cs);
            DBContextWithConnectionString.SetConnectionString(cs);

            string ProductionUrl = iconfig["ProductionPushUrl"];
            string ProductionUser = iconfig["ProductionPushUser"];
            string ProductionPW = iconfig["ProductionPushPassword"];

            string InventoryUrl = iconfig["InventoryPushUrl"];
            string InventoryUser = iconfig["InventoryPushUser"];
            string InventoryPW = iconfig["InventoryPushPassword"];

            MulesoftPush.SetConnection(ProductionUrl, ProductionUser, ProductionPW, InventoryUrl, InventoryUser, InventoryPW);
        }
        /*
        private static void TestConectivity(ILogger log, string cs) {
            try {
                string aw = Utilities.GetEnvironmentVariable("AzureWebJobsStorage");
                log.LogInformation($"Connection String:" + cs);
                SqlConnection conn = new SqlConnection(cs);
                conn.Open();
                SqlDataAdapter adapter = new SqlDataAdapter("select db_name()", conn);
                DataTable dt = new DataTable();
                int rows = adapter.Fill(dt);
                log.LogInformation($"filled rows:" + rows);
                log.LogInformation($"filled rows:" + dt.Rows[0][0].ToString());
                conn.Close();
            } catch (Exception ex) {
                log.LogInformation(ex, "can't connect");
            }
            //log.LogInformation($"AW Storage:" + aw);
            AzureFileHelper.WriteFile("system/" + ".AzureDataHubS.log", cs == null ? "empty - connection" : "cs:" + cs, true);
            //AzureFileHelper.WriteFile("system/" + ".AzureDataHubProduction.SS.log", aw == null ? "empty - storage" : "env:" + aw, true);        }
        }
        */
        public FoundFile(string dir, string azureFileName, byte[] bytes) {
            this.AzureFileName = azureFileName;
            this.AzureFullPathName = dir + "/" + azureFileName;
            this.BytesOfFile = bytes;
        }

        public Boolean IsHoneywellPB { get { return PlantName.ToUpper() == "CP01" || PlantName.ToUpper() == "CP04"; } }
        public Boolean IsMontrealSulphur { get { return PlantName.ToUpper() == "CP02"; } }
        public Boolean IsSarnia { get { return PlantName.ToUpper() == "CP03"; } }
        public Boolean IsDPS { get { return PlantName.ToUpper().Contains("AP"); } }
        public Boolean IsDenver { get { return PlantName.ToUpper().Contains("GP"); } }
        public Boolean IsTerraNova { get { return PlantName.ToUpper().Contains("EP"); } }
        public Boolean IsInventory {  get { return Inventory; } }

        public int FailedRecords { get; internal set; }
        public int SuccessfulRecords { get; internal set; }
        public string FileType { get { return IsInventory ? "Inventory" : "R2PLoad"; } }
    }
}
