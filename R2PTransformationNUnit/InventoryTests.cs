using Microsoft.Extensions.Configuration;
using NUnit.Framework;
using R2PTransformation.Models;
using R2PTransformation.src;
using System;
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
            string srcFile = File.ReadAllText(@"..\..\..\..\sampleFiles\InventorySnapshot\edphd.csv");
            srcFile = srcFile.Replace("\"", "");
            DataTable dt = Utilities.ConvertCSVTexttoDataTable(srcFile);
            DateTime currentDay = new DateTime(2021, 04, 25);
            SuncorProductionFile sf = new SuncorProductionFile("edm");
            var invs = dt.AsEnumerable().Select(t => new HistorianTag(
                    t["site"].ToString(),
                    t["tag"].ToString(),
                    t["alias"].ToString(),
                    SuncorController.ParseDateTime(t, "datetime"),
                    SuncorController.ParseDecimal(t, "value"),
                    SuncorController.ParseDecimal(t, "avgvalue"),
                    t["strvalue"].ToString(),
                    SuncorController.ParseDecimal(t, "quality")
            ));

            var groups = invs.GroupBy(t => new { t.Site, t.BaseTag, t.Datetime }).Select(g => new { Key = g.Key, Count = g.Count(), Tank = g.Max(s => s.Tank), Tag = g.Max(s => s.StrValue), Quantity = g.Max(s => s.Value) });
            var missing = invs.GroupBy(t => new { t.Site, t.BaseTag, t.Datetime }).Where(grp => grp.Count() == 1);
            //    .GroupBy); {
            //                sf.AddInventory()
            groups.ToList().ForEach(t => sf.AddInventory(currentDay, "Inventory", t.Key.Site, t.Tag, t.Tank, t.Key.Datetime, t.Quantity));
            AzureModel.SaveInventory("filename", sf, sf.Inventory);
            Assert.AreEqual(5000, invs.Count());
            Assert.AreEqual(46, missing.Count());
        }
    }

    internal class HistorianTag {
        public string Site { get; }
        public string Tag { get; }
        public string Alias { get; }
        public DateTime Datetime { get; }
        public decimal Value { get; }
        public decimal AvgValue { get; }
        public string StrValue { get; }
        public decimal Quality { get; }

        public HistorianTag(string site, string tag, string alias, DateTime datetime, decimal value, decimal avgValue, string strValue, decimal quality) {
            Site = site;
            Tag = tag;
            Alias = alias;
            Datetime = datetime;
            Value = value;
            AvgValue = avgValue;
            StrValue = strValue;
            Quality = quality;
        }

        public String BaseTag { get {
                int find = Tag.IndexOf(".");
                if (find == -1) find = Tag.IndexOf("_");
                if (find == -1) return Tag;
                return Tag.Substring(0, find);
         } }

        public String Tank {
            get {
                if (Site == "Oilsandspi") return null;
                return Alias.Replace(" Product code", "").Replace(" Net Volume", "").Replace(" Volume", "");
            }
        }


        public override bool Equals(object obj) {
            return obj is HistorianTag other &&
                   Site == other.Site &&
                   Tag == other.Tag &&
                   Alias == other.Alias &&
                   Datetime == other.Datetime &&
                   Value == other.Value &&
                   AvgValue == other.AvgValue &&
                   StrValue == other.StrValue &&
                   Quality == other.Quality;
        }

        public override int GetHashCode() {
            return HashCode.Combine(Site, Tag, Alias, Datetime, Value, AvgValue, StrValue, Quality);
        }
    }
}
