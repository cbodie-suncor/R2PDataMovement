using System;
using System.Collections.Generic;

// Code scaffolded by EF Core assumes nullable reference types (NRTs) are not used or disabled.
// If you have enabled NRTs for your project, then un-comment the following line:
// #nullable disable

namespace R2PTransformation.Models
{
    public partial class TransactionEvent
    {
        public TransactionEvent()
        {
            TransactionEventDetail = new HashSet<TransactionEventDetail>();
        }

        public int TransactionEventId { get; set; }
        public string Plant { get; set; }
        public string Filename { get; set; }
        public int? FailedRecordCount { get; set; }
        public int? SuccessfulRecordCount { get; set; }
        public string Message { get; set; }
        public DateTime? CreateDate { get; set; }
        public string Type { get; set; }
        public string Extra { get; set; }

        public virtual ICollection<TransactionEventDetail> TransactionEventDetail { get; set; }
    }
}
