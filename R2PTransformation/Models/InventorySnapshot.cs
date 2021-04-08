using System;
using System.Collections.Generic;

// Code scaffolded by EF Core assumes nullable reference types (NRTs) are not used or disabled.
// If you have enabled NRTs for your project, then un-comment the following line:
// #nullable disable

namespace R2PTransformation.Models
{
    public partial class InventorySnapshot
    {
        public string Tag { get; set; }
        public string Tank { get; set; }
        public string System { get; set; }
        public string MovementType { get; set; }
        public string Material { get; set; }
        public string Plant { get; set; }
        public string WorkCenter { get; set; }
        public string ValType { get; set; }
        public DateTime QuantityTimestamp { get; set; }
        public decimal? Quantity { get; set; }
        public string StandardUnit { get; set; }
        public string BatchId { get; set; }
        public string CreatedBy { get; set; }
        public decimal? Confidence { get; set; }
        public DateTime? LastUpdated { get; set; }

        public virtual Batch Batch { get; set; }
        public virtual StandardUnit StandardUnitNavigation { get; set; }
    }
}
