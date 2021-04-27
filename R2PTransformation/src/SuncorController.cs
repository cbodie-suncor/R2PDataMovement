using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System;
using System.Data;

namespace R2PTransformation.src {
    public class SuncorController {

        public SuncorController() {
        }

        protected static string GetStringValue(JToken v, string columnName) {
            try {
                if (v[columnName] == null) return null;
                if (string.IsNullOrWhiteSpace(v[columnName].ToString())) return null;
                return v[columnName].ToString().Trim();
            } catch (Exception ex) {
                throw new Exception("Cannot not find attribute " + columnName);
            }
        }

        public static DateTime ParseDateTime(JToken v, string columnName) {
            try {
                return DateTime.Parse(v[columnName].ToString());
            } catch (Exception ex) {
                throw new Exception("Invalid Date for " + columnName);
            }
        }

        public static DateTime ParseDateTime(DataRow v, string columnName) {
            try {
                return DateTime.Parse(v[columnName].ToString());
            } catch (Exception ex) {
                throw new Exception("Invalid Date for " + columnName);
            }
        }

        public static decimal ParseDecimal(JToken v, string columnName) {
            try {
                return string.IsNullOrEmpty(v[columnName].ToString()) ? 0 : decimal.Parse(v[columnName].ToString());
            } catch (Exception ex) {
                throw new Exception("Invalid Number for " + columnName);
            }
        }

        public static decimal ParseDecimal(DataRow v, string columnName) {
            try {
                return string.IsNullOrEmpty(v[columnName].ToString()) ? 0 : decimal.Parse(v[columnName].ToString());
            } catch (Exception ex) {
                throw new Exception("Invalid Number for " + columnName);
            }
        }

        public static double ParseDouble(JObject v, string columnName) {
            try {
                return string.IsNullOrEmpty(v[columnName].ToString()) ? 0 : double.Parse(v[columnName].ToString());
            } catch (Exception ex) {
                throw new Exception("Invalid Number for " + columnName);
            }
        }

        public static double ParseDouble(DataRow v, string columnName) {
            try {
                return string.IsNullOrEmpty(v[columnName].ToString()) ? 0 : double.Parse(v[columnName].ToString());
            } catch (Exception ex) {
                throw new Exception("Invalid Number for " + columnName);
            }
        }

        public static int ParseInt(JObject v, string columnName) {
            try {
                return string.IsNullOrEmpty(v[columnName].ToString()) ? 0 : int.Parse(v[columnName].ToString());
            } catch (Exception ex) {
                throw new Exception("Invalid Number for " + columnName);
            }
        }
    }
}
