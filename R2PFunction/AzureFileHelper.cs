using Azure;
using Azure.Storage.Files.Shares;
using Azure.Storage.Files.Shares.Models;
using Microsoft.Extensions.Logging;
using R2PFunction;
using R2PTransformation.src;
using R2PTransformation.src.db;
using SuncorR2P.src;
using System;
using System.Data;
using System.IO;

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
                    foundFile.ProcessFile(log, productVersion);
                    foundFile.DisposeOfFile();
                    foundFile.RecordSuccess();
                } catch (Exception ex) {
                    LogHelper.LogMessage(foundFile.PlantName, productVersion, "Fatal error with file " + foundFile.AzureFullPathName + " : " + ex.Message + ex.StackTrace);
                    AzureModel.RecordFailure(foundFile.PlantName, foundFile.AzureFullPathName, foundFile.SuccessfulRecords, foundFile.FailedRecords, ex.Message);
                    try {
                        foundFile.DisposeOfFile(true);
                    } catch (Exception ex2) { LogHelper.LogSystemError(log, productVersion, ex2); }
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

        internal static void ProcessModifiedTagMapping(string plant, string version) {
            // add/modify/delete tags mappings
            string suffix = "." + plant + ".csv";
            string tags = AzureFileHelper.ReadFile(tagMappingFile + suffix);
            if (tags != null) {
                DataTable tm = Utilities.ConvertCSVTexttoDataTable(tags);
                string output = AzureModel.UpdateTagMappings(plant, tm);
                LogHelper.LogMessage(plant, version, "Updated the following tag mappings:\r\n" + output);
                AzureFileHelper.WriteFile(tagMappingFileProcessed + suffix, tags, false);
                AzureFileHelper.DeleteFile(tagMappingFile + suffix);
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

        public static FoundFile ScanForANewFile() {
            ShareClient share = new ShareClient(CONNECTIONSTRING, SHARENAME);
            foreach (ShareFileItem item in share.GetRootDirectoryClient().GetFilesAndDirectories()) {  // loop through all plants
                if (item.Name == "System") continue;
                if (item.IsDirectory) {
                    var subDirectory = share.GetRootDirectoryClient().GetSubdirectoryClient(item.Name);
                    ShareDirectoryClient dir = subDirectory.GetSubdirectoryClient("immediateScan");
                    if (!dir.Exists()) continue;
                    foreach (var file in dir.GetFilesAndDirectories()) {
                        if (!file.IsDirectory) {
                            string tempFileName = Path.GetTempFileName();
                            DownloadFile(dir.GetFileClient(file.Name), tempFileName);
                            return new FoundFile(/*item.Name, */file.Name, dir.Path + "/" + file.Name, tempFileName);
                        }
                    }
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
