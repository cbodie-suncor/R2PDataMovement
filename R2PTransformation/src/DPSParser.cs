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

        public SuncorProductionFile LoadFile(string fileName, string plant, DateTime currentDay) {
            Filename = fileName;

            Encoding.RegisterProvider(CodePagesEncodingProvider.Instance);
            SuncorProductionFile ms = new SuncorProductionFile(plant, fileName);
            ms.IsCurrentDay(currentDay);
            using (var stream = File.Open(fileName, FileMode.Open, FileAccess.Read)) {
                using (var reader = ExcelReaderFactory.CreateReader(stream)) {
                    var result = reader.AsDataSet(new ExcelDataSetConfiguration() {
                        ConfigureDataTable = (data) => new ExcelDataTableConfiguration() {
                            UseHeaderRow = true
                        }
                    });

                    DataTableCollection table = result.Tables;
                    if (table.IndexOf("Azure Data Load") == -1) throw new Exception("The sheet 'Azure Data Load' does not exist");
                    DataTable currentMonthSheet = table["Azure Data Load"];
                    LoadProductionRecords(currentMonthSheet, ms, currentDay);
                    return ms;
                }
            }
        }

        public void LoadProductionRecords(DataTable currentMonth, SuncorProductionFile ms, DateTime currentDay) {
            foreach (var row in currentMonth.AsEnumerable()) {
                string productionCode = row["Plant"].ToString() + "_" + row["Material Description OR Product Code in DPS"].ToString();
                string uom = row["Display Unit of Measure"].ToString();
                DateTime? day = row["transaction date"] as DateTime?;
                if (day == null && row["transaction date"] is double) {
                    day = DateTime.FromOADate((double)row["transaction date"]);
                }
                if (day == null) continue;
        
                decimal quantity = SuncorProductionFile.ParseDecimal(row["production"].ToString());
                try {
                    quantity = AzureModel.ConvertQuantityToStandardUnit(uom, quantity);
                } catch(Exception ex) {
                    ms.Warnings.Add(new WarningMessage(productionCode, ex.Message));
                    continue;
                }
                ms.AddTagBalance(currentDay, "DPS", "Production", productionCode, null, day.Value, quantity, null,null,null,null);
            }
        }
    }
}
