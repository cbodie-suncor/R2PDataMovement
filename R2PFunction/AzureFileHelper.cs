using Azure;
using Azure.Storage.Files.Shares;
using Azure.Storage.Files.Shares.Models;
using Microsoft.Extensions.Logging;
using R2PFunction;
using R2PTransformation.src;
using R2PTransformation.Models;
using SuncorR2P.src;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using static R2PTransformation.src.SarniaParser;

namespace SuncorR2P {
    public class AzureFileHelper {

        public static string CONNECTIONSTRING = Utilities.GetEnvironmentVariable("AzureWebJobsStorage");
        public static string SHARENAME = "sap-iot-data";

        public static void CheckForFilesToBeProcessed(string productVersion, ILogger log) {
            FoundFile foundFile = null;
            while (true) {
                foundFile = null;
                try {
                    foundFile = AzureFileHelper.ScanForANewFile();
                } catch (Exception ex) { LogHelper.LogSystemError(log, productVersion, ex); }

                if (foundFile == null) break;

                try {
                    string msg = "Processing the file " + foundFile.PlantName + "," + foundFile.AzureFileName;
                    log.LogInformation("*** " + msg + $" at: {DateTime.Now}" + ":" + productVersion);
                    LogHelper.LogMessage(foundFile.PlantName, productVersion, msg);
                    foundFile.DeleteOriginalFile();
                    foundFile.ProcessFile(log, productVersion);
                    foundFile.RecordSuccess();
                    foundFile.DisposeOfFile();
                } catch (Exception ex) {
                    LogHelper.LogMessage(foundFile.PlantName, productVersion, "Fatal error with file " + foundFile.AzureFullPathName + " : " + ex.Message + ex.StackTrace);
                    AzureModel.RecordFileFailure(foundFile.FileType, foundFile.PlantName, foundFile.AzureFullPathName, foundFile.SuccessfulRecords, foundFile.FailedRecords, ex);
                    foundFile.DisposeOfFile();
                }
            }
        }

        public static void WriteFile(string fullPath, string output, Boolean append) {
            ShareFileClient file = new ShareFileClient(CONNECTIONSTRING, SHARENAME, fullPath);

            string original = "";
            if (!append && file.Exists()) file.Delete();
            if (append) {
                if (file.Exists()) {
                    ShareFileDownloadInfo download = file.Download();
                    original = GetStreamContents(download.Content) + "\n";
                }
            }

            using (Stream outStream = GenerateStreamFromString(original + output)) {
//                if (!file.Exists()) 
                    file.Create(outStream.Length);
                file.UploadRange(new HttpRange(0, outStream.Length), outStream);
            }
        }

        private static readonly string tagMappingFile = "System/tagMappings";
        private static readonly string tagMappingFileProcessed = "System/tagMappings.processed";
        private static readonly string tagMappingFileError = "System/tagMappings.error";

        internal static void ProcessModifiedTagMappings(string version) {
            ProcessModifiedTagMapping("AP01", version);
            ProcessModifiedTagMapping("AP02", version);
            ProcessModifiedTagMapping("AP03", version);
            ProcessModifiedTagMapping("CP01", version);
            ProcessModifiedTagMapping("CP02", version);
            ProcessModifiedTagMapping("CP03", version);
            ProcessModifiedTagMapping("CP04", version);
            ProcessModifiedTagMapping("EP01", version);
            ProcessModifiedTagMapping("GP01", version);
            ProcessModifiedTagMapping("GP02", version);
        }

        internal static void ProcessConversions(string version) {
            // add/modify/delete tags mappings
            string parentDirectory = "Master/";
            string converionContents = null;
            try {
                converionContents = AzureFileHelper.ReadFile(parentDirectory + "conversion.csv");
                if (converionContents != null) {
                    AzureFileHelper.ArchiveFile("Load Conversions", parentDirectory + "conversion.csv", converionContents, parentDirectory + "conversion.processed.csv");
                    DataTable tm = Utilities.ConvertCSVTexttoDataTable(converionContents);
                    List<WarningMessage> output = AzureModel.UpdateConversions(tm);
                    LogHelper.LogMessage(null, version, "Updated the following conversions:\r\n" + String.Join(",",output));
                    AzureModel.RecordStats("Load Conversions", parentDirectory + "conversion.csv", output, null, output.Count(), 0, null);
                } else {
                    string processed = AzureFileHelper.ReadFile(parentDirectory + "conversion.processed.csv");
                    if (processed == null) { // create a processed file if not exists
                        AzureFileHelper.WriteFile(parentDirectory + "conversion.processed.csv", AzureModel.GetCurrentConversionsCSV(), false);
                    }
                }
            } catch (Exception ex) {
                try {
                    AzureModel.RecordFatalLoad("Load Conversions", null, ex, converionContents);
                    AzureFileHelper.ArchiveFile("Load Conversions", parentDirectory + "conversion.csv", converionContents, parentDirectory + "conversion.processed.csv");
                } catch (Exception Ignore) { }
            }
        }

