using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Linq;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using R2PTransformation.src;
using SuncorR2P;
using static R2PTransformation.src.SimplePersistentController;

namespace R2PTransformation.Models {
    public class AzureModel {
        // The DBContext is created by EF, run the following command to rebuild
        // 
        // run from the Package Manager Console, cd C:\suncor\R2PDataMovement\R2PTransformation 
        // dotnet ef dbcontext scaffold "Data Source=inmdevarmsvruw2001.database.windows.net;Initial Catalog=inmdevarmsqluw2001;User ID=suncorsqladmin;password=AdvancedAnalytics2020" Microsoft.EntityFrameworkCore.SqlServer -o Models -c "AzureContext" --no-build --force

        public static List<TagBalance> GetAllTagBalances() {
            using (DBContextWithConnectionString context = DBContextWithConnectionString.Create()) {
                var items = context.TagBalance.ToList();
                return items;
            }
        }

        public static List<TagMap> GetAllInvTagMappings(string plant) {
            using (DBContextWithConnectionString context = DBContextWithConnectionString.Create()) {
                List<TagMap> mappings = context.TagMap.Where(t=>t.Type == "Inv" && t.Plant == plant).ToList();
                return mappings;
            }
        }

        public static void SaveInventory(string fileName, SuncorProductionFile pf) {
            using (DBContextWithConnectionString context = DBContextWithConnectionString.Create()) {
                Batch batch = new Batch();
                batch.Id = pf.BatchId.ToString();
                batch.Created = DateTime.Now;
                batch.CreatedBy = "System";
                batch.Filename = fileName;
                context.Batch.Add(batch);
                foreach (var item in pf.Inventory) {
                    InventorySnapshot found = context.InventorySnapshot.SingleOrDefault(t => t.Tag == item.Tag && t.QuantityTimestamp == item.QuantityTimestamp && t.ValType == item.ValType && t.Tank == item.Tank);
                    if (found == null)
                        batch.InventorySnapshot.Add(item);
                    else
                        UpdateInventory(found, item);
                }
                context.SaveChanges();
                pf.SavedInventoryRecords = pf.Inventory;
            }
        }

        internal static void AddS4Inventory(S4InventoryBatch s4Inv) {
            using (DBContextWithConnectionString context = DBContextWithConnectionString.Create()) {
                Batch batch = null;
                Batch foundBatch = context.Batch.Find(new object[] { s4Inv.BatchId.ToString() });
                if (foundBatch != null) batch = foundBatch;
                else {
                    batch = new Batch();
                    batch.Id = s4Inv.BatchId;
                    batch.Created = DateTime.Now;
                    batch.CreatedBy = "System";
                }

                var existingInvs = context.S4inventory;
                s4Inv.Inventory.ForEach(t => {
                    List<S4inventory> find = context.S4inventory.Where(f => f.PostingDate == t.PostingDate && f.Plant == t.Plant && f.Material == t.Material && f.ValuationType == t.ValuationType).ToList();

                    if (find.Count() > 0) {
                        find.ForEach(t => context.S4inventory.Remove(t));
                    } else {
                        context.S4inventory.Add(t);
                    }
                    t.Batch = batch;
                });

                context.S4inventory.AddRange(s4Inv.Inventory);
                context.SaveChanges();
            }
        }

        public static void SaveCustodyTickets(CustodyTicketBatch pf) {
            using (DBContextWithConnectionString context = DBContextWithConnectionString.Create()) {
                Batch batch = null;
                Batch foundBatch = context.Batch.Find(new object[] { pf.BatchId.ToString() });
                if (foundBatch != null) batch = foundBatch;
                else {
                    batch = new Batch();
                    batch.Id = pf.BatchId.ToString();
                    batch.Created = DateTime.Now;
                    batch.CreatedBy = "System";
                    context.Batch.Add(batch);
                }
                foreach (var item in pf.Tickets) {
                    CustodyTicket found = context.CustodyTicket.SingleOrDefault(t => t.S4MaterialDocument == item.S4MaterialDocument);
                    if (found == null)
                        batch.CustodyTicket.Add(item);
                    else
                        UpdateCustodyTicket(found, item);
                }
                context.SaveChanges();
            }
        }

