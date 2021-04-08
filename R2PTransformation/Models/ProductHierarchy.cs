using System;
using System.Collections.Generic;

// Code scaffolded by EF Core assumes nullable reference types (NRTs) are not used or disabled.
// If you have enabled NRTs for your project, then un-comment the following line:
// #nullable disable

namespace R2PTransformation.Models
{
    public partial class ProductHierarchy
    {
        public int S4material { get; set; }
        public string MaterialDescription { get; set; }
        public string MaterialGroup { get; set; }
        public string MaterialGroupText { get; set; }
        public string ProductHierarchyLevel1Code { get; set; }
        public string ProductHierarchyLevel1Text { get; set; }
        public string ProductHierarchyLevel2Code { get; set; }
        public string ProductHierarchyLevel2Text { get; set; }
        public string ProductHierarchyLevel3Code { get; set; }
        public string ProductHierarchyLevel3Text { get; set; }
        public DateTime EnteredOn { get; set; }
        public string EnteredAt { get; set; }
    }
}
