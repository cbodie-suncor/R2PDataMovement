using R2PTransformation.Models;
using System;
using System.Collections.Generic;
using System.Text;

namespace R2PTransformation.src {
    public class BalanceRecord {
        public List<HoneywellPBProductionRecord> ProductionRecords { get; set; }
        public Dictionary<string, string> Values { get; set; }

        public BalanceRecord() {
            ProductionRecords = new List<HoneywellPBProductionRecord>();
        }

        internal void SetValues(Dictionary<string, string> values) {
            Values = values;
        }
    }
}