        private static void UpdateCustodyTicket(CustodyTicket existing, CustodyTicket ct) {
            existing.MovementTypeDescription = ct.MovementTypeDescription;
            existing.Sign = ct.Sign;
            existing.NetQuantitySizeInUoe = ct.NetQuantitySizeInUoe;
            existing.NetQuantitySizeInBuoe = ct.NetQuantitySizeInBuoe;
            existing.Mass = ct.Mass;
            existing.BaseUnitOfMeasure = ct.BaseUnitOfMeasure;
            existing.BaseUnitOfEntry = ct.BaseUnitOfEntry;
            existing.ValuationType = ct.ValuationType;
            existing.Density = ct.Density;
            existing.DensityUom = ct.DensityUom;
            existing.Origin = ct.Origin;
            existing.Destination = ct.Destination;
            existing.Plant = ct.Plant;
            existing.Temperature = ct.Temperature;
            existing.TemperatureUnitOfMeasure = ct.TemperatureUnitOfMeasure;
            existing.MovementType = ct.MovementType;
            existing.Mode = ct.Mode;
            existing.Tender = ct.Tender;
            existing.VehicleText = ct.VehicleText;
            existing.VehicleNumber = ct.VehicleNumber;
            existing.LoadStartDateTime = ct.LoadStartDateTime;
            existing.LoadEndDateTime = ct.LoadEndDateTime;
            existing.EnteredOnDateTime = ct.EnteredOnDateTime;
            existing.EnteredBy = ct.EnteredBy;
            existing.DocumentDateTime = ct.DocumentDateTime;
            existing.PostingDateTime = ct.PostingDateTime;
        }

        public static void UpdateTagBalance(List<TagBalance> tb) {
            using (DBContextWithConnectionString context = DBContextWithConnectionString.Create()) {
                foreach (var item in tb) {
                    TagBalance found = context.TagBalance.Find(new object[] { item.Tag, item.BalanceDate, item.ValType });
                    if (found == null)
                        throw new Exception("Unexcepted new record for " + item.Tag + " " + item.BalanceDate + " " + item.ValType);
                    else
                        UpdateTagBalance(found, item);
                }
                context.SaveChanges();
            }
        }

        public static void SaveTagBalance(string fileName, SuncorProductionFile pf, List<TagBalance> tb) {
            using (DBContextWithConnectionString context = DBContextWithConnectionString.Create()) {
                Batch batch = new Batch();
                batch.Id = pf.BatchId.ToString();
                batch.Created = DateTime.Now;
                batch.CreatedBy = "System";
                batch.Filename = fileName;
                context.Batch.Add(batch);
                foreach (var item in tb) {
                    TagBalance found = context.TagBalance.Find(new object[] { item.Tag, item.BalanceDate, item.ValType });
                    if (found == null)
                        batch.TagBalance.Add(item);
                    else
                        UpdateTagBalance(found, item);
                }
                context.SaveChanges();
                pf.SavedRecords = tb;
            }
        }

        public static List<StandardUnit> GetUnits() {
            using (DBContextWithConnectionString context = DBContextWithConnectionString.Create()) {
                return context.StandardUnit.ToList();
            }
        }

        internal static void AddMaterialMovements(List<MaterialMovement> mm) {
            using (DBContextWithConnectionString context = DBContextWithConnectionString.Create()) {
                mm.ForEach(t => {
                    List<MaterialMovement> find = context.MaterialMovement.Where(f => f.MaterialDocument == t.MaterialDocument).ToList();

                    if (find.Count() > 0) find.ForEach(t => context.MaterialMovement.Remove(t));
                });

                context.AddRange(mm);
                context.SaveChanges();
            }
        }

        internal static void AddProductHierarchy(List<ProductHierarchy> mm) {
            using (DBContextWithConnectionString context = DBContextWithConnectionString.Create()) {
                context.ProductHierarchy.RemoveRange(context.ProductHierarchy);
                context.ProductHierarchy.AddRange(mm);
                context.SaveChanges();
            }
        }

