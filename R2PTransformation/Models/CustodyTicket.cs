using System;
using System.Collections.Generic;

// Code scaffolded by EF Core assumes nullable reference types (NRTs) are not used or disabled.
// If you have enabled NRTs for your project, then un-comment the following line:
// #nullable disable

namespace R2PTransformation.Models
{
    public partial class CustodyTicket
    {
        public int CustodyTicketId { get; set; }
        public string S4MaterialDocument { get; set; }
        public string BolNumber { get; set; }
        public string MovemonmentTypeDescription { get; set; }
        public string Sign { get; set; }
        public decimal? NetQuantitySizeInUoe { get; set; }
        public decimal NetQuantitySizeInBuoe { get; set; }
        public decimal? Mass { get; set; }
        public string BaseUnitOfMeasure { get; set; }
        public string BaseUnitOfEntry { get; set; }
        public string ValuationType { get; set; }
        public decimal? Density { get; set; }
        public string DensityUom { get; set; }
        public string Origin { get; set; }
        public string Destination { get; set; }
        public string Plant { get; set; }
        public decimal? Temperature { get; set; }
        public string TemperatureUnitOfMeasure { get; set; }
        public string MovementType { get; set; }
        public int Mode { get; set; }
        public string Tender { get; set; }
        public string VehicleText { get; set; }
        public string VehicleNumber { get; set; }
        public DateTime? LoadStartDateTime { get; set; }
        public DateTime? LoadEndDateTime { get; set; }
        public DateTime? EnteredOnDateTime { get; set; }
        public string EnteredBy { get; set; }
        public DateTime? DocumentDateTime { get; set; }
        public DateTime PostingDateTime { get; set; }

        public virtual StandardUnit BaseUnitOfEntryNavigation { get; set; }
        public virtual StandardUnit BaseUnitOfMeasureNavigation { get; set; }
        public virtual StandardUnit TemperatureUnitOfMeasureNavigation { get; set; }
    }
}
