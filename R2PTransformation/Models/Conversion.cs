using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;

// Code scaffolded by EF Core assumes nullable reference types (NRTs) are not used or disabled.
// If you have enabled NRTs for your project, then un-comment the following line:
// #nullable disable

namespace R2PTransformation.src.db {
    [Table("Conversion")]
    public partial class Conversion {
        public string Material { get; set; }
        public string StandardUnit { get; set; }
        public string ToUnit { get; set; }
        public decimal? Factor { get; set; }

        public virtual StandardUnit StandardUnitNavigation { get; set; }
        public virtual StandardUnit ToUnitNavigation { get; set; }

        public override string ToString() {
            return this.Material + "," + this.StandardUnit + "," + this.ToUnit;
        }

        public override bool Equals(object obj) {
            return Equals(obj as Conversion);
        }

        public bool Equals(Conversion other) {
            return other != null &&
                   Material == other.Material &&
                   StandardUnit == other.StandardUnit &&
                   ToUnit == other.ToUnit;
        }

        public override int GetHashCode() {
            return HashCode.Combine(Material, StandardUnit, ToUnit);
        }
    }
}
