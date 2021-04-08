using System;
using System.Collections.Generic;

// Code scaffolded by EF Core assumes nullable reference types (NRTs) are not used or disabled.
// If you have enabled NRTs for your project, then un-comment the following line:
// #nullable disable

namespace R2PTransformation.Models
{
    public partial class MaterialMovement
    {
        public int MaterialMovementId { get; set; }
        public string MaterialDocument { get; set; }
        public int? Material { get; set; }
        public string System { get; set; }
        public string MovementType { get; set; }
        public string MovementTypeDesc { get; set; }
        public string Plant { get; set; }
        public string HeaderText { get; set; }
        public string Tag { get; set; }
        public DateTime PostingDate { get; set; }
        public string ValuationType { get; set; }
        public decimal? Quantity { get; set; }
        public string UnitOfEntry { get; set; }
        public string UnitOfMeasure { get; set; }
        public decimal? QuantityInUoe { get; set; }
        public decimal? QuantityInL15 { get; set; }
        public string BatchId { get; set; }
        public DateTime EnteredOn { get; set; }
        public string EnteredAt { get; set; }

        public virtual StandardUnit UnitOfEntryNavigation { get; set; }
        public virtual StandardUnit UnitOfMeasureNavigation { get; set; }
    }
}
