using NUnit.Framework;
using R2PTransformation.src;
using R2PTransformation.src.db;
using System;
using System.Data;
using System.Globalization;
using System.IO;
using System.Linq;

namespace STransformNUnit {
    public class GeneralTests {
        [SetUp]
        public void Setup() {
            DBContextWithConnectionString.SetConnectionString("Data Source=(local);Initial Catalog=suncor;Integrated Security=True;MultipleActiveResultSets=True;");
        }

        [Test]
        public void LoadTagMappings() {
            string tags = File.ReadAllText(@"..\..\..\..\sampleFiles\tagMappings.csv");
            DataTable tm = Utilities.ConvertCSVTexttoDataTable(tags);
            var output = AzureModel.UpdateTagMappings(tm);
            Console.WriteLine(output);
        }
        [Test]
        public void AddingSigmaTagMappings() {
            string tags = File.ReadAllText(@"..\..\..\..\sampleFiles\tagMappingsWithSigma.csv");
            DataTable tm = Utilities.ConvertCSVTexttoDataTable(tags);
            var output = AzureModel.UpdateTagMappings(tm);
            Console.WriteLine(output);
        }
    }
}
