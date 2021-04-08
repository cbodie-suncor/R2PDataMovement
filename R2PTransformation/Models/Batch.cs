﻿using System;
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
            InventorySnapshot = new HashSet<InventorySnapshot>();
            TagBalance = new HashSet<TagBalance>();
        }

        public string Id { get; set; }
        public byte Status { get; set; }
        public DateTime Created { get; set; }
        public string CreatedBy { get; set; }
        public string Filename { get; set; }

        public virtual ICollection<InventorySnapshot> InventorySnapshot { get; set; }
        public virtual ICollection<TagBalance> TagBalance { get; set; }
    }
}
