using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using NUnit.Framework;
using R2PTransformation.src;
using R2PTransformation.Models;
using System;
using System.Collections.Generic;
using System.IO;
using System.Net.Http;
using System.Text;
using Microsoft.Extensions.Primitives;

namespace R2PTransformationNUnit {
    public class MaterialMovementTest {
        static string baseTestURL = "https://aaasbxarmfapuw2015.azurewebsites.net/api/";
        string ROOTDIR = @"..\..\..\..\sampleFiles\MaterialMovement\";

        [SetUp]
        public void Setup() {
            DBContextWithConnectionString.CreateTestContext();
        }

        [Test]
        public void JsonTest() {
            string json = File.ReadAllText(ROOTDIR + "sample.json");
            object obj = JsonConvert.DeserializeObject(json);
            Assert.True(1 == 1); ;
        }

        [Test]
        public void JsonTest2() {
            string json = File.ReadAllText(ROOTDIR + "sample2e.json");
            new ProductionMatDocController().Persist(json);
            Assert.True(1 == 1); ;
        }

        [Test]
        public void JsonTest4() {
            string json = File.ReadAllText(ROOTDIR + "sample4.json");
            new ProductionMatDocController().Persist(json);
            Assert.True(1 == 1); ;
        }

        [Test]
        public void JsonTest5() {
            string json = File.ReadAllText(ROOTDIR + "sample5.json");
            new ProductionMatDocController().Persist(json);
            Assert.True(1 == 1); ;
        }
    }
}
