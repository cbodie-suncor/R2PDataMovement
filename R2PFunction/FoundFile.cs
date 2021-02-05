using Microsoft.Extensions.Configuration;
using R2PTransformation;
using R2PTransformation.src;
using System;
using System.Collections.Generic;
using System.IO;
using System.Text;

namespace SuncorR2P.src {
    public class FoundFile {
        public string TempFileName;
        public string AzureFileName;
        public string AzureFullPathName;
        public string PlantName {
            get {
                DirectoryInfo d = new FileInfo(AzureFullPathName).Directory;
                string plant = d.Parent.Name;
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
            string destination = this.PlantName + "\\" + (this.SuccessfulRecords == 0 || fatal ? "rejected" : "archived") + "\\" + this.GetFileNameWithTimestampAppendedBeforeSuffix();
            AzureFileHelper.CopyToAzureFileShare(this.TempFileName, destination);
            AzureFileHelper.DeleteFile(this.AzureFullPathName);
            File.Delete(this.TempFileName);
        }

        internal void ProcessFile() {
            SuncorProductionFile.SetLogFileWriter(R2PLoader.WriteLogFile);
            SuncorProductionFile pf = null;
            DateTime day = GetCurrentDay();

            if (this.IsHoneywellPB)         { pf = new HoneywellPBParser().LoadFile(this.TempFileName, this.PlantName); }
            if (this.IsMontrealSulphur)     { pf = new MontrealSulphurParser().LoadFile(this.TempFileName, this.PlantName, this.ProductCode, day); }
            if (this.IsDPS)                 { pf = new DPSParser().LoadFile(this.TempFileName, this.PlantName, day); }
            if (this.IsSigmafine)           { pf = new SigmafineParser().LoadExcel(this.TempFileName, this.PlantName); }
            if (this.IsTerraNova)           { pf = new TerraNovaParser().LoadFile(this.TempFileName, this.PlantName, day); }
            if (this.IsSarnia)              { }
            if (pf != null) {
                pf.SaveRecords();
                string json = pf.ExportR2PJson();
                pf.RecordSuccess(this.AzureFullPathName);
                AzureFileHelper.WriteFile(this.AzureFullPathName.Replace("immediateScan", "tempJsonOutput") + ".json", json, false);
                this.SuccessfulRecords = pf.SavedRecords.Count;
                this.FailedRecords = pf.FailedRecords.Count;
            }
        }

        public static DateTime GetCurrentDay() {
            DateTime day = DateTime.Today;
            string currentDateString = AzureFileHelper.ReadFile("system/currentDate.txt");
            // only use the first line
            if (!String.IsNullOrEmpty(currentDateString)) {
                string currentDateString1stLine = currentDateString.Split('\n')[0];
                try {
                    day = DateTime.Parse(currentDateString1stLine);
                } catch (Exception ex) {
                    throw new Exception("Invalid Date Format for system/currentDate.txt");
                }
            }
            return day;
        }

        [Obsolete]
        public static void ProcessCommerceCity(DateTime day) {
            SuncorProductionFile.SetLogFileWriter(R2PLoader.WriteLogFile);
            R2PLoader.LogMessage("GP01", "Processing CommerceCity East");
            SigmafineFile ms = new SigmafineParser().Load(null, "GP01", day);
            ms.SaveRecords();
            string json = ms.ExportR2PJson();
            AzureFileHelper.WriteFile("GP01/tempJsonOutput/COmmerceCityEast.json", json, false);

            R2PLoader.LogMessage("GP02", "Processing CommerceCity West");
            ms = new SigmafineParser().Load(null, "GP02", day);
            ms.SaveRecords();
            json = ms.ExportR2PJson();
            AzureFileHelper.WriteFile("GP02/tempJsonOutput/COmmerceCityEast.json", json, false);
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
        public Boolean IsSigmafine { get { return PlantName.ToUpper().Contains("GP"); } }
        public Boolean IsTerraNova { get { return PlantName.ToUpper().Contains("EP"); } }

        public int FailedRecords { get; internal set; }
        public int SuccessfulRecords { get; internal set; }
    }
}
