using Newtonsoft.Json;
using Newtonsoft.Json.Linq;

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
    }
}
