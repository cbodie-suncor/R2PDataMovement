using R2PTransformation.src.db;
using System.Collections.Generic;

namespace R2PTransformation.src {
    public class TerraNovaFile : SuncorProductionFile {
        public TerraNovaFile(string fileName, string plant) : base(fileName) {
            Plant = plant;
        }
    }
}