        internal static void ProcessModifiedTagMapping(string plant, string version) {
            // add/modify/delete tags mappings
            string parentDirectory = plant + "/";
            if (plant == "GP01" || plant == "GP02") parentDirectory = "CommerceCity/";
            string suffix = "." + plant + ".csv";
            string tagContents = null;
            try {
                tagContents = AzureFileHelper.ReadFile(parentDirectory + tagMappingFile + suffix);
                if (tagContents != null) {
                    AzureFileHelper.ArchiveFile("Load TagMaps", parentDirectory + tagMappingFile + suffix, tagContents, parentDirectory + tagMappingFileProcessed + suffix);

                    DataTable tm = Utilities.ConvertCSVTexttoDataTable(tagContents);
                    List<WarningMessage> output = AzureModel.UpdateTagMappings(plant, tm);
                    LogHelper.LogMessage(plant, version, "Updated the following tag mappings:\r\n" + String.Join(",", output));
                    AzureModel.RecordStats("Load TagMaps", parentDirectory + tagMappingFile + suffix, output, plant, output.Count(), 0, null);
                } else {
                    string processed = AzureFileHelper.ReadFile(parentDirectory + tagMappingFileProcessed + suffix);
                    if (processed == null) { // create a processed file if not exists
                        AzureFileHelper.WriteFile(parentDirectory + tagMappingFileProcessed + suffix, AzureModel.GetCurrentTagMapsCSV(plant), false);

                        string currentDateString = @"2021-05-31
****use the format YYYY - MM - DD
****This date will specify to the R2P integration loader when to process the records in the next upload.";
                        AzureFileHelper.WriteFile(parentDirectory + "System/currentDate." + plant + ".processed.txt", currentDateString, false);
                    }
                }
            } catch (Exception ex) {
                try {
                    AzureModel.RecordFatalLoad("Load TagMap", plant, ex, tagContents);
                    AzureFileHelper.WriteFile(parentDirectory + tagMappingFileError + suffix, tagContents, false);
                    AzureFileHelper.DeleteFile(parentDirectory + tagMappingFile + suffix);
                } catch (Exception Ignore) { }
            }
        }

        private static void ArchiveFile(string type, string originalPath, string contents, string archivedFileAndPath) {
            try {
                AzureFileHelper.DeleteFile(originalPath);
            } catch (Exception ex) {
                throw new OriginalFileLockException(originalPath + " has a file lock and is NOT PROCESSED");
            }
            try {
                AzureFileHelper.WriteFile(archivedFileAndPath, contents, false);
            } catch (Exception ex) {
                throw new Exception("Can not create archive file " + archivedFileAndPath);
            }
        }

        private static Stream GenerateStreamFromString(string s) {
            var stream = new MemoryStream();
            var writer = new StreamWriter(stream);
            writer.Write(s);
            writer.Flush();
            stream.Position = 0;
            return stream;
        }

        private static string GetStreamContents(Stream stream) {
            StreamReader reader = new StreamReader(stream);
            string text = reader.ReadToEnd();
            return text;
        }

        internal static void UpdateULSDSplits(DateTime currentDay) {
            try {
                FoundFile ulsd = GetULSDFileForCP03(currentDay);
                if (ulsd == null) return;
                List<ShellSplit> ss = SarniaParser.LoadULSDSplits(ulsd.TempFileName);
                int changes = SarniaParser.UpdateShellSplits(ss, currentDay);
                AzureModel.RecordStats("Load ULSD", ulsd.AzureFileName, null, "CP03", changes, 0, null);
            } catch (Exception ex) {
                AzureModel.RecordFatalLoad("Load TagMap", "CP03", ex, null);
            }
        }

