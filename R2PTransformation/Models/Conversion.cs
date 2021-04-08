using System;
using System.Collections.Generic;

// Code scaffolded by EF Core assumes nullable reference types (NRTs) are not used or disabled.
// If you have enabled NRTs for your project, then un-comment the following line:
// #nullable disable

namespace R2PTransformation.Models
{
    public partial class Conversion
    {
        public string Material { get; set; }
        public string StandardUnit { get; set; }
        public string ToUnit { get; set; }
        public decimal? Factor { get; set; }

        public virtual StandardUnit StandardUnitNavigation { get; set; }
        public virtual StandardUnit ToUnitNavigation { get; set; }
    }
}
