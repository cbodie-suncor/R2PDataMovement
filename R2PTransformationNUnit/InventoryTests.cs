using Microsoft.Extensions.Configuration;
using Microsoft.WindowsAzure.Storage.Blob;
using NUnit.Framework;
using R2PFunction;
using R2PTransformation.Models;
using R2PTransformation.src;
using SuncorR2P;
using SuncorR2P.src;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;

namespace STransformNUnit {
    public class InventoryTests {
        [SetUp]
        public void Setup() {
            DBContextWithConnectionString.CreateTestContext();
        }

        [Test]
        public void TestEdm() {
            string contents = File.ReadAllText(@"..\..\..\..\sampleFiles\InventorySnapshot\edphd.csv");

            contents = contents.Replace("\"", "");
            SuncorProductionFile sf  = InventoryController.GetInventoryRecordsWithMultiTags(contents, "CP04", "OPIS");
            AzureModel.SaveInventory("filenamev", sf);
            Assert.AreEqual(78, sf.Inventory.Count());
        }

        [Test]
        public void TestMtl() {
            string contents = File.ReadAllText(@"..\..\..\..\sampleFiles\InventorySnapshot\mtphd.csv");

            contents = contents.Replace("\"", "");
            SuncorProductionFile sf = InventoryController.GetInventoryRecordsWithMultiTags(contents, "CP01", "OPIS");
            AzureModel.SaveInventory("filename", sf);
            Assert.AreEqual(77, sf.Inventory.Count());
            string json = sf.ExportInventory("CP01");
            MulesoftPush.PostInventory(json);
        }

        [Test]
        public void TestMtl2() {
            string contents = File.ReadAllText(@"..\..\..\..\sampleFiles\InventorySnapshot\mtphdSingle.csv");

            contents = contents.Replace("\"", "");
            SuncorProductionFile sf = InventoryController.GetInventoryRecordsWithMultiTags(contents, "CP01", "OPIS");
            AzureModel.SaveInventory("filename", sf);
            Assert.AreEqual(1, sf.Inventory.Count());
            string json = sf.ExportInventory("CP01");
            MulesoftPush.PostInventory(json);
        }

        [Test]
        public void TestOilsands() {
            string contents = File.ReadAllText(@"..\..\..\..\sampleFiles\InventorySnapshot\Oilsandspi.csv");
            contents = contents.Replace("\"", "");
            SuncorProductionFile sf = InventoryController.GetInventoryRecordsWithSingleTag(contents, "AP01", "PI");
            AzureModel.SaveInventory("filename", sf);
            Assert.AreEqual(125, sf.Inventory.Count());
        }

        [Test]
        public void Testsarnia() {
            string contents = File.ReadAllText(@"..\..\..\..\sampleFiles\InventorySnapshot\srphd.csv");
            contents = contents.Replace("\"", "");
            SuncorProductionFile sf = InventoryController.GetInventoryRecordsWithSingleTag(contents, "CP03", "PHD");
            AzureModel.SaveInventory("filename", sf);
            Assert.AreEqual(44, sf.Inventory.Count());
        }

        [Test]
        public void TstBlob() {
            string cs = "DefaultEndpointsProtocol=https;AccountName=aaasbxarmstauw2015;AccountKey=awVSOVgmAW7FbMY+9NOsvrlH6Wzwb+0WA9j3ZPbtLOr1gQoZi+EzVq5R1d0Yv5/44REY6BOpjXeAu/bldV70CA==;EndpointSuffix=core.windows.net";
            BlobHelper.SetBlobCS(cs);
            var items = BlobHelper.GetBlobFileList("silver", "nl/collection=batch/dataset=edmonton/");
        }

        public void TstAllHistorianLoad() {
            string cs = "DefaultEndpointsProtocol=https;AccountName=aaasbxarmstauw2015;AccountKey=awVSOVgmAW7FbMY+9NOsvrlH6Wzwb+0WA9j3ZPbtLOr1gQoZi+EzVq5R1d0Yv5/44REY6BOpjXeAu/bldV70CA==;EndpointSuffix=core.windows.net";
            BlobHelper.SetBlobCS(cs);
            FoundFile.SetConnection(null);
            SuncorProductionFile.SetLogFileWriter(SuncorProductionFile.LocalLogWriter);
//            AzureFileHelper.ProcessInventoryFromHistorian("nl/collection=batch/dataset=edmonton/", "CP04", "OPIS", null, TagType.MultipleTagForentry);
            AzureFileHelper.ProcessInventoryFromHistorian(null);
        }
    }
}
