using R2PTransformation.src.db;
using System;
using System.Collections.Generic;
using System.Data;

namespace R2PTransformation.src {
    public class SigmafineFile : SuncorProductionFile {
        public SigmafineFile(string filename, string plant) : base(filename) {
            Plant = plant;
        }
    }
}