        internal static void AddMaterialLedger(List<MaterialLedger> mm) {
            using (DBContextWithConnectionString context = DBContextWithConnectionString.Create()) {
                context.MaterialLedger.RemoveRange(context.MaterialLedger);
                context.MaterialLedger.AddRange(mm);
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
            existing.MovementType = tb.MovementType;
            existing.Material = tb.Material;
            if (existing.ValType != tb.ValType) {
                throw new Exception("Valuation types different : " + existing.ValType + " " + tb.ValType + " " + existing.BalanceDate.ToString() + " " + existing.Tag);
            }
            existing.Material = tb.Material;
            existing.StandardUnit = tb.StandardUnit;
            existing.WorkCenter = tb.WorkCenter;

            existing.LastUpdated = DateTime.Now;
        }

        private static void UpdateInventory(InventorySnapshot existing, InventorySnapshot inv) {
            existing.Quantity = inv.Quantity;
            existing.Confidence = inv.Confidence;
            existing.MovementType = inv.MovementType;
            existing.Material = inv.Material;
            existing.ValType = inv.ValType;
            existing.Tank = inv.Tank;
            existing.Material = inv.Material;
            existing.StandardUnit = inv.StandardUnit;
            existing.WorkCenter = inv.WorkCenter;

            existing.LastUpdated = DateTime.Now;
        }

        internal static TagMap ReverseLookupForTag(string material, string plant, string valType, string type) {
            TagMap tm = null;
            using (DBContextWithConnectionString context = DBContextWithConnectionString.Create()) {
                tm = context.TagMap.SingleOrDefault(t => t.MaterialNumber == material && t.Plant == plant && t.DefaultValuationType == valType && t.Type == type);
                return tm;
            }
            return tm;
        }

        internal static TagMap LookupTag(string tag, string plant, string type) {
            TagMap tm = null;
            using (DBContextWithConnectionString context = DBContextWithConnectionString.Create()) {
                    if (plant == "COMMERCECITY") {
                        tm = context.TagMap.SingleOrDefault(t => t.Tag == tag && (t.Plant == "GP01" || t.Plant == "GP02") && t.Type == type);
                    } else {
                        tm = context.TagMap.SingleOrDefault(t => t.Tag == tag && t.Plant == plant && t.Type == type);
                    }
                    return tm;
                /*
                if (tm == null) {
                    tm = new TagMap();
                    tm.Tag = tag;
                    tm.Plant = plant;
                    tm.DefaultValuationType = "SUNCOR";
                    tm.DefaultUnit = "BBL";
                    tm.MaterialNumber = "999";
                    tm.WorkCenter = "123";
                    tm.Type = type;
                    context.TagMap.Add(tm);
                    context.SaveChanges();
                }*/
                
            }
            return tm;

        }

        internal static decimal ConvertQuantityToStandardUnit(string fromUom, string toUom, string material,  decimal quantity) {
            // if alread a StandarUnit, then no need to convert
            using (DBContextWithConnectionString context = DBContextWithConnectionString.Create()) {
                if (!context.DoesConnectionStringExist) {
                    // probably for Unit Testing, so use
                    return quantity;
                }
                if (fromUom == toUom) return quantity;
                
                var found = context.StandardUnit.Find(fromUom); if (found == null) throw new Exception("cannot find UOM for " + fromUom);
                    found = context.StandardUnit.Find(toUom); if (found == null) throw new Exception("cannot find UOM for " + toUom);

                var foundConversion = context.Conversion.SingleOrDefault(c=>c.StandardUnit == fromUom && c.ToUnit == toUom && c.Material == material);
                if (foundConversion == null) throw new Exception("cannot find UOM conversion for " + fromUom + "," + toUom + "," + material);
                quantity = quantity * foundConversion.Factor.Value;
            }
            return quantity;
        }

        public static string GetCurrentConversionsCSV() {
            List<Conversion> cons = null;
            using (DBContextWithConnectionString context = DBContextWithConnectionString.Create()) {
                cons = context.Conversion.ToList();
            }
            string converionContents = "Material,StandardUnit,ToUnit,Factor\r\n";
            List<string> line = cons.Where(y=>y.StandardUnit != y.ToUnit).Select(t => (t.Material == null ? "" : t.Material.Trim()) + "," + t.StandardUnit.Trim() + "," + t.ToUnit.Trim() + "," + t.Factor.Value.ToString().Trim()).ToList();
            converionContents += string.Join("\r\n", line);
            return converionContents;
        }

        public static string GetCurrentTagMapsCSV(string plant, string type) {
            List<TagMap> tags = null;
            using (DBContextWithConnectionString context = DBContextWithConnectionString.Create()) {
                tags = context.TagMap.Where(t => t.Plant == plant && t.Type == type).ToList();
            }
            string tagContents = "Tag,Plant,WorkCenter,MaterialNumber,DefaultValuationType,DefaultUnit\r\n";
            List<string> line = tags.Select(t => t.Tag.Trim() + "," + t.Plant.Trim() + "," + t.WorkCenter.Trim() + "," + t.MaterialNumber.Trim() + "," + t.DefaultValuationType.Trim() + "," + t.DefaultUnit.Trim()).ToList();
            tagContents += string.Join("\r\n", line);
            return tagContents;
        }

        public static List<TransactionEvent> GetTransactions() {
            using (DBContextWithConnectionString context = DBContextWithConnectionString.Create()) {
                return context.TransactionEvent.ToList();
            }
        }

        /*
        public static void RecordMaterialMovement(string plant, List<WarningMessage> warnings, int success, int fail, string body) {
            using (DBContextWithConnectionString context = DBContextWithConnectionString.Create()) {
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
            using (DBContextWithConnectionString context = DBContextWithConnectionString.Create()) {
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
                context.TransactionEvent.Add(te);
                context.SaveChanges();
            }
        }

        public static void RecordStats(string type, int successfulRecords, int failedRecords, string json) {
            if (json.Length > 5990) json = json.Substring(0, 5990);
            using (DBContextWithConnectionString context = DBContextWithConnectionString.Create()) {
                TransactionEvent te = new TransactionEvent() { Type = type, CreateDate = DateTime.Now, Plant = null, Filename = null, SuccessfulRecordCount = successfulRecords, FailedRecordCount = failedRecords, Extra = json };
                te.Message = "File completed successfully";
                context.TransactionEvent.Add(te);
                context.SaveChanges();
            }
        }

        public static Boolean RecordFileFailure(string type, String plant, string fileName, int successfulRecordCount, int failedRecordCount, Exception ex) {
            using (DBContextWithConnectionString context = DBContextWithConnectionString.Create()) {
                TransactionEvent te = new TransactionEvent() { Type = type, CreateDate = DateTime.Now, Plant = plant, Filename = fileName, SuccessfulRecordCount = 0, FailedRecordCount = failedRecordCount, Message = (ex.InnerException != null ? ex.Message + ":" + ex.InnerException.Message : ex.Message) };
                if (ex is OriginalFileLockException) {
                    // if the last message is an File Lock, do not log
                    List<TransactionEvent> lastItems = context.TransactionEvent.Where(t => t.Type == type && t.Plant == plant && t.Filename == fileName).OrderByDescending(r => r.CreateDate).ToList();
                    if (lastItems.Count() > 0 && lastItems[0].Message.Contains("has a file lock") && (DateTime.Now - lastItems[0].CreateDate.Value).TotalHours < 12) return false;
                }

                if (ex.Message.Contains("ULSD")) {
                    // if the last message is an File Lock, do not log
                    List<TransactionEvent> lastItems = context.TransactionEvent.Where(t => t.Type == type && t.Plant == plant && t.Filename == fileName && t.Message.Contains("no ULSD file found for the month")).OrderByDescending(r => r.CreateDate).ToList();
                    if (lastItems.Count() > 0 && lastItems[0].Message.Contains("no ULSD file found for the month") && (DateTime.Now - lastItems[0].CreateDate.Value).TotalHours < 12) return false;

                    lastItems = context.TransactionEvent.Where(t => t.Type == type && t.Plant == plant && t.Filename == fileName && t.Message.Contains("No matching ULSD record")).OrderByDescending(r => r.CreateDate).ToList();
                    if (lastItems.Count() > 0 && lastItems[0].Message.Contains("No matching ULSD record") && (DateTime.Now - lastItems[0].CreateDate.Value).TotalHours < 12) return false;
                }

                context.TransactionEvent.Add(te);
                context.SaveChanges();
            }
            return true;
        }

        public static void RecordFatalLoad(string type, string plant, Exception ex, string extra) {
            using (DBContextWithConnectionString context = DBContextWithConnectionString.Create()) {
                if (extra != null && extra.Length > 5990) extra = extra.Substring(0, 5990);
                TransactionEvent te = new TransactionEvent() { Type = type, Plant = plant, CreateDate = DateTime.Now, Message = ex.Message + " " + (ex.InnerException == null ? "" : ex.InnerException.Message), Extra = extra };
                if (ex is OriginalFileLockException) {
                    // if the last message is an File Lock, do not log
                    List<TransactionEvent> lastItems = context.TransactionEvent.Where(t => t.Type == type).OrderByDescending(r => r.CreateDate).ToList();
                    if (lastItems.Count() > 0 && lastItems[0].Message.Contains("has a file lock") && (DateTime.Now - lastItems[0].CreateDate.Value).TotalHours < 12) return;
                }
                context.TransactionEvent.Add(te);
                context.SaveChanges();
            }
        }

        public static int UpdateConversions(DataTable dt) {
            List<Conversion> existing = null;
  
            string cs = DBContextWithConnectionString.ConnectionString;
            DataTable dt2 = GetDataTableFromSqlServer(cs, "select * from conversion where 1=0");
            dt2.TableName = "conversion";

            List<Conversion> csv = new List<Conversion>();
            using (DBContextWithConnectionString context = DBContextWithConnectionString.Create()) {
                existing = context.Conversion.ToList();
            }
            foreach (DataRow r in dt.AsEnumerable()) {
                Conversion current = null;
                try {
                    current = ConversionFromRow(r);
                    csv.Add(current);
                    dt2.Rows.Add(current.ToArray());
                } catch (Exception ex) {
                    throw new Exception("Invalid conversion record " + String.Join(',', r.ItemArray) + " " + ex.Message); //.Select(y => y.ToString()).ToArray().Join(","));
                }
            }

            using (DBContextWithConnectionString context = DBContextWithConnectionString.Create()) {
                List<String> existingUnits = context.StandardUnit.Select(u => u.Name).ToList();
                List<String> additionalStandarUnits = csv.Select(t => t.StandardUnit).Distinct().Where(y => !existingUnits.Contains(y)).ToList();
                List<String> additionalToUnits = csv.Select(t => t.ToUnit).Distinct().Where(y => !existingUnits.Contains(y) && !additionalStandarUnits.Contains(y)).ToList();
                context.StandardUnit.AddRange(additionalStandarUnits.Select(n => new StandardUnit() { Name = n }));
                context.StandardUnit.AddRange(additionalToUnits.Select(n => new StandardUnit() { Name = n }));
                context.SaveChanges();
                context.Database.ExecuteSqlCommand("truncate table conversion");
            }

            DBContextWithConnectionString.BulkLoadConversion(cs, dt2);
            return dt2.Rows.Count;
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
            tm.Factor = (decimal)SuncorController.ParseDouble(r, "Factor");
            return tm;
        }

        public static List<WarningMessage> UpdateTagMappings(string plant, DataTable dt, string type) {
            List<WarningMessage> msgs = new List<WarningMessage>();
            List<TagMap> existingTM = null;
            List<TagMap> toAdd = new List<TagMap>();
            List<TagMap> toChange = new List<TagMap>();
            using (DBContextWithConnectionString context = DBContextWithConnectionString.Create()) {
                existingTM = context.TagMap.Where(t => t.Plant == plant).ToList();
            }
            foreach (DataRow r in dt.AsEnumerable()) {
                TagMap current = TagMapFromRow(r, type);
                if (current.Plant != plant) continue;  // ignore other plant tags 
                TagMap found = existingTM.SingleOrDefault(t => t.Plant == current.Plant && t.Tag == current.Tag && current.Type == t.Type);
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

            using (DBContextWithConnectionString context = DBContextWithConnectionString.Create()) {
                context.TagMap.RemoveRange(existingTM);
                context.TagMap.AddRange(toAdd);
                toChange.ForEach(chg => { UpdateTagMapValues(context.TagMap.Single(t => t.Plant == chg.Plant && t.Tag == chg.Tag), chg); });
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

        public static TagMap TagMapFromRow(DataRow r, string type) {
            TagMap tm = new TagMap();
            tm.Tag = r["tag"].ToString();
            tm.Plant = r["Plant"].ToString();
            tm.WorkCenter = r["WorkCenter"].ToString();
            tm.MaterialNumber = r["MaterialNumber"].ToString();
            tm.DefaultValuationType = r["DefaultValuationType"].ToString();
            tm.DefaultUnit = r["DefaultUnit"].ToString();
            tm.Type = type;
            return tm;
        }

        public static DataTable GetDataTableFromSqlServer(String cs, string strSQL) {
            DateTime start = DateTime.Now;
            DbDataAdapter adapter = new SqlDataAdapter(strSQL, cs);
            DataSet ds = new DataSet();
            adapter.SelectCommand.CommandTimeout = 120;
            adapter.Fill(ds);
            return ds.Tables[0];
        }
    }

    public partial class Conversion {
        public override string ToString() {
            return Material + "," + StandardUnit + "," + ToUnit;
        }
        public Object[] ToArray() {
            Object[] newArray = new object[4];
            newArray[0] = Material;
            newArray[1] = StandardUnit;
            newArray[2] = ToUnit;
            newArray[3] = Factor;
            return newArray;
        }
    }
}
