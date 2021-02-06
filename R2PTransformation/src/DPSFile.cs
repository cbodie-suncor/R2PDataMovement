using R2PTransformation.src.db;
using System;
using System.Collections.Generic;

namespace R2PTransformation.src {
    public class DPSFile : SuncorProductionFile {
        public DPSFile(string fileName, string plant) : base(fileName) {
            Plant = plant;
            Products = new List<TagBalance>();
        }

        public List<TagBalance> Products { get; set; }

        public override List<TagBalance> GetTagBalanceRecords() {
            return Products;
        }
    }
}
