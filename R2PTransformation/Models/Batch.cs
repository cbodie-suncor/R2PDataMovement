using System;
using System.Collections.Generic;

// Code scaffolded by EF Core assumes nullable reference types (NRTs) are not used or disabled.
// If you have enabled NRTs for your project, then un-comment the following line:
// #nullable disable

namespace R2PTransformation.Models
{
    public partial class Batch
    {
        public Batch()
        {
            CustodyTicket = new HashSet<CustodyTicket>();
            InventorySnapshot = new HashSet<InventorySnapshot>();
            MaterialMovement = new HashSet<MaterialMovement>();
            S4inventory = new HashSet<S4inventory>();
            TagBalance = new HashSet<TagBalance>();
        }

        public string Id { get; set; }
        public byte Status { get; set; }
        public DateTime Created { get; set; }
        public string CreatedBy { get; set; }
        public string Filename { get; set; }

        public virtual ICollection<CustodyTicket> CustodyTicket { get; set; }
        public virtual ICollection<InventorySnapshot> InventorySnapshot { get; set; }
        public virtual ICollection<MaterialMovement> MaterialMovement { get; set; }
        public virtual ICollection<S4inventory> S4inventory { get; set; }
        public virtual ICollection<TagBalance> TagBalance { get; set; }
    }
}
