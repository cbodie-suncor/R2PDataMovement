using Azure;
using Azure.Storage.Files.Shares;
using Azure.Storage.Files.Shares.Models;
using R2PTransformation.src;
using R2PTransformation.src.db;
using SuncorR2P.src;
using System;
using System.Data;
using System.IO;

namespace SuncorR2P {
    public class AzureFileHelper {

//        public static string CONNECTIONSTRING = "DefaultEndpointsProtocol=https;AccountName=aaasbxarmstauw2015;AccountKey=awVSOVgmAW7FbMY+9NOsvrlH6Wzwb+0WA9j3ZPbtLOr1gQoZi+EzVq5R1d0Yv5/44REY6BOpjXeAu/bldV70CA==;EndpointSuffix=core.windows.net";
//        public static string CONNECTIONSTRING = "DefaultEndpointsProtocol=https;AccountName=pbidevarmsta001;AccountKey=zr5ggYWe7drKizlyAR/8c2vj7j/piTUPrwBsSuYYT77lvQHAMCcHWbxCDLav2EotCkyrWV5eXoZeNB+enoi8Fg==;EndpointSuffix=core.windows.net";
        public static string CONNECTIONSTRING = R2PLoader.GetEnvironmentVariable("AzureWebJobsStorage");
        public static string SHARENAME = "sap-iot-data";

        public static void WriteFile(string fullPath, string output, Boolean append) {
//            output = DateTime.Now.ToUniversalTime() + " " + output;
            ShareFileClient file = new ShareFileClient(CONNECTIONSTRING, SHARENAME, fullPath);
//            ShareDirectoryClient directory = share.GetDirectoryClient(directoryName);
//            ShareFileClient file = directory.GetFileClient(logFile); // get original contents

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

        private static readonly string tagMappingFile = "System/tagMappings.csv";
        private static readonly string tagMappingFileProcessed = "System/tagMappings.processed.csv";

        internal static void ProcessModifiedTagMapping() {
            // add/modify/delete tags mappings
            string tags = AzureFileHelper.ReadFile(tagMappingFile);
            if (tags != null) {
                DataTable tm = Utilities.ConvertCSVTexttoDataTable(tags);
                string output = AzureModel.UpdateTagMappings(tm);
                R2PLoader.LogMessage(null, "Updated the following tag mappings:\r\n" + output);
                AzureFileHelper.WriteFile(tagMappingFileProcessed, tags, false);
                AzureFileHelper.DeleteFile(tagMappingFile);
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
