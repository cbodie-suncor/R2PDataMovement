using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.IO;
using System.Text;
using ExcelDataReader;
using R2PTransformation.src.db;

namespace R2PTransformation.src {
    public class TerraNovaParser {
        private string Filename = "";

        public TerraNovaFile LoadFile(string fileName, string plant, DateTime currentDay) {
            Filename = fileName;

            Encoding.RegisterProvider(CodePagesEncodingProvider.Instance);
            TerraNovaFile ms = new TerraNovaFile(fileName, plant);
            ms.IsCurrentDay(currentDay);
            string fileContents = File.ReadAllText(fileName);
            DataTable dt = Utilities.ConvertTerraNovaCSVTexttoDataTable(fileContents);

            // load current month
            DataTable currentMonthSheet = dt;
            ms.Products.AddRange(GetProductionRecords(currentMonthSheet, ms, currentDay));
            return ms;
        }

        public List<TagBalance> GetProductionRecords(DataTable currentMonth, TerraNovaFile ms, DateTime currentDay) {
            List<TagBalance> list = new List<TagBalance>();
            foreach (var row in currentMonth.AsEnumerable()) {
                string productionCode = row["name"].ToString();
                DateTime day = DateTime.ParseExact(row["ts"].ToString().Substring(0, 9), "dd-MMM-yy", CultureInfo.InvariantCulture);
                if (!TerraNovaFile.IsDayValid(day, currentDay)) continue;
                decimal quantity = TerraNovaFile.ParseDecimal(row["value"].ToString());
                TagBalance tm = ms.GetNewTagBalance("DPS", productionCode, day, quantity);
                if (tm != null) list.Add(tm);
            }
            return list;
        }
    }
}
