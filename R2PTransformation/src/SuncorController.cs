using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using R2PTransformation.src.db;
using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;

namespace R2PTransformation.src {
    public class SuncorController {

        public SuncorController() {
        }

        protected static string GetStringValue(JToken jToken) {
            string value = null;
            value = jToken.ToString();
            if (string.IsNullOrWhiteSpace(value)) return null;
            return value.Trim();
        }

        protected static decimal? GetDecimalValue(JToken jToken) {
            decimal? value = null;
            if (jToken.ToString() == "") return value;

            return (decimal)jToken;
        }
    }
}
