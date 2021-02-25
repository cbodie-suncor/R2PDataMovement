using R2PTransformation.src.db;
using System.Collections.Generic;

namespace R2PTransformation.src {
    public class MontrealSulphurFile : SuncorProductionFile {
        public string ProductCode;

        public MontrealSulphurFile(string fileName, string plant, string productCode) : base(fileName) {
            ProductCode = productCode;
            Plant = plant;
        }
    }
}
