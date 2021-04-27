using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using R2PTransformation.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Globalization;

namespace R2PTransformation.src {
    public class ProductionMatDocController : SuncorController {

        public ProductionMatDocController() {
        }

        public int Persist(string requestBody) {
            if (string.IsNullOrWhiteSpace(requestBody)) throw new Exception("Json is empty");
            object data = JsonConvert.DeserializeObject(requestBody);

            var units = AzureModel.GetUnits();
            List<MaterialMovement> mm = new List<MaterialMovement>();
            List<WarningMessage> Warnings = new List<WarningMessage>();
            JObject batch = (JObject)data;
            string batchId = batch["batchId"].ToString();
            JArray materialMovements = (JArray)batch["materialMovement"];
            foreach (JObject item in materialMovements) {
                MaterialMovement sm = new MaterialMovement();
                sm.MaterialDocument = GetStringValue(item,"materialDocument");
                sm.Material         = ParseInt(item, "material");
                sm.System           = GetStringValue(item,"system");
                sm.MovementType     = GetStringValue(item,"movementType");
                sm.MovementTypeDesc = GetStringValue(item,"movementTypeDesc");
                sm.Plant            = GetStringValue(item,"plant");
                sm.HeaderText       = GetStringValue(item,"headerText");
                sm.PostingDate      = ParseDateTime(item,"postingDate");
                sm.ValuationType    = GetStringValue(item,"valuationType");
                sm.Quantity         = ParseDecimal(item, "quantity");
                sm.QuantityInUoe    = ParseDecimal(item, "quantityUoe");
                sm.QuantityInL15    = ParseDecimal(item, "quantityL15");
                sm.UnitOfEntry      = GetStringValue(item,"uoe");
                sm.UnitOfMeasure    = GetStringValue(item, "uom");
                sm.EnteredOn        = item["enteredOn"].ToString() == "" ? DateTime.Now : (DateTime) item["enteredOn"];
                sm.EnteredAt        = GetStringValue(item, "enteredAt") ?? "R2PLoader";

                var found = units.SingleOrDefault(t=>t.Name == sm.UnitOfEntry);
                if (found == null) {
                    Warnings.Add(new WarningMessage(MessageType.Info, "cannot find UOM for" + sm.UnitOfEntry));
                    continue;
                }

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
