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
using Microsoft.WindowsAzure.Storage;
using Microsoft.WindowsAzure.Storage.Blob;

namespace SuncorR2P {
    public class AzureFileHelper {

        public static string CONNECTIONSTRING = Utilities.GetEnvironmentVariable("AzureWebJobsStorage");
        public static string SHARENAME = "sap-iot-data";

        public static void CheckForFilesToBeProcessed(string productVersion, ILogger log) {
            FoundFile foundFile = null;
            Boolean errorState = false;
            while (true) {
                foundFile = null;
                try {
                    foundFile = AzureFileHelper.ScanForANewFile(errorState);
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
                    errorState = true;
                    Boolean result = AzureModel.RecordFileFailure(foundFile.FileType, foundFile.PlantName, foundFile.AzureFullPathName, foundFile.SuccessfulRecords, foundFile.FailedRecords, ex);
                    if (foundFile.PlantName == "CP03" && (ex.Message.Contains("no ULSD file found for the month") || ex.Message.Contains("No matching ULSD record"))) {  // do not delete the NPUpld file if no ULSD file or no matching record exists
                        AzureFileHelper.CopyToAzureFileShare(foundFile.BytesOfFile, foundFile.AzureFullPathName);
                    } else {
                        if (result) LogHelper.LogMessage(foundFile.PlantName, productVersion, "Fatal error with file " + foundFile.AzureFullPathName + " : " + ex.Message + ex.StackTrace);
                        foundFile.DisposeOfFile();
                    }
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

        private static readonly string prodTagMappingFile = "System/ProdTagMappings";
        private static readonly string prodTagMappingFileProcessed = "System/ProdTagMappings.processed";
        private static readonly string prodTagMappingFileError = "System/ProdTagMappings.error";

        private static readonly string invTagMappingFile = "System/InvTagMappings";
        private static readonly string invTagMappingFileProcessed = "System/InvTagMappings.processed";
        private static readonly string invTagMappingFileError = "System/InvTagMappings.error";

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

        public static void ProcessInventoryFromHistorian(ILogger log) {
            ProcessInventoryFromHistorian("nl/collection=batch/dataset=oilsands/", "AP01", "PI", log, TagType.SingleEntry);
            ProcessInventoryFromHistorian("nl/collection=batch/dataset=firebag/", "AP02", "PI", log, TagType.SingleEntry);
            ProcessInventoryFromHistorian("nl/collection=batch/dataset=mackay/", "AP03", "PI", log, TagType.SingleEntry);
            ProcessInventoryFromHistorian("nl/collection=batch/dataset=edmonton/", "CP04", "OPIS", log, TagType.MultipleTagForentry);
            ProcessInventoryFromHistorian("nl/collection=batch/dataset=montreal/", "CP01", "OPIS", log, TagType.MultipleTagForentry);
            ProcessInventoryFromHistorian("nl/collection=batch/dataset=sarnia/", "CP03", "PHD", log, TagType.SingleEntry);
        }

        public static void ProcessInventoryFromHistorian(string dir, string plant, string system, ILogger log, TagType tagType) {
            List<BlobFile> items = null;
            try {
                items = BlobHelper.GetBlobFileList("silver", dir);
            } catch(Exception ex) {
                AzureModel.RecordFileFailure("Inventory Snapshot", plant, null, 0, 0, ex);
                return;
            }

            string fileName = "";
            foreach (BlobFile file in items) {
                try {
                    fileName = file.FullName;
                    if (log == null) Console.WriteLine("Found " + file.FullName);
                    else log.LogInformation("Found " + file.FullName);
                    InventoryController.ProcessInventoryFile(file, plant, system, tagType);
                } catch (Exception ex) {
                    AzureModel.RecordFileFailure("Inventory Snapshot", plant, fileName, 0, 0, ex);
                }
            }
        }

        internal static void ProcessModifiedTagMapping(string plant, string version) {
            string parentDirectory = plant + "/";
            if (plant == "GP01" || plant == "GP02") parentDirectory = "CommerceCity/";

            ProcessTagMappings(plant, version, prodTagMappingFile, prodTagMappingFileProcessed, prodTagMappingFileError, "Prod");
            ProcessTagMappings(plant, version, invTagMappingFile, invTagMappingFileProcessed, invTagMappingFileError, "Inv");
            AzureFileHelper.DeleteFile(parentDirectory + "System/tagMappings.processed." + plant + ".csv");

            string currentDateString = $@"{DateTime.Today.ToString("yyyy-MM-dd")}
****use the format YYYY-MM-DD
****This date will specify to the R2P integration loader when to process the records in the next upload.";
            AzureFileHelper.WriteFile(parentDirectory + "System/currentDate." + plant + ".processed.txt", currentDateString, false);
        }

        internal static void ProcessTagMappings(string plant, string version, string tagFile, string processedFile, string errorFile, string type) {
            string parentDirectory = plant + "/";
            if (plant == "GP01" || plant == "GP02") parentDirectory = "CommerceCity/";
            string suffix = "." + plant + ".csv";
            string tagContents = null;
            try {
                tagContents = AzureFileHelper.ReadFile(parentDirectory + tagFile + suffix);
                if (tagContents != null) {
                    AzureFileHelper.ArchiveFile(parentDirectory + tagFile + suffix, tagContents, parentDirectory + processedFile + suffix);

                    DataTable tm = Utilities.ConvertCSVTexttoDataTable(tagContents);
                    List<WarningMessage> output = AzureModel.UpdateTagMappings(plant, tm, type);

                    LogHelper.LogMessage(plant, version, "Updated the following tag mappings:\r\n" + String.Join(",", output));
                    AzureModel.RecordStats("Load TagMaps", parentDirectory + tagFile + suffix, output, plant, output.Count(), 0, null);
                } else {
                    string processed = AzureFileHelper.ReadFile(parentDirectory + processedFile + suffix);
                    if (processed == null) { // create a processed file if not exists
                        AzureFileHelper.WriteFile(parentDirectory + processedFile + suffix, AzureModel.GetCurrentTagMapsCSV(plant, type), false);
                    }
                }
            } catch (Exception ex) {
                try {
                    AzureModel.RecordFatalLoad($"Load {type}TagMap", plant, ex, tagContents);
                    AzureFileHelper.WriteFile(parentDirectory + errorFile + suffix, tagContents, false);
                    AzureFileHelper.DeleteFile(parentDirectory + tagFile + suffix);
                } catch (Exception Ignore) { }
            }
        }

        internal static void ProcessConversions(string version) {
            // add/modify/delete tags mappings
            string parentDirectory = "Master/";
            string converionContents = null;
            try {
                converionContents = AzureFileHelper.ReadFile(parentDirectory + "conversion.csv");
                if (converionContents != null) {
                    AzureFileHelper.ArchiveFile(parentDirectory + "conversion.csv", converionContents, parentDirectory + "conversion.processed.csv");
                    DataTable tm = Utilities.ConvertCSVTexttoDataTable(converionContents);
                    int changes = AzureModel.UpdateConversions(tm);
                    LogHelper.LogMessage(null, version, $"Loaded {changes} conversions");
                    AzureModel.RecordStats("Load Conversions", parentDirectory + "conversion.csv", null, null, changes, 0, null);
                }
                AzureFileHelper.WriteFile(parentDirectory + "conversion.processed.csv", AzureModel.GetCurrentConversionsCSV(), false);
            } catch (Exception ex) {
                try {
                    AzureModel.RecordFatalLoad("Load Conversions", null, ex, converionContents);
                    AzureFileHelper.ArchiveFile(parentDirectory + "conversion.csv", converionContents, parentDirectory + "conversion.processed.csv");
                } catch (Exception Ignore) { }
            }
        }

        private static void ArchiveFile(string originalPath, string contents, string archivedFileAndPath) {
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

        private static byte[] GetBinaryStreamContents(ShareFileDownloadInfo file, string name) {
            byte[] bytes = new byte[file.ContentLength];
            if (file.ContentLength > int.MaxValue) throw new Exception("File too big to read " + name + ":" + file.ContentLength);

            using (BinaryReader br = new BinaryReader(file.Content)) {
                bytes = br.ReadBytes((int)file.ContentLength);
            }
            return bytes;
        }

        internal static bool UpdateULSDSplits(ILogger log, string version) {
            DateTime currentDate = FoundFile.GetCurrentDay("CP03", false);
            Boolean changes = UpdateULSDSplits(log, version, currentDate);
            if (currentDate.Day <= 10) changes = changes || UpdateULSDSplits(log, version, currentDate.AddMonths(-1));
            return changes;
        }

        internal static bool UpdateULSDSplits(ILogger log, string version, DateTime currentDay) {
            FoundFile ulsd = null;
            try {
                ulsd = GetULSDFileForCP03(currentDay);
                if (ulsd == null) return false;
                List<ShellSplit> ss = SarniaParser.LoadULSDSplits(ulsd.BytesOfFile);
                SuncorProductionFile pf = SarniaParser.UpdateShellSplits(ss);
                if (pf.SavedRecords != null) {
                    string json = pf.ExportProductionJson();
                    AzureFileHelper.WriteFile(ulsd.AzureFullPathName.Replace("ulsd", "diagnostic") + ".json", json, false);
                    if (!MulesoftPush.PostProduction(json)) {
                        LogHelper.LogSystemError(log, version, "Json NOT sent to Mulesoft");
                        pf.Warnings.Add(new WarningMessage(MessageType.Error, "Json NOT sent to Mulesoft"));
                    }
                    AzureModel.RecordStats("Load ULSD", ulsd.AzureFileName, null, "CP03", pf.SavedRecords.Count, 0, null);
                    return true;
                }
            } catch (Exception ex) {
                AzureModel.RecordFatalLoad("Load ULSD", "CP03", ex, "size:" + (ulsd == null ? "" : ulsd.AzureFileName) + " " + ex.Message + ":" + ex.StackTrace + (ex.InnerException == null ? "" : ex.InnerException.ToString()));
            }
            return false;
        }

        public static FoundFile GetULSDFileForCP03(DateTime month) {
            List<MatchingFile> matchingFiles = new List<MatchingFile>();
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
                            if (file.Name.StartsWith("thumbs")) continue;
                            if (file.Name.StartsWith("~")) continue;

                            if (!file.IsDirectory) {
                                if (!file.Name.Contains(month.Year.ToString())) continue;
                                if (!file.Name.ToLower().Contains(month.ToString("MMMM").ToLower())) continue;
                                ShareFileProperties fileProperties = dir.GetFileClient(file.Name).GetProperties();
                                matchingFiles.Add(new MatchingFile(file.Name, fileProperties.LastModified.DateTime));
                            }

                            if (matchingFiles.Count() == 0) return null;
                        }

                        // if more than 1 file matches year/month, then grab the latest (last changed)
                        matchingFiles = matchingFiles.OrderByDescending(t => t.LastModified).ToList();
                        if (matchingFiles.Count == 0) return null;

                        byte[] bytes = DownloadFile(dir.GetFileClient(matchingFiles[0].Filename));
                        return new FoundFile(dir.Path, matchingFiles[0].Filename, bytes);
                    }
                } catch (Exception ex) {
                    throw new Exception(item.Name + ":" + (tfile != null ? tfile.Name : "") + " " + ex.Message);
                }
            }
            return null;
        }


