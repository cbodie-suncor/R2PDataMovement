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

namespace STransformNUnit {
    public class SimplePersistTests {
        string ROOTDIR = @"..\..\..\..\sampleFiles\MaterialMovement\";

        [SetUp]
        public void Setup() {
            DBContextWithConnectionString.SetConnectionString("Data Source=inmdevarmsvruw2001.database.windows.net;Initial Catalog=inmdevarmsqluw2001;User ID=suncorsqladmin;password=AdvancedAnalytics2020;");
        }

        [Test]
        public void SimpleHierarchy() {
            string json = File.ReadAllText(ROOTDIR + "Hierarchy.json");
            SimplePersistentController.PersistHierarchy(json);
        }

        [Test]
        public void SimpleHierarchy2() {
            string json = File.ReadAllText(ROOTDIR + "Hierarchy2.json");
            SimplePersistentController.PersistHierarchy(json);
        }

        [Test]
        public void SimpleMaterialLedger() {
            string json = File.ReadAllText(ROOTDIR + "MaterialLedger.json");
            SimplePersistentController.PersistMaterialLedger(json);
        }

        [Test]
        public void SimpleMaterialLedger3() {
            string json = File.ReadAllText(ROOTDIR + "MaterialLedger2.json");
            SimplePersistentController.PersistMaterialLedger(json);
        }

    }
}
