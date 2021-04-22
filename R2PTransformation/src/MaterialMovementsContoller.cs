using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using R2PTransformation.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;

namespace R2PTransformation.src {
    public class ProductionMatDocController : SuncorController {

        public ProductionMatDocController() {
        }

        public int Persist(string requestBody) {
            if (string.IsNullOrWhiteSpace(requestBody)) throw new Exception("Json is empty");
            object data = JsonConvert.DeserializeObject(requestBody);

            List<MaterialMovement> mm = new List<MaterialMovement>();
            List<WarningMessage> Warnings = new List<WarningMessage>();
            JObject batch = (JObject)data;
            string batchId = batch["batchId"].ToString();
            JArray materialMovements = (JArray)batch["materialMovement"];
            foreach (var item in materialMovements) {
                MaterialMovement sm = new MaterialMovement();
                sm.MaterialDocument = GetStringValue(item["materialDocument"]);
                sm.Material         = SuncorProductionFile.ParseInt(item["material"], "material");;
                sm.System           = GetStringValue(item["system"]);
                sm.MovementType     = GetStringValue(item["movementType"]);
                sm.MovementTypeDesc = GetStringValue(item["movementTypeDesc"]);
                sm.Plant            = GetStringValue(item["plant"]);
                sm.HeaderText       = GetStringValue(item["headerText"]);
                sm.PostingDate      = SuncorProductionFile.ParseDateTime(item["postingDate"], "postingDate");
                sm.ValuationType    = GetStringValue(item["valuationType"]);
                sm.Quantity         = SuncorProductionFile.ParseDecimal(item["quantity"], "quantity");
                sm.QuantityInUoe    = SuncorProductionFile.ParseDecimal(item["quantityUoe"], "quantityUoe");
                sm.QuantityInL15    = SuncorProductionFile.ParseDecimal(item["quantityL15"], "quantityL15");
                sm.UnitOfEntry      = GetStringValue(item["uoe"]);
                sm.UnitOfMeasure    = GetStringValue(item["uom"]);
                sm.EnteredOn        = item["enteredOn"].ToString() == "" ? DateTime.Now : (DateTime) item["enteredOn"];
                sm.EnteredAt        = GetStringValue(item["enteredAt"]) == null ? "R2PLoader" : GetStringValue(item["enteredAt"]);
                /*
                TagMap tm = AzureModel.ReverseLookupTag(sm.Material.Value, sm.Plant);
                if (tm == null) {
                    Warnings.Add(new WarningMessage(MessageType.Info, sm.Material.ToString(), "No TagMapping"));
                } else {
                    sm.Tag = tm.Tag;
                    mm.Add(sm);
                }
                */
                mm.Add(sm);
            }
            AzureModel.AddMaterialMovements(mm);
            string plant = mm.Count > 0 ? mm[0].Plant : null;
            AzureModel.RecordStats("Material Movement", null, Warnings, plant, mm.Count, Warnings.Count, requestBody);
            return mm.Count;
        }
    }
}
