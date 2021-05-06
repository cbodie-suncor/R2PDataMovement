using Microsoft.Extensions.Configuration;
using Microsoft.WindowsAzure.Storage.Blob;
using NUnit.Framework;
using R2PTransformation.Models;
using R2PTransformation.src;
using SuncorR2P;
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
            AzureModel.SaveInventory("filenamev", sf, sf.Inventory);
            Assert.AreEqual(78, sf.Inventory.Count());
        }

        [Test]
        public void TestMtl() {
            string contents = File.ReadAllText(@"..\..\..\..\sampleFiles\InventorySnapshot\mtphd.csv");

            contents = contents.Replace("\"", "");
            SuncorProductionFile sf = InventoryController.GetInventoryRecordsWithMultiTags(contents, "CP01", "OPIS");
            AzureModel.SaveInventory("filename", sf, sf.Inventory);
            Assert.AreEqual(27, sf.Inventory.Count());
            string json = sf.ExportInventory();
            MulesoftPush.PostInventory(json);
        }

        [Test]
        public void TestOilsands() {
            string contents = File.ReadAllText(@"..\..\..\..\sampleFiles\InventorySnapshot\Oilsandspi.csv");
            contents = contents.Replace("\"", "");
            SuncorProductionFile sf = InventoryController.GetInventoryRecordsWithSingleTag(contents, "AP01", "PI");
            AzureModel.SaveInventory("filename", sf, sf.Inventory);
            Assert.AreEqual(125, sf.Inventory.Count());
        }

        [Test]
        public void Testsarnia() {
            string contents = File.ReadAllText(@"..\..\..\..\sampleFiles\InventorySnapshot\srphd.csv");
            contents = contents.Replace("\"", "");
            SuncorProductionFile sf = InventoryController.GetInventoryRecordsWithSingleTag(contents, "CP03", "PHD");
            AzureModel.SaveInventory("filename", sf, sf.Inventory);
            Assert.AreEqual(44, sf.Inventory.Count());
            //            Assert.AreEqual(46, missing.Count());
        }


        [Test]
        public void TstBlob() {
            string cs = "DefaultEndpointsProtocol=https;AccountName=aaasbxarmstauw2015;AccountKey=awVSOVgmAW7FbMY+9NOsvrlH6Wzwb+0WA9j3ZPbtLOr1gQoZi+EzVq5R1d0Yv5/44REY6BOpjXeAu/bldV70CA==;EndpointSuffix=core.windows.net";
            var items = BlobHelper.GetBlobFileList(cs, "silver", "nl/collection=batch/dataset=edmonton/");
        }
    }
}
