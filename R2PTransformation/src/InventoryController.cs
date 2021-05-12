using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using R2PTransformation.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;

namespace R2PTransformation.src {

    public class InventoryController : SuncorController {

        public static SuncorProductionFile GetInventoryRecordsWithMultiTags(string contents, string plant, string system) {
            contents = contents.Replace("\"", "");
            DataTable dt = Utilities.ConvertCSVTexttoDataTable(contents);
            DateTime currentDay = new DateTime(2021, 04, 25);
            SuncorProductionFile sf = new SuncorProductionFile(plant);
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

            var groups = invs.GroupBy(t => new { t.Site, t.BaseTag, t.Datetime }).Where(grp => grp.Count() == 2).Select(g => new { Key = g.Key, Count = g.Count(), Tank = g.Max(s => s.Tank), Tag = g.Max(s => s.StrValue), Quantity = g.Max(s => s.Value) });
            var missing = invs.GroupBy(t => new { t.Site, t.BaseTag, t.Datetime }).Where(grp => grp.Count() == 1).Select(g => new { Key = g.Key, Alias = g.Max(s=>s.Alias)}) ;
            groups.Where(t => String.IsNullOrEmpty(t.Tag)).ToList().ForEach(r => sf.Warnings.Add(new WarningMessage(MessageType.Error, r.Key.BaseTag, "Volume and Product Tag found, but no Material mapped to Product Tag")));

            groups.Where(t => !String.IsNullOrEmpty(t.Tag)).ToList().ForEach(t => sf.AddInventory(t.Key.Datetime, "Inventory", system, t.Tag, t.Tank, t.Quantity));
            missing.Where(t => t.Alias.ToLower().Contains("volume")).Distinct().ToList().ForEach(r => sf.Warnings.Add(new WarningMessage(MessageType.Error, r.Key.BaseTag, "Volume Tag exists, but no matching Product Tag found")));
            missing.Where(t => t.Alias.ToLower().Contains("product")).Distinct().ToList().ForEach(r => sf.Warnings.Add(new WarningMessage(MessageType.Error, r.Key.BaseTag, "Product Tag exists, but no matching Volume Tag found")));
            sf.FailedRecords = sf.Warnings.Count;
            return sf;
        }

        public static SuncorProductionFile GetInventoryRecordsWithSingleTag(string contents, string plant, string system) {
            contents = contents.Replace("\"", "");
            DataTable dt = Utilities.ConvertCSVTexttoDataTable(contents);
            SuncorProductionFile sf = new SuncorProductionFile(plant);
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

            invs.ToList().ForEach(t => sf.AddInventory(t.Datetime, "Inventory", system, t.Tag, t.Tank, t.Value));
            sf.FailedRecords = sf.Warnings.Count;
            return sf;
        }

        public static void ProcessInventoryFile(BlobFile file, string plant, string system, TagType tagType) {
            string json = null;
            SuncorProductionFile pf = null;
            if (tagType == TagType.MultipleTagForentry)
                pf = GetInventoryRecordsWithMultiTags(file.Contents, plant, system);
            else
                pf = GetInventoryRecordsWithSingleTag(file.Contents, plant, system);
            AzureModel.SaveInventory(file.FullName, pf);
            if (pf.SavedInventoryRecords.Count > 0) json = pf.ExportInventory();
            pf.RecordSuccess(file.FullName, "Inventory Snapshot", pf.SavedInventoryRecords.Count, json);

            if (pf.SavedInventoryRecords.Count > 0) MulesoftPush.PostInventory(json);
        }
    }
    public enum TagType {
        SingleEntry,
        MultipleTagForentry
    }
}
