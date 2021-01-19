using NUnit.Framework;
using R2PTransformation.src;
using R2PTransformation.src.db;
using System;
using System.Globalization;
using System.IO;
using System.Linq;

namespace STransformNUnit {
    public class TerraNovaTests {
        string ROOTDIR = @"..\..\..\..\sampleFiles\Terra Nova\";
        [SetUp]
        public void Setup() {
            DBContextWithConnectionString.SetConnectionString("Data Source=(local);Initial Catalog=suncor;Integrated Security=True;MultipleActiveResultSets=True;");
        }

        [Test]
        public void testBase() {
            string json = "";
            try {
                TerraNovaFile ms = new TerraNovaParser().LoadFile(ROOTDIR + "OIL-STORAGE-CORR-LD_Raw.csv", "EP01", new DateTime(2020, 09, 01));
                ms.SaveRecords();
                json = ms.ExportR2PJson();
                System.Console.WriteLine(json);
                SuncorProductionFile.LogSuccess(ms.FileName, ms, ms.GetTagBalanceRecords().Count, ms.FailedRecords.Count);
            } catch (Exception ex) {
                SuncorProductionFile.Log("EP01", ex);
            }
            File.WriteAllText(@"D:\projects\suncor\sampleFiles\Terra Nova\OIL-STORAGE-CORR-LD_Raw.json", json);
            Assert.IsTrue(json.Length > 0);
        }
    }
}
