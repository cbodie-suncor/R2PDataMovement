using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using R2PTransformation.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;

namespace R2PTransformation.src {
    public class SimplePersistentController : SuncorController {

        public SimplePersistentController() {     }

        public static int PersistInventory(string requestBody) {
            if (string.IsNullOrWhiteSpace(requestBody)) throw new Exception("Json is empty");
            object data = JsonConvert.DeserializeObject(requestBody);

            List<MaterialMovement> mm = new List<MaterialMovement>();
            List<WarningMessage> Warnings = new List<WarningMessage>();
            JObject batch = (JObject)data;
            string batchId = batch["batchId"].ToString();
            int successfulRecords = 0;

            AzureModel.RecordStats("Inventory", successfulRecords, requestBody);
            return mm.Count;
        }

        public static int PersistHierarchy(string requestBody) {
            if (string.IsNullOrWhiteSpace(requestBody)) throw new Exception("Json is empty");
            JObject data = (JObject)JsonConvert.DeserializeObject(requestBody);
            JArray items = (JArray)data["hierarchy"];
            List<ProductHierarchy> mm = new List<ProductHierarchy>();
            foreach (JObject item in items) {
                mm.Add(new ProductHierarchy() {
                    S4material = item["S/4 Material"].ToString(),
                    MaterialDescription = item["Material Description"].ToString(),
                    MaterialGroup = item["Material Group"].ToString(),
                    MaterialGroupText = item["Material Group Text"].ToString(),
                    ProductHierarchyLevel1Code = item["Product Hierarchy Level 1"].ToString(),
                    ProductHierarchyLevel2Code = item["Product Hierarchy Level 2"].ToString(),
                    ProductHierarchyLevel3Code = item["Product Hierarchy Level 3"].ToString(),
                    ProductHierarchyLevel1Text = item["Product Hierarchy Text Level 1"].ToString(),
                    ProductHierarchyLevel2Text = item["Product Hierarchy Text Level 2"].ToString(),
                    ProductHierarchyLevel3Text = item["Product Hierarchy Text Level 3"].ToString(),
                }); ;
            }

            string batchId = data["batchId"].ToString();
            AzureModel.AddProductHierarchy(mm);

            AzureModel.RecordStats("ProductHierarchy", mm.Count, requestBody);
            return mm.Count;
        }

        public static int PersistMaterialLedger(string requestBody) {
            if (string.IsNullOrWhiteSpace(requestBody)) throw new Exception("Json is empty");
            JObject data = (JObject) JsonConvert.DeserializeObject(requestBody);
            List<MaterialLedger> mm = new List<MaterialLedger>();
            JArray items = (JArray)data["MaterialLedger"];
            foreach (JObject item in items) {
                mm.Add(new MaterialLedger() {
                    Plant = item["Plant"].ToString(),
                    CoCode = item["CoCode"].ToString(),
                    PostingYear = SuncorProductionFile.ParseInt(item["Posting Year"], "Posting Year"),
                    PostingPeriod = SuncorProductionFile.ParseInt(item["Posting Period"], "Posting Period"),
                    Status = item["Status"].ToString(),
                    PreviousPeriodOpen = item["Previous Period Open?"].ToString(),
                });
            }

            AzureModel.AddMaterialLedger(mm);
            AzureModel.RecordStats("MaterialLedger", mm.Count, requestBody);

            return 0;
        }
    }
}
