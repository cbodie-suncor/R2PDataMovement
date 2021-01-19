using R2PTransformation.src.db;
using System;
using System.Collections.Generic;
using System.IO;
using System.Text;

namespace R2PTransformation.src {
    public class HoneywellPBProductionRecord {
        private Dictionary<string, string> Values;
        public HoneywellPBFile ProductionFile;

        public HoneywellPBProductionRecord(Dictionary<string,string> values, HoneywellPBFile pf) {
            ProductionFile = pf;
            Values = values;
        }

        public string GetValue(string v) {
            return Values[v];
        }

        public decimal GetDecimalValue(string v) {
            return decimal.Parse(Values[v]);
        }

        public decimal InputProductCalc() {
            // INPUT Products: Closing_Inventory + Shipments + Consumption – Opening_Inventory – Receipts
            decimal value = GetDecimalValue("CLOSING_INVENTORY") + GetDecimalValue("SHIP_QUANTITY") + GetDecimalValue("NET_CONSUMPTION") - GetDecimalValue("OPENING_INVENTORY") - GetDecimalValue("RECEIPT_QUANTITY");
            return value;
        }

        public decimal OutputProductCalc() {
            // OUTPUT Products: Opening_Inventory + Receipts – Closing_Inventory – Shipments – Consumption
            decimal value = GetDecimalValue("OPENING_INVENTORY") + GetDecimalValue("RECEIPT_QUANTITY") - GetDecimalValue("CLOSING_INVENTORY") - GetDecimalValue("SHIP_QUANTITY") - GetDecimalValue("NET_CONSUMPTION");
            return value;
        }

        internal TagBalance TagBalance() {
            TagBalance tb = new TagBalance();

            tb.MovementType = "Production";
            tb.System = "Honeywell PB";

            tb.Tag = this.GetValue("PRODUCT_CODE");
            tb.Plant = this.ProductionFile.Plant;
            tb.Created = DateTime.Now;
            tb.BalanceDate = this.ProductionFile.GetAccountDate();
            tb.QuantityTimestamp = DateTime.Now;
            tb.CreatedBy = "DataHubProcess";
            TagMap tm = AzureModel.LookupTag(tb.Tag, tb.Plant);
            if (tm == null) { 
                SuncorProductionFile.Log(tb.Plant, "no TagMapping found for " + tb.BalanceDate + "," + tb.Plant + "," + tb.Tag);
                this.ProductionFile.FailedRecords.Add(tb);
                return null;
            }
            tb.StandardUnit = tm.DefaultUnit;
            tb.Plant = tm.Plant;
            tb.ValType = tm.DefaultValuationType;
            tb.WorkCenter = tm.WorkCenter;
            tb.Material = tm.MaterialNumber;
            try {
                tb.Quantity = this.GetAMMDTQuantity();
            }catch(Exception ex) {
                SuncorProductionFile.Log(tb.Plant, "NET YIELD FAILED : " + ex.Message + " for " + tb.BalanceDate + "," + tb.Plant + "," + tb.Tag);
                this.ProductionFile.FailedRecords.Add(tb);
                return null;
            }
            tb.BatchId = ProductionFile.BatchId.ToString();
            return tb;
        }

        public decimal GetAMMDTQuantity() {
            decimal netYield = GetDecimalValue("NET_YIELD");
            if (Math.Abs(netYield - InputProductCalc()) <= 1) return netYield;
            if (Math.Abs(netYield - OutputProductCalc()) <= 1) return -1 * netYield;
            throw new Exception("Net Yield does not match InputProductCalc or OutputProductCalc (tolerance of 1) : Product Code: " + GetValue("PRODUCT_CODE") + ", NetYield " + netYield + ", InputProductCalc: " + InputProductCalc() + ", OutputProductCalc: " + OutputProductCalc());
        }
    }
}
