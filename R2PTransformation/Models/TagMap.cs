using System;
using System.Collections.Generic;

// Code scaffolded by EF Core assumes nullable reference types (NRTs) are not used or disabled.
// If you have enabled NRTs for your project, then un-comment the following line:
// #nullable disable

namespace R2PTransformation.Models
{
    public partial class TagMap
    {
        public string Tag { get; set; }
        public string Plant { get; set; }
        public string WorkCenter { get; set; }
        public string MaterialNumber { get; set; }
        public string DefaultValuationType { get; set; }
        public string DefaultUnit { get; set; }

        public virtual StandardUnit DefaultUnitNavigation { get; set; }
    }
}
