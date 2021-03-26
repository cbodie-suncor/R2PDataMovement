using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using R2PTransformation.src.db;
using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;

namespace R2PTransformation.src {
    public class SimplePersistentController : SuncorController {

        public SimplePersistentController() {     }

        public static int PersistHierarchy(string requestBody) {
            if (string.IsNullOrWhiteSpace(requestBody)) throw new Exception("Json is empty");
            object data = JsonConvert.DeserializeObject(requestBody);

            List<MaterialMovement> mm = new List<MaterialMovement>();
            List<WarningMessage> Warnings = new List<WarningMessage>();
            JObject batch = (JObject)data;
            string batchId = batch["batchId"].ToString();
            int successfulRecords = 0;

            AzureModel.RecordStats("Hierarchy", successfulRecords, requestBody);
            return mm.Count;
        }

        public static int PersistMaterialLedger(string requestBody) {
            if (string.IsNullOrWhiteSpace(requestBody)) throw new Exception("Json is empty");
            object data = JsonConvert.DeserializeObject(requestBody);

            List<MaterialMovement> mm = new List<MaterialMovement>();
            JObject batch = (JObject)data;
            string batchId = batch["batchId"].ToString();
            int successfulRecords = 0;

            AzureModel.RecordStats("Hierarchy", successfulRecords, requestBody);

            return 0;
        }
    }
}
