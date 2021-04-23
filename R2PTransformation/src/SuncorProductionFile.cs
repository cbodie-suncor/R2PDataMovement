using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using R2PTransformation.Models;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;

namespace R2PTransformation.src {
    public class SuncorProductionFile {
        public Guid BatchId;
        public string FileName;
        public string Plant;
        public List<WarningMessage> Warnings = new List<WarningMessage>();
        public List<TagBalance> Products { get; set; }
        public List<InventorySnapshot> Inventory { get; set; }

        public SuncorProductionFile(string plant, string fileName) {
            BatchId = Guid.NewGuid();
            Plant = plant;
            FileName = fileName;
            FailedRecords = 0;
            Products = new List<TagBalance>();
            Inventory = new List<InventorySnapshot>();
        }

        public virtual List<TagBalance> GetTagBalanceRecords() {
            return Products;
        }

        public int FailedRecords;
        public List<TagBalance> SavedRecords;
        public List<InventorySnapshot> SavedInventoryRecords;

        public void IsCurrentDay(DateTime currentDay) {
            if (currentDay != DateTime.Today) {
                Warnings.Add(new WarningMessage(MessageType.Info, "Using " + currentDay.ToString("yyyy/MM/dd") + " as a override date"));
            }
        }

        public string ExportProductionJson() {
            if (this.SavedRecords == null) throw new Exception("Please call SuncorProductionFile.SaveRecords before ExportTR2PJson");
            var records = this.SavedRecords.Select(t => new {
                Date = t.BalanceDate,
                Tag = t.Tag,
                System = t.System,
                MovementType = t.MovementType,
                Material = t.Material,
                Plant = t.Plant,
                WorkCenter = t.WorkCenter,
                ValType = t.ValType,
                BalanceDate = t.BalanceDate,
                Quantity = t.Quantity.Value.ToString(),
                Uom = t.StandardUnit
            });
            var batch = new { CreatedBy = "R2P", Created = DateTime.Now, BatchId = this.BatchId, TagBalance = records.Where(t => t.Quantity != "" && t.ValType != "Presplit") };
            return JsonConvert.SerializeObject(batch);
        }
        public string ExportInventory() {
            if (this.SavedInventoryRecords == null) throw new Exception("Please call SuncorProductionFile.SaveInventory before ExportInventory");
            var records = this.SavedInventoryRecords.Select(t => new {
                Date = t.QuantityTimestamp,
                Tag = t.Tag,
                Tank = t.Tank,
                System = t.System,
                MovementType = t.MovementType,
                Material = t.Material,
                Plant = t.Plant,
                WorkCenter = t.WorkCenter,
                ValType = t.ValType,
                BalanceDate = t.QuantityTimestamp,
                Closing = t.Quantity.Value.ToString(),
                Uom = t.StandardUnit
            });
            var batch = new { CreatedBy = "P2C", Created = DateTime.Now, BatchId = this.BatchId, TagBalance = records.Where(t => t.Closing != "") };
            return JsonConvert.SerializeObject(batch);
        }

        public void AddInventory(DateTime currentDay, string movementType, string system, string productCode, string tank, DateTime balanceDate, decimal? quantity) {
            InventorySnapshot inv = new InventorySnapshot();
            inv.MovementType = movementType;
            inv.System = system;
            inv.Tag = productCode;
            inv.Plant = this.Plant;
            inv.LastUpdated = DateTime.Now;
            inv.QuantityTimestamp = balanceDate;
            inv.CreatedBy = "R2PLoader";
            TagMap tm = AzureModel.LookupTag(inv.Tag, inv.Plant, "Inv");
            if (tm == null) {
                Warnings.Add(new WarningMessage(MessageType.Error, inv.Tag, "No TagMapping"));
                this.FailedRecords++;
                return;
            }

            inv.Confidence = 100;
            inv.StandardUnit = tm.DefaultUnit;
            inv.Tank = tank;
            inv.Plant = tm.Plant;
            inv.ValType = tm.DefaultValuationType;
            inv.WorkCenter = tm.WorkCenter;
            inv.Material = tm.MaterialNumber;
            if (quantity.HasValue) inv.Quantity = Math.Round(quantity.Value, 3);
            inv.BatchId = this.BatchId.ToString();

            if (!IsDayValid(balanceDate, currentDay)) {
                this.Warnings.Add(new WarningMessage(MessageType.Error, inv.Tag, "Invalid Date " + balanceDate.ToString("yyyy/MM/dd")));
                this.FailedRecords++;
            } else {
                this.Inventory.Add(inv);
            }
            return;
        }

