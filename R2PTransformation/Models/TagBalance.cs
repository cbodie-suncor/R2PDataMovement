using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;

// Code scaffolded by EF Core assumes nullable reference types (NRTs) are not used or disabled.
// If you have enabled NRTs for your project, then un-comment the following line:
// #nullable disable

namespace R2PTransformation.src.db {
    [Table("TagBalance")]
    public partial class TagBalance
    {
        public string Tag { get; set; }
        public string System { get; set; }
        public string MovementType { get; set; }
        public string Material { get; set; }
        public string Plant { get; set; }
        public string WorkCenter { get; set; }
        public string ValType { get; set; }
        public string Tank { get; set; }
        public DateTime QuantityTimestamp { get; set; }
        public DateTime BalanceDate { get; set; }
        public decimal? Quantity { get; set; }
        public string StandardUnit { get; set; }
        public string BatchId { get; set; }
        public DateTime Created { get; set; }
        public string CreatedBy { get; set; }
        public decimal? OpeningInventory { get; set; }
        public decimal? ClosingInventory { get; set; }
        public decimal? Shipment { get; set; }
        public decimal? Receipt { get; set; }
        public decimal? Confidence { get; set; }
        public virtual Batch Batch { get; set; }
        public virtual StandardUnit StandardUnitNavigation { get; set; }
    }
}
