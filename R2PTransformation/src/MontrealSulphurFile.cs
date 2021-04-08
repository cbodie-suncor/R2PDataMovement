using R2PTransformation.Models;
using System.Collections.Generic;

namespace R2PTransformation.src {
    public class MontrealSulphurFile : SuncorProductionFile {
        public string ProductCode;

        public MontrealSulphurFile(string fileName, string plant, string productCode) : base(plant, fileName) {
            ProductCode = productCode;
        }
    }
}
