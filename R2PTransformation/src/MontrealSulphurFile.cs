using R2PTransformation.src.db;
using System.Collections.Generic;

namespace R2PTransformation.src {
    public class MontrealSulphurFile : SuncorProductionFile {
        public string ProductCode;

        public MontrealSulphurFile(string fileName, string plant, string productCode) : base(fileName) {
            ProductCode = productCode;
            Plant = plant;
            Products = new List<TagBalance>();
        }

        public List<TagBalance> Products { get; set; }

        public override List<TagBalance> GetTagBalanceRecords() {
            return Products;
        }
    }
}
