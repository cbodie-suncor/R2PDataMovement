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
        public string S4Material { get; set; }
        public string SourceDataMaterialCode { get; set; }
        public string Sign { get; set; }
        public decimal GrossQuantitySize { get; set; }
        public decimal NetQuantitySize { get; set; }
        public string UnitOfMeasure { get; set; }
        public string ValuationType { get; set; }
        public decimal Density { get; set; }
        public string MovementPlant { get; set; }
        public string SendingPlant { get; set; }
        public string ReceivingPlant { get; set; }
        public string Temperature { get; set; }
        public string MovementType { get; set; }
        public string Mode { get; set; }
        public string LoadStartDate { get; set; }
        public string LoadStartTime { get; set; }
        public DateTime LoadEndDateTime { get; set; }
        public DateTime EnteredOnDateTime { get; set; }
        public string EnteredBy { get; set; }
        public DateTime DocumentDateTime { get; set; }
        public DateTime PostingDateTime { get; set; }

        public virtual StandardUnit UnitOfMeasureNavigation { get; set; }
    }
}
