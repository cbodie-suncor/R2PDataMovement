using Newtonsoft.Json;
using R2PTransformation.src.db;
using R2PTransformation.src;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Linq;

namespace R2PTransformation {
    public class HoneywellPBFile : SuncorProductionFile {
        
        public HoneywellPBFile(string fileName, string plant) : base(fileName) {
            Plant = plant;
        }

        public Dictionary<string, string> Defaults { get; set; }
        public Dictionary<string, string> Values { get; set; }

        public List<BalanceRecord> BalanceRecords = new List<BalanceRecord>();

        internal void SetDefaults(Dictionary<string,string> defaults) {
            Defaults = defaults;
        }

        public DateTime GetAccountDate() {
            // var accountDate = DateTime.ParseExact("28/09/2020 00:59:00", "DD/MM/YYYY HH24:MI:SS", CultureInfo.InvariantCulture);
            // var accountDate = DateTime.ParseExact("28/09/2020 13:59:00", "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture);
            string defaultDateTimeFormat = this.Defaults["DATETIMEFORMAT"];
            defaultDateTimeFormat = defaultDateTimeFormat.Replace("YYYY", "yyyy").Replace("DD", "dd").Replace("HH24", "HH").Replace("SS","ss").Replace("MI","mm");
            var accountDate = DateTime.ParseExact(this.Values["ACCOUNT_DATE"], defaultDateTimeFormat, CultureInfo.InvariantCulture);;
            return accountDate;
        }

        internal void SetValues(Dictionary<string, string> values) {
            Values = values;
        }

        private string GetValue(string v) {
            return Values[v];
        }

        public override List<TagBalance> GetTagBalanceRecords() {
            List<TagBalance> tbs = new List<TagBalance>();
            foreach (var item in this.ProductionRecords()) {
                TagBalance tb = item.TagBalance();
                if (tb != null) tbs.Add(tb);
            }
            return tbs;
        }

        public List<HoneywellPBProductionRecord> ProductionRecords() {
            return this.BalanceRecords.SelectMany(y => y.ProductionRecords).ToList();
        }
    }
}
