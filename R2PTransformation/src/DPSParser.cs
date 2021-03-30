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
                    if (table.IndexOf("Azure Load") == -1) throw new Exception("The sheet 'Azure Load' does not exist");
                    DataTable currentMonthSheet = table["Azure Load"];
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

                decimal production = 0, opening = 0, closing = 0, shipments = 0, receipts = 0;
                try {
                    production = SuncorProductionFile.ParseDecimal(row["production"].ToString(), "Production");
                    shipments = SuncorProductionFile.ParseDecimal(row["Shipments"].ToString(), "Shipments");
                    receipts = SuncorProductionFile.ParseDecimal(row["Receipts"].ToString(), "Receipts");
                    opening = SuncorProductionFile.ParseDecimal(row["Beginning Inventory"].ToString(), "Beginning Inventory");
                    closing = SuncorProductionFile.ParseDecimal(row["Ending Inventory"].ToString(), "Ending Inventory");

                    production = AzureModel.ConvertQuantityToStandardUnit(uom, production);
                    receipts = AzureModel.ConvertQuantityToStandardUnit(uom, receipts);
                    shipments = AzureModel.ConvertQuantityToStandardUnit(uom, shipments);
                    opening = AzureModel.ConvertQuantityToStandardUnit(uom, opening);
                    closing = AzureModel.ConvertQuantityToStandardUnit(uom, closing);
                } catch (Exception ex) {
                    ms.Warnings.Add(new WarningMessage(MessageType.Error, productionCode, ex.Message));
                    continue;
                }
                ms.AddTagBalance(currentDay, "DPS", "Production", productionCode, null, day.Value, production, opening,closing,shipments,receipts, null);
            }
        }
    }
}
