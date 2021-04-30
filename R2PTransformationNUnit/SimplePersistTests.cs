using Microsoft.Extensions.Configuration;
using Newtonsoft.Json;
using NUnit.Framework;
using R2PTransformation.Models;
using R2PTransformation.src;
using R2PTransformation;
using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Net.Http;
using System.Text;

namespace STransformNUnit {
    public class SimplePersistTests {
        static string baseTestURL = "https://aaasbxarmfapuw2015.azurewebsites.net/api/";
        string ROOTDIR = @"..\..\..\..\sampleFiles\MaterialMovement\";

        [SetUp]
        public void Setup() {
            DBContextWithConnectionString.CreateTestContext();
        }

        [Test]
        public void SimpleHierarchy2() {
            string json = File.ReadAllText(ROOTDIR + "Hierarchy2.json");
            SimplePersistentController.PersistHierarchy(json);
        }


        [Test]
        public void SimpleHierarchy3() {
            string json = File.ReadAllText(ROOTDIR + "Hierarchy3.json");
            SimplePersistentController.PersistHierarchy(json);
        }

        [Test]
        public void SimpleMaterialLedger2() {
            string json = File.ReadAllText(ROOTDIR + "MaterialLedger2.json");
            SimplePersistentController.PersistMaterialLedger(json);
        }

        [Test]
        public void SimpleMaterialLedger3() {
            string json = File.ReadAllText(ROOTDIR + "MaterialLedger3.json");
            SimplePersistentController.PersistMaterialLedger(json);
        }
    }
}
