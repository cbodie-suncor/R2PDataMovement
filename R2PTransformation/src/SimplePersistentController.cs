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
                    S4material = GetStringValue(item, "material"),
                    MaterialDescription = GetStringValue(item, "materialDescription"),
                    MaterialGroup = GetStringValue(item, "materialGroup"),
                    MaterialGroupText = GetStringValue(item, "materialGroupText"),
                    ProductHierarchyLevel1Code = GetStringValue(item, "productHierarchyLevel1"),
                    ProductHierarchyLevel2Code = GetStringValue(item, "productHierarchyLevel2"),
                    ProductHierarchyLevel3Code = GetStringValue(item, "productHierarchyLevel3"),
                    ProductHierarchyLevel1Text = GetStringValue(item, "productHierarchyLevel1Text"),
                    ProductHierarchyLevel2Text = GetStringValue(item, "productHierarchyLevel2Text"),
                    ProductHierarchyLevel3Text = GetStringValue(item, "productHierarchyLevel3Text"),
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
            JArray items = (JArray)data["materialLedger"];
            foreach (JObject item in items) {
                mm.Add(new MaterialLedger() {
                    Plant = GetStringValue(item,"plant"),
                    CoCode = GetStringValue(item, "companyCode"),
                    PostingYear = ParseInt(item, "currentPostingYear"),
                    PostingPeriod = ParseInt(item, "currentPostingPeriod"),
//                    Status = SuncorProductionFile.GetString(item,"Status"),
                    PreviousPeriodOpen = GetStringValue(item, "previousPeriodOpen"),
                });
            }

            AzureModel.AddMaterialLedger(mm);
            AzureModel.RecordStats("MaterialLedger", mm.Count, requestBody);

            return 0;
        }
    }
}
