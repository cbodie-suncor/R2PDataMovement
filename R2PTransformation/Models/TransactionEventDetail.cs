using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;

// Code scaffolded by EF Core assumes nullable reference types (NRTs) are not used or disabled.
// If you have enabled NRTs for your project, then un-comment the following line:
// #nullable disable

namespace R2PTransformation.src.db {
    [Table("TransactionEventDetail")]
    public partial class TransactionEventDetail
    {
        public int TransactionEventDetailId { get; set; }
        public int? TransactionEventId { get; set; }
        public string Type { get; set; }
        public string Tag { get; set; }
        public string Message { get; set; }

        public virtual TransactionEvent TransactionEvent { get; set; }
    }
}
