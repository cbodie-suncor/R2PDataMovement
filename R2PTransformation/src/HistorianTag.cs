using System;
using System.Collections.Generic;
using System.Text;

namespace R2PTransformation.src {
    public class HistorianTag {
        public string Site { get; }
        public string Tag { get; }
        public string Alias { get; }
        public DateTime Datetime { get; }
        public decimal Value { get; }
        public decimal AvgValue { get; }
        public string StrValue { get; }
        public decimal Quality { get; }

        public HistorianTag(string site, string tag, string alias, DateTime datetime, decimal value, decimal avgValue, string strValue, decimal quality) {
            Site = site;
            Tag = tag;
            Alias = alias;
            Datetime = datetime;
            Value = value;
            AvgValue = avgValue;
            StrValue = strValue;
            Quality = quality;
        }

        public String BaseTag {
            get {
                int find = Tag.IndexOf(".");
                if (find == -1) find = Tag.IndexOf("_");
                if (find == -1) return Tag;
                return Tag.Substring(0, find);
            }
        }

        public String Tank {
            get {
                if (Site == "Oilsandspi") return null;
                return Alias.Replace(" Product code", "").Replace(" Net Volume", "").Replace(" Volume", "");
            }
        }


        public override bool Equals(object obj) {
            return obj is HistorianTag other &&
                   Site == other.Site &&
                   Tag == other.Tag &&
                   Alias == other.Alias &&
                   Datetime == other.Datetime &&
                   Value == other.Value &&
                   AvgValue == other.AvgValue &&
                   StrValue == other.StrValue &&
                   Quality == other.Quality;
        }

        public override int GetHashCode() {
            return HashCode.Combine(Site, Tag, Alias, Datetime, Value, AvgValue, StrValue, Quality);
        }
    }
}
