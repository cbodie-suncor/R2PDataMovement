using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using Microsoft.EntityFrameworkCore;
using SuncorR2P;

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
                    TagBalance found = context.TagBalances.Find(new object[] { item.Tag, item.BalanceDate, item.ValType });
                    if (found == null)
                        batch.TagBalance.Add(item);
                    else
                        UpdateTagBalance(found, item);
                }
                context.SaveChanges();
                pf.SavedRecords = tb;
            }
        }

        internal static void AddMaterialMovements(List<MaterialMovement> mm) {
            using (DBContextWithConnectionString context = new DBContextWithConnectionString()) {
                mm.ForEach(t => {
                    List<MaterialMovement> find = context.MaterialMovements.Where(f => f.MaterialDocument == t.MaterialDocument).ToList();
                    if (find.Count() > 0) find.ForEach(t=> context.MaterialMovements.Remove(t));
                });

                context.AddRange(mm);
                context.SaveChanges();
            }
        }

        private static void UpdateTagBalance(TagBalance existing, TagBalance tb) {
            existing.Quantity = tb.Quantity;
            existing.OpeningInventory = tb.OpeningInventory;
            existing.ClosingInventory = tb.ClosingInventory;
            existing.Shipment = tb.Shipment;
            existing.Receipt = tb.Receipt;
            existing.Consumption = tb.Consumption;
            existing.Confidence = tb.Confidence;
            existing.MovementType = tb.MovementType;
            existing.Material = tb.Material;
            existing.ValType = tb.ValType;
            existing.Tank = tb.Tank;

            existing.Material = tb.Material;
            existing.StandardUnit = tb.StandardUnit;
            existing.WorkCenter = tb.WorkCenter;
        }

        internal static TagMap ReverseLookupTag(int material, string plant) {
            TagMap tm = null;
            using (DBContextWithConnectionString context = new DBContextWithConnectionString()) {
                if (context.DoesConnectionStringExist) {
                    tm = context.TagMaps.SingleOrDefault(t => t.MaterialNumber == material.ToString() && t.Plant == plant);
                    return tm;
                } else {
                    // probably for Unit Testing, so use 
                    return new TagMap() { Tag = "EP Sweet Crude Trucks", DefaultUnit = "abc", MaterialNumber = "abc", WorkCenter = "123", Plant = plant, DefaultValuationType = "asd" };
                }
            }
        }

        internal static TagMap LookupTag(string tag, string plant) {
            TagMap tm = null;
            using (DBContextWithConnectionString context = new DBContextWithConnectionString()) {
                if (context.DoesConnectionStringExist) {
                    if (plant == "COMMERCECITY") {
                        tm = context.TagMaps.SingleOrDefault(t=>t.Tag == tag && (t.Plant == "GP01" || t.Plant == "GP02"));
                    } else 
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

        public static string GetCurrentConversionsCSV() {
            List<Conversion> cons = null;
            using (DBContextWithConnectionString context = new DBContextWithConnectionString()) {
                cons = context.Conversions.ToList();
            }
            string converionContents = "Material,StandardUnit,ToUnit,Factor\r\n";
            List<string> line = cons.Select(t => (t.Material == null ? "" : t.Material.Trim()) + "," + t.StandardUnit.Trim() + "," + t.ToUnit.Trim() + "," + t.Factor.Value.ToString().Trim()).ToList();
            converionContents += string.Join("\r\n", line);
            return converionContents;
        }

        public static string GetCurrentTagMapsCSV(string plant) {
            List<TagMap> tags = null;
            using (DBContextWithConnectionString context = new DBContextWithConnectionString()) {
                tags = context.TagMaps.Where(t => t.Plant == plant).ToList();
            }
            string tagContents = "Tag,Plant,WorkCenter,MaterialNumber,DefaultValuationType,DefaultUnit\r\n";
            List<string> line = tags.Select(t => t.Tag.Trim() + "," + t.Plant.Trim() + "," + t.WorkCenter.Trim() + "," + t.MaterialNumber.Trim() + "," + t.DefaultValuationType.Trim() + "," + t.DefaultUnit.Trim()).ToList();
            tagContents += string.Join("\r\n", line);
            return tagContents;
        }

        public static List<TransactionEvent> GetTransactions() {
            using (DBContextWithConnectionString context = new DBContextWithConnectionString()) {
                return context.TransactionEvents.ToList();
            }
        }

        /*
        public static void RecordMaterialMovement(string plant, List<WarningMessage> warnings, int success, int fail, string body) {
            using (DBContextWithConnectionString context = new DBContextWithConnectionString()) {
                TransactionEvent te = new TransactionEvent() { Type = "Material Movement", Plant = plant, Extra = body, CreateDate = DateTime.Now, SuccessfulRecordCount = success, FailedRecordCount = fail };

                foreach (var item in warnings.Select(y => new { Tag = y.Tag, Message = y.Message }).Distinct()) {
                    te.TransactionEventDetail.Add(new TransactionEventDetail() { Tag = item.Tag, ErrorMessage = item.Message });
                }
                List<WarningMessage> noMappings = warnings.Where(t => t.Message == "No TagMapping").ToList();
                List<WarningMessage> otherErrors = warnings.Where(t => t.Message != "No TagMapping").ToList();
                te.ErrorMessage = "";
                if (otherErrors.Count > 0) te.ErrorMessage = String.Join(",", otherErrors.Select(y => y.Message).Distinct().ToArray());
                if (noMappings.Count > 0) te.ErrorMessage += (te.ErrorMessage.Length > 0 ? " and " : "") + noMappings.Count + " records with no tag mappings";
                if (te.ErrorMessage == "") te.ErrorMessage = "Load completed successfully";
                context.TransactionEvents.Add(te);
                context.SaveChanges();
            }
        }
        */

        public static void RecordStats(string type, string filename, List<WarningMessage> warnings, string plant, int success, int fail, string json) {
            if (json != null && json.Length > 5990) json = json.Substring(0, 5990);
            using (DBContextWithConnectionString context = new DBContextWithConnectionString()) {
                TransactionEvent te = new TransactionEvent() { Type = type, CreateDate = DateTime.Now, Plant = plant, Filename = filename, SuccessfulRecordCount = success, FailedRecordCount = fail, Extra = json };
                te.Message = "";

                if (warnings != null) {
                    if (success == 0) te.Message = "File rejected due to no successfuly records";

                    foreach (var item in warnings.Select(y => new { Type = y.Type.ToString(), Tag = y.Tag, Message = y.Message }).Distinct()) {
                        te.TransactionEventDetail.Add(new TransactionEventDetail() { Type = item.Type, Tag = item.Tag, Message = item.Message });
                    }

                    List<WarningMessage> noMappings = warnings.Where(t => t.Message == "No TagMapping").ToList();
                    List<WarningMessage> otherErrors = warnings.Where(t => t.Message != "No TagMapping").ToList();
                    if (otherErrors.Count > 0) te.Message = String.Join(",", otherErrors.Select(y => y.Message).Distinct().ToArray());
                    if (noMappings.Count > 0) te.Message += (te.Message.Length > 0 ? " and " : "") + noMappings.Count + " records with no tag mappings";
                }
                if (type == "Load TagMaps" || type == "Load Conversions") te.Message = "Load completed successfully";
                if (te.Message == "") te.Message = "Load completed successfully"; 
                context.TransactionEvents.Add(te);
                context.SaveChanges();
            }
        }

        public static void RecordStats(string type, int successfulRecords, string json) {
            if (json.Length > 5990) json = json.Substring(0, 5990);
            using (DBContextWithConnectionString context = new DBContextWithConnectionString()) {
                TransactionEvent te = new TransactionEvent() { Type = type, CreateDate = DateTime.Now, Plant = null, Filename = null, SuccessfulRecordCount = successfulRecords, FailedRecordCount = 0, Extra = json };
                te.Message = "File completed successfully";
                context.TransactionEvents.Add(te);
                context.SaveChanges();
            }
        }

        public static void RecordFileFailure(string type, String plant, string fileName, int successfulRecordCount, int failedRecordCount, Exception ex) {
            using (DBContextWithConnectionString context = new DBContextWithConnectionString()) {
                TransactionEvent te = new TransactionEvent() { Type = type, CreateDate = DateTime.Now, Plant = plant, Filename = fileName, SuccessfulRecordCount = 0, FailedRecordCount = failedRecordCount, Message = (ex.InnerException != null ? ex.Message + ":" + ex.InnerException.Message : ex.Message) };
                if (ex is OriginalFileLockException) {
                    // if the last message is an File Lock, do not log
                    List<TransactionEvent> lastItems = context.TransactionEvents.Where(t => t.Type == type && t.Plant == plant && t.Filename == fileName).OrderByDescending(r => r.CreateDate).ToList();
                    if (lastItems.Count() > 0 && lastItems[0].Message.Contains("has a file lock") && (DateTime.Now - lastItems[0].CreateDate.Value).TotalHours < 12) return;
                }

                context.TransactionEvents.Add(te);
                context.SaveChanges();
            }
        }

        public static void RecordFatalLoad(string type, string plant, Exception ex, string extra) {
            using (DBContextWithConnectionString context = new DBContextWithConnectionString()) {
                if (extra != null && extra.Length > 5990) extra = extra.Substring(0, 5990);
                TransactionEvent te = new TransactionEvent() { Type = type, Plant = plant, CreateDate = DateTime.Now, Message = ex.Message + " " + (ex.InnerException == null ? "" : ex.InnerException.Message), Extra = extra };
                if (ex is OriginalFileLockException) {
                    // if the last message is an File Lock, do not log
                    List<TransactionEvent> lastItems = context.TransactionEvents.Where(t => t.Type == type).OrderByDescending(r => r.CreateDate).ToList();
                    if (lastItems.Count() > 0 && lastItems[0].Message.Contains("has a file lock") && (DateTime.Now - lastItems[0].CreateDate.Value).TotalHours < 12) return;
                } 
                context.TransactionEvents.Add(te);
                context.SaveChanges();
            }
        }

        public static List<WarningMessage> UpdateConversions(DataTable dt) {
            List<WarningMessage> msgs = new List<WarningMessage>();
            List<Conversion> existing = null;
            List<Conversion> toAdd = new List<Conversion>();
            List<Conversion> toChange = new List<Conversion>();
            using (DBContextWithConnectionString context = new DBContextWithConnectionString()) {
                existing = context.Conversions.ToList();
            }
            foreach (DataRow r in dt.AsEnumerable()) {
                Conversion current = ConversionFromRow(r);
                Conversion found = existing.SingleOrDefault(t => t.Equals(current));
                if (found == null) {
                    toAdd.Add(current);
                    msgs.Add(new WarningMessage(MessageType.Info, "adding " + current.ToString()));
                } else {
                    existing.Remove(found);
                    if (UpdateConversionValues(found, current)) {
                        toChange.Add(current);
                        msgs.Add(new WarningMessage(MessageType.Info, "updated " + current.ToString()));
                    }
                }
            }
            existing.ForEach(t => { msgs.Add(new WarningMessage(MessageType.Info, "deleting " + t.ToString())); });

            using (DBContextWithConnectionString context = new DBContextWithConnectionString()) {
                context.Conversions.RemoveRange(existing);
                context.Conversions.AddRange(toAdd);
                toChange.ForEach(chg => { UpdateConversionValues(context.Conversions.Single(t => t.Equals(chg)), chg); });
                context.SaveChanges();
            }
            return msgs;
        }

        public static List<WarningMessage> UpdateTagMappings(string plant, DataTable dt) {
            List<WarningMessage> msgs = new List<WarningMessage>();
            List<TagMap> existingTM = null;
            List<TagMap> toAdd = new List<TagMap>();
            List<TagMap> toChange = new List<TagMap>();
            using (DBContextWithConnectionString context = new DBContextWithConnectionString()) {
                existingTM = context.TagMaps.Where(t=>t.Plant == plant).ToList();
            }
            foreach (DataRow r in dt.AsEnumerable()) {
                TagMap current = TagMapFromRow(r);
                if (current.Plant != plant) continue;  // ignore other plant tags 
                TagMap found = existingTM.SingleOrDefault(t => t.Plant == current.Plant && t.Tag == current.Tag);
                if (found == null) {
                    toAdd.Add(current);
                    msgs.Add(new WarningMessage(MessageType.Info, "adding " + current.Tag));
                } else {
                    existingTM.Remove(found);
                    if (UpdateTagMapValues(found, current)) {
                        toChange.Add(current);
                        msgs.Add(new WarningMessage(MessageType.Info, "updated " + current.Tag));
                    }
                }
            }
            existingTM.ForEach(t => { msgs.Add(new WarningMessage(MessageType.Info, "deleting " + t.Tag)); });

            using (DBContextWithConnectionString context = new DBContextWithConnectionString()) {
                context.TagMaps.RemoveRange(existingTM);
                context.TagMaps.AddRange(toAdd);
                toChange.ForEach(chg => { UpdateTagMapValues(context.TagMaps.Single(t => t.Plant == chg.Plant && t.Tag == chg.Tag), chg); });
                context.SaveChanges();
            }
            return msgs;
        }

        private static Boolean UpdateTagMapValues(TagMap found, TagMap current) {
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


        private static Boolean UpdateConversionValues(Conversion found, Conversion current) {
            Boolean changed = false;
            if (found.Factor != current.Factor) { changed = true; found.Factor = current.Factor; }
            return changed;
        }

        private static Conversion ConversionFromRow(DataRow r) {
            Conversion tm = new Conversion();
            tm.Material = r["Material"].ToString();
            tm.StandardUnit = r["StandardUnit"].ToString();
            tm.ToUnit = r["ToUnit"].ToString();
            tm.Factor = SuncorProductionFile.ParseDecimal(r["Factor"].ToString(), "Factor");
            return tm;
        }

        /*
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
                return context.Sigmafinexes.Where(i => i.FlowCc == "East_Plt").ToList();
            }
        }
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
