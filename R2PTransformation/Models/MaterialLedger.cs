using System;
using System.Collections.Generic;

// Code scaffolded by EF Core assumes nullable reference types (NRTs) are not used or disabled.
// If you have enabled NRTs for your project, then un-comment the following line:
// #nullable disable

namespace R2PTransformation.Models
{
    public partial class MaterialLedger
    {
        public string Plant { get; set; }
        public string CoCode { get; set; }
        public int PostingYear { get; set; }
        public int? PostingPeriod { get; set; }
        public string Status { get; set; }
        public string PreviousPeriodOpen { get; set; }
    }
}
