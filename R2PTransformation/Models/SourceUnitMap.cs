using System;
using System.Collections.Generic;

// Code scaffolded by EF Core assumes nullable reference types (NRTs) are not used or disabled.
// If you have enabled NRTs for your project, then un-comment the following line:
// #nullable disable

namespace R2PTransformation.Models
{
    public partial class SourceUnitMap
    {
        public string Source { get; set; }
        public string SourceUnit { get; set; }
        public string StandardUnit { get; set; }

        public virtual StandardUnit StandardUnitNavigation { get; set; }
    }
}