        internal static bool DoesRetriggerFileExist() {
            ShareClient share = new ShareClient(CONNECTIONSTRING, SHARENAME);
            ShareDirectoryClient dir = share.GetRootDirectoryClient().GetSubdirectoryClient("master");
            if (dir.GetFileClient("HistorianSnapshotTrigger.txt").Exists()) {
                AzureFileHelper.DeleteFile("master/HistorianSnapshotTrigger.txt");
                return true;
            }
            WriteFile("master/HistorianSnapshotTrigger.processed.txt", "abc", false);
            return false;
        }

        public static FoundFile ScanForANewFile(Boolean errorState) {
            ShareClient share = new ShareClient(CONNECTIONSTRING, SHARENAME);
            ShareFileItem tfile = null;
            foreach (ShareFileItem item in share.GetRootDirectoryClient().GetFilesAndDirectories()) {  // loop through all plants
                if (item.Name == "System") continue;
                if (item.Name == "Master") continue;
                try {
                    if (item.IsDirectory) {
                        var subDirectory = share.GetRootDirectoryClient().GetSubdirectoryClient(item.Name);
                        ShareDirectoryClient dir = subDirectory.GetSubdirectoryClient("immediateScan");
                        if (errorState && dir.Path.Contains("CP03")) continue;  // this is to bypass CP03 files on error with ulsd.  this exception requires the NPxxx.txt file to stay in immediateScan without a matching ULSD file

                        if (!dir.Exists()) continue;
                        foreach (var file in dir.GetFilesAndDirectories()) {
                            tfile = file;
                            if (file.Name.StartsWith("thumbs")) continue;
                            if (file.Name.StartsWith("~")) continue;
                            if (!file.IsDirectory) {
                                byte[] bytes = DownloadFile(dir.GetFileClient(file.Name));
                                return new FoundFile(dir.Path, file.Name, bytes);
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
            share.DeleteIfExists();
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

        public static void CopyToAzureFileShare(byte[] fileContents, string azurePath) {
            ShareFileClient newFile = new ShareFileClient(CONNECTIONSTRING, SHARENAME, azurePath);
            if (newFile.Exists()) newFile.Delete();
//            using (FileStream stream = File.OpenRead(localPath)) 
            {
                newFile.Create(fileContents.Length);
                if (fileContents.Length > 0)
                    newFile.UploadRange(new HttpRange(0, fileContents.Length), new MemoryStream(fileContents));
            }
        }

        private static byte[] DownloadFile(ShareFileClient file) {
            ShareFileDownloadInfo download = file.Download();
            byte[] abc = GetBinaryStreamContents(download, file.Name);
            return abc;
        }

        /*
        public async static FoundFile GetNextInventoryFile(string cs, string sharename) {

            string storageConnection = "DefaultEndpointsProtocol=https;AccountName=aaadevarmdlsuw2001;AccountKey=UIbHlnqziOKZecmClO4GunGdqNRyTko9uR8BHh9vJH0o6etIG0nEeNzZWP16Nu6fLhOC9zSdGonT42PMDpxFtA==;EndpointSuffix=core.windows.net";
            CloudStorageAccount cloudStorageAccount = CloudStorageAccount.Parse(storageConnection); CloudBlobClient blobClient = cloudStorageAccount.CreateCloudBlobClient();
            CloudBlobContainer container = blobClient.GetContainerReference("silver");
            BlobResultSegment allBlobs = await container.ListBlobsSegmentedAsync(null);

            foreach (IListBlobItem blob in allBlobs.Results) {
                try {
                    CloudBlockBlob blockblob = (CloudBlockBlob)blob;
                    blob.
                    ...
                ...
                ...
            } catch (Exception e) {
                    continue;
                }
            }


            ShareClient share = new ShareClient(cs, SHARENAME);
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
                            if (file.Name.StartsWith("thumbs")) continue;
                            if (file.Name.StartsWith("~")) continue;
                            if (!file.IsDirectory) {
                                byte[] bytes = DownloadFile(dir.GetFileClient(file.Name));
                                return new FoundFile(dir.Path, file.Name, bytes);
                            }
                        }
                    }
                } catch (Exception ex) {
                    throw new Exception(item.Name + ":" + (tfile != null ? tfile.Name : "") + " " + ex.Message);
                }
            }
            return null;
        }*/

    }
public class MatchingFile {
    public MatchingFile(string filename, DateTime lastModified) {
        Filename = filename;
        LastModified = lastModified;
    }

    public string Filename { get; set; }
    public DateTime LastModified { get; set; }
}
}
