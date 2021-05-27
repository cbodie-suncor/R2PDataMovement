using System;
using System.Collections.Generic;

// Code scaffolded by EF Core assumes nullable reference types (NRTs) are not used or disabled.
// If you have enabled NRTs for your project, then un-comment the following line:
// #nullable disable

namespace R2PTransformation.Models
{
    public partial class S4inventory
    {
        public string Material { get; set; }
        public string System { get; set; }
        public string Plant { get; set; }
        public string Tag { get; set; }
        public string MovementType { get; set; }
        public string StorageLocation { get; set; }
        public DateTime PostingDate { get; set; }
        public string ValuationType { get; set; }
        public string UnitOfMeasure { get; set; }
        public decimal? OpeningQuantity { get; set; }
        public decimal? ClosingQuantity { get; set; }
        public string BatchId { get; set; }
        public DateTime EnteredOn { get; set; }
        public string EnteredAt { get; set; }
        public string WorkCenter { get; set; }

        public virtual Batch Batch { get; set; }
        public virtual StandardUnit UnitOfMeasureNavigation { get; set; }
    }
}
