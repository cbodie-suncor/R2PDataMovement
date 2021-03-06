﻿using Newtonsoft.Json;
using R2PTransformation.src.db;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;

namespace R2PTransformation.src {
    public abstract class SuncorProductionFile {
        public Guid BatchId;
        public string FileName;
        public string Plant;
        public List<WarningMessage> Warnings = new List<WarningMessage>();
        public List<TagBalance> Products { get; set; }


        public SuncorProductionFile(string fileName) {
            BatchId = Guid.NewGuid();
            FileName = fileName;
            FailedRecords = new List<TagBalance>();
            Products = new List<TagBalance>();
        }

        public virtual List<TagBalance> GetTagBalanceRecords() {
            return Products;
        }

        public List<TagBalance> FailedRecords;
        public List<TagBalance> SavedRecords;

        public void IsCurrentDay(DateTime currentDay) {
            if (currentDay != DateTime.Today) {
                Warnings.Add(new WarningMessage(null, "Using " + currentDay.ToString("yyyy/MM/dd") + " as a override date"));
            }
        }

        public string ExportR2PJson() {
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
            var batch = new { CreatedBy = "R2P", Created = DateTime.Now, BatchId = this.BatchId, TagBalance = records.Where(t => t.Quantity != "") };
            return JsonConvert.SerializeObject(batch);
        }

        public void AddTagBalance(DateTime currentDay, string system, string productCode, DateTime day, decimal quantity) {
            TagBalance tb = new TagBalance();
            tb.MovementType = "Production";
            tb.System = system;
            tb.Tag = productCode;
            tb.Plant = this.Plant;
            tb.Created = DateTime.Now;
            tb.BalanceDate = day;
            tb.QuantityTimestamp = DateTime.Now;
            tb.CreatedBy = "STransform";
            TagMap tm = AzureModel.LookupTag(tb.Tag, tb.Plant);
            if (tm == null) {
                SuncorProductionFile.Log(this.Plant, "no TagMapping found for " + tb.BalanceDate + "," + tb.Plant + "," + tb.Tag);
                Warnings.Add(new WarningMessage(tb.Tag, "No TagMapping"));
                this.FailedRecords.Add(tb);
                return;
            }

            tb.StandardUnit = tm.DefaultUnit;
            tb.Plant = tm.Plant;
            tb.ValType = tm.DefaultValuationType;
            tb.WorkCenter = tm.WorkCenter;
            tb.Material = tm.MaterialNumber;
            tb.Quantity = Math.Round(quantity, 3);
            tb.BatchId = this.BatchId.ToString();

            if (!IsDayValid(day, currentDay)) {
                this.Warnings.Add(new WarningMessage(tb.Tag, "Invalid Date " + day.ToString("yyyy/MM/dd")));
                this.FailedRecords.Add(tb);
            } else {
                this.Products.Add(tb);
            }
            return;
        }

        private static string LogFileName = "AzureDataHubProductionLoad.log";
        private static string CRLF = "\r\n";

        public void SaveRecords() {
            List<TagBalance> tb = this.GetTagBalanceRecords();
            AzureModel.SaveTagBalance(FileName, this, tb);
        }

        public static decimal ParseDecimal(object v) {
            try {
                return string.IsNullOrEmpty(v.ToString()) ? 0 : decimal.Parse(v.ToString());
            } catch (Exception ex) {
                throw ex;
            }
        }
        public static bool IsDayValid(DateTime day, DateTime currentDay) {
            if (day.Date > currentDay.Date) return false;
            if (currentDay.Day <= 10) {
                DateTime firstOfPriorMonth = new DateTime(currentDay.AddMonths(-1).Year, currentDay.AddMonths(-1).Month, 1);
                return firstOfPriorMonth <= day; // accept dates in current and prior month
            } else {
                return day.Month == currentDay.Month && day.Year == currentDay.Year; // only accept dates in month
            }
        }

        public void RecordSuccess(string fileName) {
            AzureModel.RecordStats(this, fileName, Warnings);
            SuncorProductionFile.LogSuccess(fileName, this, SavedRecords.Count, FailedRecords.Count);
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

    public class WarningMessage {
        public WarningMessage(string atag, string aMessage) {
            Tag = atag;
            Message = aMessage;
        }

        public WarningMessage(string aMessage) {
            Message = aMessage;
        }
        public string Tag;
        public string Message;
    }
}
