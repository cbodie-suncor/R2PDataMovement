using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.IO;
using System.Text;
using ExcelDataReader;
using R2PTransformation.src.db;

namespace R2PTransformation.src {
    public class DPSParser {
        private string Filename = "";

        public DPSFile LoadFile(string fileName, string plant, DateTime currentDay) {
            Filename = fileName;

            Encoding.RegisterProvider(CodePagesEncodingProvider.Instance);
            DPSFile ms = new DPSFile(fileName, plant);
            using (var stream = File.Open(fileName, FileMode.Open, FileAccess.Read)) {
                using (var reader = ExcelReaderFactory.CreateReader(stream)) {
                    var result = reader.AsDataSet(new ExcelDataSetConfiguration() {
                        ConfigureDataTable = (data) => new ExcelDataTableConfiguration() {
                            UseHeaderRow = true/*,
                            ReadHeaderRow = rowReader => {
                                rowReader.Read();
                                rowReader.Read();
                            }*/
                        }
                    });

                    DataTableCollection table = result.Tables;
                    // load current month
                    int month = currentDay.Month;
                    DataTable currentMonthSheet = table[0];
                    ms.Products.AddRange(GetProductionRecords(currentMonthSheet, ms));
                    return ms;
                }
            }
        }

        public List<TagBalance> GetProductionRecords(DataTable currentMonth, DPSFile ms) {
            List<TagBalance> list = new List<TagBalance>();
            foreach (var row in currentMonth.AsEnumerable()) {
                string productionCode = row["Plant"].ToString() + "_" + row["Material Description OR Product Code in DPS"].ToString();
                string uom = row["Display Unit of Measure"].ToString();
//                DateTime day = DateTime.FromOADate(double.Parse(row["transaction date"].ToString()));
//                DateTime day = DateTime.ParseExact(row["transaction date"].ToString(), "dd-MM-yyyy", CultureInfo.InvariantCulture);
                DateTime? day = row["transaction date"] as DateTime?;
                decimal quantity = decimal.Parse(row["production"].ToString());
                TagBalance tm = ms.GetNewTagBalance("DPS", productionCode, day.Value, quantity);
                if (tm != null) list.Add(tm);
            }
            return list;
        }
        /*
        private TagBalance GetProductionRecord(DataTable currentMonth, DPSFile ms, DateTime day) {
            decimal quantity = 0;
            int year = 0;
            /*
            if (ms.ProductCode == "2" || ms.ProductCode == "3") {
                year = int.Parse(currentMonth.Rows[1][0].ToString());
                if (year != day.Year) throw new Exception("year in file " + year + " does not match requested year " + day.Year);
            }

            if (ms.ProductCode == "2") quantity = decimal.Parse(currentMonth.Rows[day.Day + 5][16].ToString()); // column Q
            if (ms.ProductCode == "3") quantity = decimal.Parse(currentMonth.Rows[day.Day + 5][11].ToString()); // column L
            if (ms.ProductCode == "5") quantity = decimal.Parse(currentMonth.Rows[FindRowInCaustic(ms, currentMonth, day)][8].ToString()); // column Q
            return ms.GetNewTagBalance(ms.BatchId.ToString(), "DPS", day, quantity);
        }*/
    }
}
