using System;
using System.Collections.Generic;

// Code scaffolded by EF Core assumes nullable reference types (NRTs) are not used or disabled.
// If you have enabled NRTs for your project, then un-comment the following line:
// #nullable disable

namespace R2PTransformation.Models
{
    public partial class StandardUnit
    {
        public StandardUnit()
        {
            ConversionStandardUnitNavigation = new HashSet<Conversion>();
            ConversionToUnitNavigation = new HashSet<Conversion>();
            CustodyTicketBaseUnitOfEntryNavigation = new HashSet<CustodyTicket>();
            CustodyTicketBaseUnitOfMeasureNavigation = new HashSet<CustodyTicket>();
            CustodyTicketTemperatureUnitOfMeasureNavigation = new HashSet<CustodyTicket>();
            InventorySnapshot = new HashSet<InventorySnapshot>();
            MaterialMovementUnitOfEntryNavigation = new HashSet<MaterialMovement>();
            MaterialMovementUnitOfMeasureNavigation = new HashSet<MaterialMovement>();
            SourceUnitMap = new HashSet<SourceUnitMap>();
            TagBalance = new HashSet<TagBalance>();
            TagMap = new HashSet<TagMap>();
        }

        public string Name { get; set; }

        public virtual ICollection<Conversion> ConversionStandardUnitNavigation { get; set; }
        public virtual ICollection<Conversion> ConversionToUnitNavigation { get; set; }
        public virtual ICollection<CustodyTicket> CustodyTicketBaseUnitOfEntryNavigation { get; set; }
        public virtual ICollection<CustodyTicket> CustodyTicketBaseUnitOfMeasureNavigation { get; set; }
        public virtual ICollection<CustodyTicket> CustodyTicketTemperatureUnitOfMeasureNavigation { get; set; }
        public virtual ICollection<InventorySnapshot> InventorySnapshot { get; set; }
        public virtual ICollection<MaterialMovement> MaterialMovementUnitOfEntryNavigation { get; set; }
        public virtual ICollection<MaterialMovement> MaterialMovementUnitOfMeasureNavigation { get; set; }
        public virtual ICollection<SourceUnitMap> SourceUnitMap { get; set; }
        public virtual ICollection<TagBalance> TagBalance { get; set; }
        public virtual ICollection<TagMap> TagMap { get; set; }
    }
}
