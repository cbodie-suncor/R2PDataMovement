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
            return HoneywellPBFile.ParseDecimal(Values[v]);
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

        public void TagBalance(DateTime currentDay) {
            decimal quantity;
            string product = this.GetValue("PRODUCT_CODE");
            DateTime balanceDate = this.ProductionFile.GetAccountDate();
            try {
                quantity = this.GetAMMDTQuantity();
            } catch (Exception ex) {
                SuncorProductionFile.Log(this.ProductionFile.Plant, "NET YIELD FAILED : " + ex.Message + " for " + balanceDate + "," + this.ProductionFile.Plant + "," + product);
                this.ProductionFile.FailedRecords.Add(new TagBalance() { Tag=product, BalanceDate = balanceDate});
                this.ProductionFile.Warnings.Add(new WarningMessage(product, "NET YIELD FAILED : " + ex.Message + " for " + balanceDate + "," + this.ProductionFile.Plant + "," + product));
                return;
            }
            this.ProductionFile.AddTagBalance(currentDay, "Honeywell PB", "Production", product, null, balanceDate,  quantity, GetDecimalValue("OPENING_INVENTORY"), GetDecimalValue("CLOSING_INVENTORY"), GetDecimalValue("SHIP_QUANTITY"), GetDecimalValue("RECEIPT_QUANTITY"));
        }

        public decimal GetAMMDTQuantity() {
            decimal netYield = GetDecimalValue("NET_YIELD");
            if (Math.Abs(netYield - InputProductCalc()) <= 1) return netYield;
            if (Math.Abs(netYield - OutputProductCalc()) <= 1) return -1 * netYield;
            throw new Exception("Net Yield does not match InputProductCalc or OutputProductCalc (tolerance of 1) : Product Code: " + GetValue("PRODUCT_CODE") + ", NetYield " + netYield + ", InputProductCalc: " + InputProductCalc() + ", OutputProductCalc: " + OutputProductCalc());
        }
    }
}
