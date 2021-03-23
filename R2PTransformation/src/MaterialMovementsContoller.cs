﻿using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using R2PTransformation.src.db;
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
                sm.Material = (int)item["material"];
                sm.System = GetStringValue(item["system"]);
                sm.MovementType = GetStringValue(item["movementType"]);
                sm.MovementTypeDesc = GetStringValue(item["movementTypeDesc"]);
                sm.Plant = GetStringValue(item["plant"]);
                sm.HeaderText = GetStringValue(item["headerText"]);
                sm.PostingDate = (DateTime)item["postingDate"];
                sm.ValuationType = GetStringValue(item["valuationType"]);
                sm.Quantity = GetDecimalValue(item["quantity"]);
                sm.QuantityInUoe = GetDecimalValue(item["quantityUoe"]);
                sm.QuantityInL15 = GetDecimalValue(item["quantityL15"]);
                sm.UnitOfEntry = GetStringValue(item["uoe"]);
                sm.UnitOfMeasure = GetStringValue(item["uom"]);
                sm.EnteredOn = item["enteredOn"].ToString() == "" ? DateTime.Now : (DateTime) item["enteredOn"];
                sm.EnteredAt = GetStringValue(item["enteredAt"]) == null ? "R2PLoader" : GetStringValue(item["enteredAt"]);
                sm.Quantity = (decimal)item["quantity"];
                TagMap tm = AzureModel.ReverseLookupTag(sm.Material.Value, sm.Plant);
                if (tm == null) {
                    Warnings.Add(new WarningMessage(sm.Material.ToString(), "No TagMapping"));
                } else {
                    sm.Tag = tm.Tag;
                    mm.Add(sm);
                }
            }
            AzureModel.AddMaterialMovements(mm);
            string plant = mm.Count > 0 ? mm[0].Plant : null;
            AzureModel.RecordStats("Material Movement", null, Warnings, plant, mm.Count, Warnings.Count, requestBody);
            return mm.Count;
        }
        /*
        private string GetStringValue(JToken jToken) {
            string value = null;
            value = jToken.ToString();
            if (string.IsNullOrWhiteSpace(value)) return null;
            return value.Trim();
        }

        private decimal? GetDecimalValue(JToken jToken) {
            decimal? value = null;
            if (jToken.ToString() == "") return value;

            return (decimal)jToken;
        }
        */
        private void LoadProductionRecords(DataTable currentMonth, SuncorProductionFile ms, DateTime currentDay) {
            foreach (var row in currentMonth.AsEnumerable()) {
                string productionCode = row["name"].ToString();
                DateTime day = DateTime.ParseExact(row["ts"].ToString().Substring(0, 9), "dd-MMM-yy", CultureInfo.InvariantCulture);
                decimal quantity = SuncorProductionFile.ParseDecimal(row["value"].ToString());
                ms.AddTagBalance(currentDay, "OPIS", "Production", productionCode, null, day.AddDays(-1), quantity, null, null, null, null);
            }
        }
    }
}