using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using R2PTransformation.Models;
using System;
using System.Collections.Generic;
using System.Linq;

namespace R2PTransformation.src {
    public class SimplePersistentController : SuncorController {

        public class S4InventoryBatch {
            public S4InventoryBatch() {
                this.Warnings = new List<WarningMessage>();
                this.Inventory = new List<S4inventory>();
            }

            public String Json { get; set; }
            public List<S4inventory> Inventory{ get; set; }
            public List<WarningMessage> Warnings { get; set; }
            public int SuccessFulRecords { get { return this.Inventory.Count; } }
            public string BatchId { get; set; }
        }


    public SimplePersistentController() {     }

        public static S4InventoryBatch PersistS4Inventory(string requestBody) {
            S4InventoryBatch s4InventoryBatch = new S4InventoryBatch();
            if (string.IsNullOrWhiteSpace(requestBody)) throw new Exception("Json is empty");
            object data = JsonConvert.DeserializeObject(requestBody);

            List<S4inventory> mm = new List<S4inventory>();
            List<WarningMessage> Warnings = new List<WarningMessage>();
            JObject batch = (JObject)data;
            JArray items = (JArray)batch["inventory"];
            s4InventoryBatch.BatchId = batch["batchId"].ToString();
            foreach (JObject item in items) {
                try { 
                    S4inventory sm = new S4inventory();
                    sm.Material = ParseInt(item, "material");
                    sm.Plant = GetStringValue(item, "plant");
                    sm.ValuationType = GetStringValue(item, "valuationType");
                    sm.OpeningQuantity = ParseDecimal(item, "openingQuantity");
                    sm.ClosingQuantity = ParseDecimal(item, "closingInventory");
                    sm.UnitOfMeasure = GetStringValue(item, "baseUnitOfMeasure");
                    sm.System = GetStringValue(item, "system");
                    sm.MovementType = GetStringValue(item, "movementType");
                    sm.StorageLocation = GetStringValue(item, "storageLocation");
                    sm.PostingDate = ParseDateTime(item, "date");
                    sm.EnteredOn = item["enteredOn"] == null || item["enteredOn"].ToString() == "" ? DateTime.Now : (DateTime)item["enteredOn"];
                    sm.EnteredAt = GetStringValue(item, "enteredAt") ?? "R2PLoader";
                    if (s4InventoryBatch.Inventory.Where(t => t.Material == sm.Material && t.Plant == sm.Plant && t.ValuationType == sm.ValuationType && t.PostingDate == sm.PostingDate).Count() > 0) {
                        throw new Exception("Duplicate Record");
                    }
                    s4InventoryBatch.Inventory.Add(sm);
                } catch (Exception ex) {
                    string material = GetStringValue(item, "material");
                    string plant = GetStringValue(item, "plant");
                    string valType = GetStringValue(item, "valuationType");
                    string date = GetStringValue(item, "date");
                    s4InventoryBatch.Warnings.Add(new WarningMessage(MessageType.Error, "{material:\"" + material + "\",plant:\"" + plant + "\",valuationType:\"" + valType + "\",date:\"" + date + "\",error:\"" + ex.Message + "\"}"));
                }
            }
            AzureModel.AddS4Inventory(s4InventoryBatch);

            AzureModel.RecordStats("S4Inventory", mm.Count, requestBody);
            return s4InventoryBatch;
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
