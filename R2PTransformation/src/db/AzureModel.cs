using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using Microsoft.EntityFrameworkCore;

namespace R2PTransformation.src.db {
    public class AzureModel {

        public static List<TagBalance> GetAllTagBalances() {
            using (DBContextWithConnectionString context = new DBContextWithConnectionString()) {
                var items = context.TagBalances.ToList();
                return items;
            }
        }

        public static void SaveTagBalance(String file, SuncorProductionFile pf, List<TagBalance> tb) {
            using (DBContextWithConnectionString context = new DBContextWithConnectionString()) {
                Batch batch = new Batch();
                batch.Id = pf.BatchId.ToString();
                batch.Created = DateTime.Now;
                batch.CreatedBy = "System";
                batch.Filename = file;
                context.Batches.Add(batch);
                foreach (var item in tb) {
                    TagBalance found = context.TagBalances.Find(new object[] { item.Tag, item.BalanceDate });
                    if (found == null)
                        batch.TagBalances.Add(item);
                    else
                        UpdateTagBalance(found, item);
                }
                context.SaveChanges();
                pf.SavedRecords = tb;
            }
        }

        private static void UpdateTagBalance(TagBalance existing, TagBalance tb) {
            existing.Quantity = tb.Quantity;
            existing.Material = tb.Material;
            existing.StandardUnit = tb.StandardUnit;
            existing.ValType = tb.ValType;
            existing.WorkCenter = tb.WorkCenter;
            existing.Tank = tb.Tank;
        }

        internal static TagMap LookupTag(string tag, string plant) {
            TagMap tm = null;
            using (DBContextWithConnectionString context = new DBContextWithConnectionString()) {
                if (context.DoesConnectionStringExist) {
                    tm = context.TagMaps.Find(new object[] { tag, plant });
                    return tm ;
                } else {
                    // probably for Unit Testing, so use 
                    return new TagMap() { Tag = "EP Sweet Crude Trucks", DefaultUnit = "abc", MaterialNumber = "abc", WorkCenter = "123", Plant = plant, DefaultValuationType = "asd" };
                }
                /*
                if (tm == null) {
                    tm = new TagMap();
                    tm.Tag = tag;
                    tm.Plant = plant;
                    tm.DefaultValuationType = "SUNCOR";
                    tm.StandardUnit = context.StandardUnits.ToArray()[0];
                    tm.DefaultUnit = context.StandardUnits.ToArray()[0].Name;
                    tm.MaterialNumber = "999";
                    tm.WorkCenter = "123";
                    context.TagMaps.Add(tm);
                    context.SaveChanges();
                }
                */
            }
        }

        internal static decimal ConvertQuantityToStandardUnit(string uom, decimal quantity) {
            // if alread a StandarUnit, then no need to convert
            using (DBContextWithConnectionString context = new DBContextWithConnectionString()) {
                if (!context.DoesConnectionStringExist) {
                    // probably for Unit Testing, so use
                    return quantity;
                }

                var found = context.StandardUnits.Find(uom);
                if (found != null) return quantity;

                // not found, so convert
                var sourceUnitMap = context.SourceUnitMaps.Find(uom);
                if (sourceUnitMap == null) throw new Exception("cannot find UOM mapping for " + uom);
                var foundConversion = context.Conversions.Find(sourceUnitMap.StandardUnit);
                if (foundConversion == null) throw new Exception("cannot find UOM conversion for " + uom); 
                quantity = quantity * foundConversion.Factor.Value;
            }
            return quantity;
        }

        public static void RecordStats(SuncorProductionFile pf, string filename, List<WarningMessage> warnings) {
            using (DBContextWithConnectionString context = new DBContextWithConnectionString()) {
                TransactionEvent te = new TransactionEvent() { Plant = pf.Plant, Filename = pf.FileName, SuccessfulRecordCount = pf.SavedRecords.Count, FailedRecordCount = pf.FailedRecords.Count };

                foreach (var item in warnings) {
                    te.TransactionEventDetails.Add(new TransactionEventDetail() { Tag = item.Tag, ErrorMessage = item.Message });
                }
                context.TransactionEvents.Add(te);
                context.SaveChanges();
            }
        }

        public static void RecordFailure(String plantName, string fileName, int successfulRecordCount, int failedRecordCount, string msg) {
            using (DBContextWithConnectionString context = new DBContextWithConnectionString()) {
                TransactionEvent te = new TransactionEvent() { Plant = plantName, Filename = fileName, SuccessfulRecordCount = successfulRecordCount, FailedRecordCount = failedRecordCount, ErrorMessage = msg };
                context.TransactionEvents.Add(te);
            }
        }