        public void AddTagBalance(DateTime processingDate, string movementType, string system, string productCode, string tank, DateTime balanceDate, decimal? quantity, decimal? openingInventory, decimal? closingInventory, decimal? shipments, decimal? receipts, decimal? consumption) {
            TagBalance tb = new TagBalance();
            tb.MovementType = movementType;
            tb.System = system;
            tb.Tag = productCode;
            tb.Plant = this.Plant;
            tb.LastUpdated = DateTime.Now;
            tb.BalanceDate = balanceDate;
            tb.CreatedBy = "R2PLoader";
            TagMap tm = AzureModel.LookupTag(tb.Tag, tb.Plant, "Prod");
            if (tm == null) {
                Warnings.Add(new WarningMessage(MessageType.Error, tb.Tag, "No TagMapping"));
                this.FailedRecords++;
                return;
            }

            tb.StandardUnit = tm.DefaultUnit;
            tb.Plant = tm.Plant;
            tb.ValType = tm.DefaultValuationType;
            tb.WorkCenter = tm.WorkCenter;
            tb.Material = tm.MaterialNumber;
            if (quantity.HasValue) tb.Quantity = Math.Round(quantity.Value, 3);
            if (openingInventory.HasValue) tb.OpeningInventory = Math.Round(openingInventory.Value, 3);
            if (closingInventory.HasValue) tb.ClosingInventory = Math.Round(closingInventory.Value, 3);
            if (shipments.HasValue) tb.Shipment = Math.Round(shipments.Value, 3);
            if (receipts.HasValue) tb.Receipt = Math.Round(receipts.Value, 3);
            if (consumption.HasValue) tb.Consumption = Math.Round(consumption.Value, 3);
            tb.BatchId = this.BatchId.ToString();

            if (!IsDayValid(balanceDate, processingDate)) {
                this.Warnings.Add(new WarningMessage(MessageType.Error, tb.Tag, "Invalid Date " + balanceDate.ToString("yyyy/MM/dd")));
                this.FailedRecords++;
            } else {
                this.Products.Add(tb);
            }
            return;
        }

        private static string LogFileName = "AzureDataHub.log";
        private static string CRLF = "\r\n";

        public void SaveRecords() {
            List<TagBalance> tb = this.GetTagBalanceRecords();
            AzureModel.SaveTagBalance(FileName, this, tb);
        }

        public static int ParseInt(Object v, string columnName) {
            try {
                return string.IsNullOrEmpty(v.ToString()) ? 0 : int.Parse(v.ToString());
            } catch (Exception ex) {
                throw new Exception("Invalid Number for " + columnName);
            }
        }
        public static decimal ParseDecimal(object v, string columnName) {
            try {
                return string.IsNullOrEmpty(v.ToString()) ? 0 : decimal.Parse(v.ToString());
            } catch (Exception ex) {
                throw new Exception("Invalid Number for " + columnName);
            }
        }

        public static double ParseDouble(object v, string columnName) {
            try {
                return string.IsNullOrEmpty(v.ToString()) ? 0 : double.Parse(v.ToString());
            } catch (Exception ex) {
                throw new Exception("Invalid Number for " + columnName);
            }
        }

        public static DateTime ParseDateTime(object v, string columnName) {
            try {
                return DateTime.Parse(v.ToString());
            } catch (Exception ex) {
                throw new Exception("Invalid Date for " + columnName + ":'" + (v == null ? "" : v.ToString()) + "'");
            }
        }

        public static bool IsDayValid(DateTime balanceDate, DateTime processingDate) {
            if (balanceDate.Date > processingDate.Date) return false;
            if (processingDate.Day <= 10) {
                DateTime firstOfPriorMonth = new DateTime(processingDate.AddMonths(-1).Year, processingDate.AddMonths(-1).Month, 1);
                return firstOfPriorMonth <= balanceDate; // accept dates in current and prior month
            } else {
                return balanceDate.Month == processingDate.Month && balanceDate.Year == processingDate.Year; // only accept dates in month
            }
        }

        public void RecordSuccess(string fileName, string type, int successCount) {
            AzureModel.RecordStats(type, fileName, this.Warnings, this.Plant, successCount, this.FailedRecords, null);
            SuncorProductionFile.LogSuccess(fileName, this, successCount, FailedRecords);
        }

        public delegate void DelegateLogWriter(string plant, string output);
        private static DelegateLogWriter LogWriter = LocalLogWriter;

        public static void LocalLogWriter(string plant, string msg) {
            File.AppendAllText(LogFileName, CRLF + msg);
        }

        public static void SetLogFileWriter(DelegateLogWriter func) {
            LogWriter = func;
        }

        public static void Log(string plant, Exception ex) {
            string error = ex.Message + (ex.InnerException != null ? ex.InnerException.Message : "");
            string msg = DateTime.Now.ToUniversalTime() + ":ERROR " + error;
            LogWriter(plant, msg);
        }

        public static void Log(string plant, string warning) {
            string msg = DateTime.Now.ToUniversalTime() + ":WARNING " + warning;
            LogWriter(plant, msg);
        }

        public static void LogSuccess(string fileName, SuncorProductionFile pf, int successCount, int failedCount) {
            string info = "File " + fileName + " successfully loaded " + successCount + " records loaded with " + failedCount + " records not loaded";
            string msg = DateTime.Now.ToUniversalTime() + ":" + info;
            LogWriter(pf.Plant, msg);
        }
    }

    public enum MessageType {
        Info,
        Error
    }

    public class WarningMessage {
        public WarningMessage(MessageType type, string atag, string aMessage) {
            Tag = atag;
            Message = aMessage;
            Type = type;
        }

        public WarningMessage(MessageType type, string aMessage) {
            Message = aMessage;
        }
        public override string ToString() {
            return Message.ToString();
        }
        public MessageType Type;
        public string Tag;
        public string Message;
    }
}
