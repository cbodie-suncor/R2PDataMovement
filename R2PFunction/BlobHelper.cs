using System;
using System.Linq;
using System.Collections.Generic;
using System.Text;
using System.Text.RegularExpressions;
using Microsoft.WindowsAzure.Storage.Blob;
using Microsoft.WindowsAzure.Storage;
using System.Threading.Tasks;
using System.Globalization;

namespace R2PTransformation.src {

    public class BlobHelper {
        public static string HISTORIANCONNECTIONSTRING = Utilities.GetEnvironmentVariable("HistorianStorage");

        public static void SetBlobCS(string name) {
            HISTORIANCONNECTIONSTRING = name;
        }

        public static List<BlobFile> GetBlobFileList(string containerName, string directory) {

            CloudStorageAccount storageAccount = CloudStorageAccount.Parse(HISTORIANCONNECTIONSTRING);
            CloudBlobClient blobClient = storageAccount.CreateCloudBlobClient();
            CloudBlobContainer container = blobClient.GetContainerReference(containerName);
            var dirContainer = container.GetDirectoryReference(directory);
            List<IListBlobItem> blobItems = dirContainer.ListBlobsSegmentedAsync(true, BlobListingDetails.All, null, null, null, null).GetAwaiter().GetResult().Results.ToList(); 

            List<BlobFile> files = new List<BlobFile>();
            foreach (var blobItem in blobItems) {
                if (blobItem is CloudBlobDirectory) continue;
                if (!((CloudBlockBlob)blobItem).Name.EndsWith("csv")) continue;
                CloudBlockBlob blockBlob = dirContainer.Container.GetBlockBlobReference(((CloudBlockBlob)blobItem).Name);
                string contents = blockBlob.DownloadTextAsync().GetAwaiter().GetResult();
                BlobFile file = new BlobFile() { RootFolder = directory, FullName = ((CloudBlockBlob)blobItem).Name, FullDirectoryName = blobItem.Parent.Prefix, Contents = contents };
                if (file.DateTime < DateTime.Today.AddDays(-8)) continue;
                files.Add(file);
            }
            return files;
        }
    }
}