        public static string UpdateTagMappings(string plant, DataTable dt) {
            string output = "";
            List<TagMap> existingTM = null;
            List<TagMap> toAdd = new List<TagMap>();
            List<TagMap> toChange = new List<TagMap>();
            using (DBContextWithConnectionString context = new DBContextWithConnectionString()) {
                existingTM = context.TagMaps.Where(t=>t.Plant == plant).ToList();
            }
            foreach (DataRow r in dt.AsEnumerable()) {
                TagMap current = TagMapFromRow(r);
                if (current.Tag != plant) continue;  // ignore other plant tags 
                TagMap found = existingTM.SingleOrDefault(t => t.Plant == current.Plant && t.Tag == current.Tag);
                if (found == null) {
                    toAdd.Add(current);
                    output += "adding " + current.Plant + "," + current.Tag + "\r\n";
                } else {
                    existingTM.Remove(found);
                    if (UpdateValues(found, current)) {
                        toChange.Add(current);
                        output += "updated " + current.Plant + "," + current.Tag + "\r\n";
                    }
                }
            }
            existingTM.ForEach(t => { output += "deleting " + t.Plant + "," + t.Tag + "\r\n"; });

            using (DBContextWithConnectionString context = new DBContextWithConnectionString()) {
                context.TagMaps.RemoveRange(existingTM);
                context.TagMaps.AddRange(toAdd);
                toChange.ForEach(chg => { UpdateValues(context.TagMaps.Single(t => t.Plant == chg.Plant && t.Tag == chg.Tag), chg); });
                context.SaveChanges();
            }
            return output;
        }

        private static Boolean UpdateValues(TagMap found, TagMap current) {
            Boolean changed = false;
            if (found.WorkCenter != current.WorkCenter) { changed = true; found.WorkCenter = current.WorkCenter; }
            if (found.MaterialNumber != current.MaterialNumber) { changed = true; found.MaterialNumber = current.MaterialNumber; }
            if (found.DefaultValuationType != current.DefaultValuationType) { changed = true; found.DefaultValuationType = current.DefaultValuationType; }
            if (found.DefaultUnit != current.DefaultUnit) { changed = true; found.DefaultUnit = current.DefaultUnit; }
            return changed;
        }

        public static TagMap TagMapFromRow(DataRow r) {
            TagMap tm = new TagMap();
            tm.Tag = r["tag"].ToString();
            tm.Plant = r["Plant"].ToString();
            tm.WorkCenter = r["WorkCenter"].ToString();
            tm.MaterialNumber = r["MaterialNumber"].ToString();
            tm.DefaultValuationType = r["DefaultValuationType"].ToString();
            tm.DefaultUnit = r["DefaultUnit"].ToString();
            return tm;
        }

        public static void PersistSigmafinex(List<Sigmafinex> newItems) {
            using (DBContextWithConnectionString context = new DBContextWithConnectionString()) {
                context.Sigmafinexes.RemoveRange(context.Sigmafinexes);
                context.Sigmafinexes.AddRange(newItems);
                context.SaveChanges();
            }
        }

        public static List<Sigmafinex> TransformToSigmafinex(DataTable dt) {
            List<Sigmafinex> records = new List<Sigmafinex>();
            foreach (var row in dt.AsEnumerable()) {
                records.Add(SigmafineFile.FromDataRow(row));
            }
            return records;
        }

        public static List<Sigmafinex> GetCommerceCity() {
            using (DBContextWithConnectionString context = new DBContextWithConnectionString()) {
                return context.Sigmafinexes.Where(i => i.FlowCc == "East_Plt" /*&& i.StartTime == day && i.Product == "E_FCCGASOLN"*/).ToList();
            }
        }
        /*
        public static List<SigmaTransformedResult> GetCommerceCityWest(List<Sigmafinex> overrideRecords) {
            if (overrideRecords != null) return TransformRow(overrideRecords.Where(i => i.FlowCc == "West_Plt").ToList());
            using (DBContextWithConnectionString context = new DBContextWithConnectionString()) {
                var items = context.Sigmafinexes.Where(i => i.FlowCc == "West_Plt").ToList();
                return TransformRow(items);
            }
        }*/
    }

    public class SigmaTransformedResult {
        public DateTime Day;
        public string Plant;
        public string Product;
        public string ProductDesc;
        public decimal VolOpen;
        public decimal VolClose;
        public decimal VolShip;
        public decimal VolRec;
        public bool IsCharge;

        public SigmaTransformedResult(DateTime day, string plant, string product, string productDesc, decimal volOpen, decimal volClose, decimal volShip, decimal volRec, Boolean isCharge) {
            this.Day = day;
            this.Product = product;
            this.ProductDesc = productDesc;
            this.VolOpen = volOpen;
            this.VolClose = volClose;
            this.VolShip = volShip;
            this.VolRec = volRec;
            this.IsCharge = isCharge;
        }

        public decimal Production {  get { return Math.Round((VolRec - VolShip + VolOpen - VolClose) * (IsCharge ? -1 : 1), 0); } }
    }
}
