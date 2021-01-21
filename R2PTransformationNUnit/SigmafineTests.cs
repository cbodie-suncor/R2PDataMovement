using NUnit.Framework;
using R2PTransformation.src;
using R2PTransformation.src.db;
using System;
using System.Data;
using System.Globalization;
using System.IO;
using System.Linq;

namespace STransformNUnit {
    public class SigmafineTests {
        string ROOTDIR = @"..\..\..\..\sampleFiles\CommerceCity\";
        [SetUp]
        public void Setup() {
            DBContextWithConnectionString.SetConnectionString("Data Source=(local);Initial Catalog=suncor;Integrated Security=True;MultipleActiveResultSets=True;");
        }

        [Test]
        public void testSingleDay() {
            SigmafineFile ms = new SigmafineParser().Load(null, "GP02", new DateTime(2020, 7, 11));
            ms.SaveRecords();
            decimal found = ms.Products.Single(t =>t.BalanceDate == new DateTime(2020, 11,7) && t.Tag == "E_FCCGASOLN" /*"EP FCC Gasoline"*/).Quantity.Value;
//            Assert.AreEqual(1202, found);
            Assert.AreEqual(-1173, found);
        }

        [Test]
        public void testAll() {
            SigmafineFile ms = new SigmafineParser().Load(null, "GP02", new DateTime(2020, 7, 11));
             ms.SaveRecords();
//            decimal found = ms.Products.Single(t => t.Tag == "E_FCCGASOLN" /*"EP FCC Gasoline"*/).Quantity.Value;
//            Assert.AreEqual(1202, found);
            string json = ms.ExportR2PJson();
            System.Console.WriteLine(json);
        }

        [Test]
        public void testOverrideWest() {
            string fileContents = File.ReadAllText(ROOTDIR + "sigmafine20210101.csv");
            SigmafineFile ms = new SigmafineParser().Load(fileContents, "GP01", new DateTime(2021, 1, 01));
            //            decimal found = ms.Products.Single(t => t.Tag == "E_FCCGASOLN" /*"EP FCC Gasoline"*/).Quantity.Value;
            //            Assert.AreEqual(1202, found);
            ms.SavedRecords = ms.GetTagBalanceRecords();
            string json = ms.ExportR2PJson();

            System.Console.WriteLine(json);
            File.WriteAllText(@"c:\temp\output.txt", json);
            ms.SaveRecords();
        }

        [Test]
        public void testOverrideAll() {
            string fileContents = File.ReadAllText(ROOTDIR + "decjan.csv");
            SigmafineFile ms = new SigmafineParser().Load(fileContents, "GP01", new DateTime(2021, 1, 01));
            //            decimal found = ms.Products.Single(t => t.Tag == "E_FCCGASOLN" /*"EP FCC Gasoline"*/).Quantity.Value;
            //            Assert.AreEqual(1202, found);
            ms.SavedRecords = ms.GetTagBalanceRecords();
            string json = ms.ExportR2PJson();

            System.Console.WriteLine(json);
            File.WriteAllText(@"c:\temp\output.txt", json);
            ms.SaveRecords();
        }

        [Test]
        public void testOverrideWest2() {
            string fileContents = File.ReadAllText(ROOTDIR + "sigmafine2021106.csv");
            SigmafineFile ms = new SigmafineParser().Load(fileContents, "GP01", new DateTime(2020, 7, 11));
            //            decimal found = ms.Products.Single(t => t.Tag == "E_FCCGASOLN" /*"EP FCC Gasoline"*/).Quantity.Value;
            //            Assert.AreEqual(1202, found);
            ms.SavedRecords = ms.GetTagBalanceRecords();
            string json = ms.ExportR2PJson();

            System.Console.WriteLine(json);
            File.WriteAllText(@"c:\temp\output.txt", json);
            ms.SaveRecords();
        }
    }
}
