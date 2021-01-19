﻿using R2PTransformation.src.db;
using System;
using System.Collections.Generic;
using System.Data;

namespace R2PTransformation.src {
    public class SigmafineFile : SuncorProductionFile {
        public SigmafineFile(string plant) : base(null) {
            // fileName is nonexistent, DB interface
            Plant = plant;
            Products = new List<TagBalance>();
        }

        public List<TagBalance> Products { get; set; }

        public override List<TagBalance> GetTagBalanceRecords() {
            return Products;
        }

        internal static Sigmafinex FromDataRow(DataRow row) {
            Sigmafinex item = new Sigmafinex();
            item.StartTime = DateTime.Parse(row["StartTime"].ToString());
            item.StartTime = DateTime.Parse(row["EndTime"].ToString());
            item.SourceCc = row["SourceCc"].ToString();
            item.FlowCc = row["FlowCc"].ToString();
            item.Product = row["Product"].ToString();
            item.ProductDesc = row["ProductDesc"].ToString();
            item.OpenFlag = row["OpenFlag"].ToString();
            item.CloseFlag = row["CloseFlag"].ToString();
            item.FlowType = row["FlowType"].ToString();
            item.IsCharge = row["IsCharge"].ToString();

            item.MeasLiqVol = ParseDecimal(row["MeasLiqVol"]);
            item.TankOpenVol = ParseDecimal(row["TankOpenVol"]);
            item.MeasLiqVol = ParseDecimal(row["TankCloseVol"]);
            return item;
        }

        private static decimal ParseDecimal(object v) {
            return string.IsNullOrEmpty(v.ToString()) ? 0 : decimal.Parse(v.ToString());
        }
    }
}