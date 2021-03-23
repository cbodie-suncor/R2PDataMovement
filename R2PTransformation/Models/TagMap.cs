using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;

// Code scaffolded by EF Core assumes nullable reference types (NRTs) are not used or disabled.
// If you have enabled NRTs for your project, then un-comment the following line:
// #nullable disable

namespace R2PTransformation.src.db {
    [Table("TagMap")]
    public partial class TagMap
    {
        public string Tag { get; set; }
        public string Plant { get; set; }
        public string WorkCenter { get; set; }
        public string MaterialNumber { get; set; }
        public string DefaultValuationType { get; set; }
        public string DefaultUnit { get; set; }

        public virtual StandardUnit DefaultUnitNavigation { get; set; }

        public override string ToString() {
            return this.Plant + "," + this.Tag;
        }

        public override bool Equals(object obj) {
            return Equals(obj as TagMap);
        }

        public bool Equals(TagMap other) {
            return other != null &&
                   Tag == other.Tag &&
                   Plant == other.Plant;
        }

        public override int GetHashCode() {
            return HashCode.Combine(Tag, Plant);
        }
    }
}