        public static FoundFile GetULSDFileForCP03(DateTime month) {
            ShareClient share = new ShareClient(CONNECTIONSTRING, SHARENAME);
            ShareFileItem tfile = null;
            foreach (ShareFileItem item in share.GetRootDirectoryClient().GetFilesAndDirectories()) {  // loop through all plants
                if (item.Name == "System") continue;
                if (item.Name == "Master") continue;
                if (item.Name != "CP03") continue;

                try {
                    if (item.IsDirectory) {
                        var subDirectory = share.GetRootDirectoryClient().GetSubdirectoryClient(item.Name);
                        ShareDirectoryClient dir = subDirectory.GetSubdirectoryClient("ulsd");
                        if (!dir.Exists()) continue;
                        foreach (var file in dir.GetFilesAndDirectories()) {
                            tfile = file;
                            if (!file.IsDirectory) {
                                if (!file.Name.Contains(month.Year.ToString())) continue;
                                if (!file.Name.ToLower().Contains(month.ToString("MMMM").ToLower())) continue;
                                string tempFileName = Path.GetTempFileName();
                                DownloadFile(dir.GetFileClient(file.Name), tempFileName);
                                return new FoundFile(/*item.Name, */file.Name, dir.Path + "/" + file.Name, tempFileName);
                            }
                        }
                    }
                } catch (Exception ex) {
                    throw new Exception(item.Name + ":" + (tfile != null ? tfile.Name : "") + " " + ex.Message);
                }
            }
            return null;
        }

        public static FoundFile ScanForANewFile() {
            ShareClient share = new ShareClient(CONNECTIONSTRING, SHARENAME);
            ShareFileItem tfile = null;
            foreach (ShareFileItem item in share.GetRootDirectoryClient().GetFilesAndDirectories()) {  // loop through all plants
                if (item.Name == "System") continue;
                if (item.Name == "Master") continue;
                try {
                    if (item.IsDirectory) {
                        var subDirectory = share.GetRootDirectoryClient().GetSubdirectoryClient(item.Name);
                        ShareDirectoryClient dir = subDirectory.GetSubdirectoryClient("immediateScan");
                        if (!dir.Exists()) continue;
                        foreach (var file in dir.GetFilesAndDirectories()) {
                            tfile = file; 
                            if (!file.IsDirectory) {
                                string tempFileName = Path.GetTempFileName();
                                DownloadFile(dir.GetFileClient(file.Name), tempFileName);
                                return new FoundFile(/*item.Name, */file.Name, dir.Path + "/" + file.Name, tempFileName);
                            }
                        }
                    }
                } catch (Exception ex) {
                    throw new Exception(item.Name + ":" + (tfile != null ? tfile.Name : "") + " " + ex.Message);
                }
            }
            return null;
        }

        public static void DeleteFile(string fullPath) {
            ShareFileClient share = new ShareFileClient(CONNECTIONSTRING, SHARENAME, fullPath);
            share.Delete();
        }

        public static string ReadFile(string azurePath) {
            string text = "";
            ShareFileClient file = new ShareFileClient(CONNECTIONSTRING, SHARENAME, azurePath);
            if (!file.Exists()) return null;
            using (Stream stream = file.OpenRead()) {
                StreamReader reader = new StreamReader(stream);
                text = reader.ReadToEnd();
            }
            return text;
        }

        public static void CopyToAzureFileShare(string localPath, string azurePath) {
            ShareFileClient newFile = new ShareFileClient(CONNECTIONSTRING, SHARENAME, azurePath);
            if (newFile.Exists()) newFile.Delete();
            using (FileStream stream = File.OpenRead(localPath)) {
                newFile.Create(stream.Length);
                if (stream.Length > 0)
                    newFile.UploadRange(new HttpRange(0, stream.Length), stream);
            }
        }

        private static void DownloadFile(ShareFileClient file, string localFilePath) {
            long fileLength = 0;
            using (Stream stream = file.OpenRead()) {
                var properties = file.GetProperties();
                fileLength = stream.Length;
            }
            if (fileLength == 0) {  // handle 0 length files
                FileStream fs = File.Create(localFilePath);
                fs.Close();
                return;
            }
            ShareFileDownloadInfo download = file.Download();
            using (FileStream stream = File.OpenWrite(localFilePath)) {
                download.Content.CopyTo(stream);
            }
        }
    }
 }
