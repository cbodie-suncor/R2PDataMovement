using System;
using System.Collections.Generic;
using System.Text;
using R2PTransformation.src.db;
using System.Linq;
using System.IO;
using System.Data;
using ExcelDataReader;

namespace R2PTransformation.src {
    public class SigmafineParser {
        public SuncorProductionFile LoadInventoryExcel(string fileName, string plant, DateTime currentDay) {
            Encoding.RegisterProvider(CodePagesEncodingProvider.Instance);
            SuncorProductionFile ms = new SuncorProductionFile(plant, fileName); // either GP01 or GP02
            ms.IsCurrentDay(currentDay);
            DateTime day = GetDayFromExcelHeader(fileName, 10, 5);
            using (var stream = File.Open(fileName, FileMode.Open, FileAccess.Read)) {
                using (var reader = ExcelReaderFactory.CreateReader(stream)) {
                    var result = reader.AsDataSet(new ExcelDataSetConfiguration() {
                        ConfigureDataTable = (data) => new ExcelDataTableConfiguration() {
                            UseHeaderRow = true,
                            ReadHeaderRow = rowReader => {
                                for(int i=0;i<14;i++) { rowReader.Read(); }
                            }
                        }
                    });
                    DataTableCollection table = result.Tables;
                    DataTable currentDaySheet = table[0];
                    foreach (DataRow row in currentDaySheet.AsEnumerable()) {
                        //                        string product = row[2].ToString();
                        string materialCode = "", tank = "", description = "";
                        decimal closing = 0;
                        description = row["Column0"].ToString();
                        tank = row["Column1"].ToString();
                        string closingStringValue = row["volume"].ToString();
                        materialCode = row["Material Code"].ToString();
                        if (string.IsNullOrEmpty(description) || description.ToLower().Contains("description") || description.ToLower().Contains("total")) continue;
                        try { 
                            closing = Math.Round(SuncorProductionFile.ParseDecimal(closingStringValue, "Closing"), 3);
                        } catch (Exception ex) {
                            ms.Warnings.Add(new WarningMessage(MessageType.Error, tank, ex.Message));
                            continue;
                        }

                        ms.AddTagBalance(currentDay, "Inventory Snapshot", "Sigmafine", materialCode, tank, day, null, null, closing, null, null, null);
                    }
                }
            }

            return ms;
        }
        public SuncorProductionFile LoadProductionExcel(string fileName, string plant, DateTime currentDay) {
            Encoding.RegisterProvider(CodePagesEncodingProvider.Instance);
            SuncorProductionFile ms = new SuncorProductionFile(plant, fileName); // either GP01 or GP02
            ms.IsCurrentDay(currentDay);
            DateTime day = GetDayFromExcelHeader(fileName, 2, 12);
            using (var stream = File.Open(fileName, FileMode.Open, FileAccess.Read)) {
                using (var reader = ExcelReaderFactory.CreateReader(stream)) {
                    var result = reader.AsDataSet(new ExcelDataSetConfiguration() {
                        ConfigureDataTable = (data) => new ExcelDataTableConfiguration() {
                            UseHeaderRow = true,
                            ReadHeaderRow = rowReader => {
                                rowReader.Read();
                                rowReader.Read();
                                rowReader.Read();
                                rowReader.Read();
                                rowReader.Read();
                                rowReader.Read();
                                rowReader.Read();
                                rowReader.Read();
                                rowReader.Read();
                            }
                        }
                    });
                    DataTableCollection table = result.Tables;
                    DataTable currentDaySheet = table[0];
                    foreach(DataRow row in currentDaySheet.AsEnumerable()) {
                        string product = row[2].ToString();
                        decimal production = 0, opening = 0, closing = 0, sale = 0, purchase = 0;
                        try {
                            string productionStringValue = row["production"].ToString();
                            string openingStringValue = row["opening"].ToString();
                            string closingStringValue = row["closing"].ToString();
                            string receiptsStringValue = row["purchase"].ToString();
                            string shipmentsStringValue = row["sale"].ToString();
                            if (string.IsNullOrEmpty(product) || product.ToLower().Contains("total") ) continue;
                            if (string.IsNullOrEmpty(productionStringValue) || productionStringValue == "bbl") continue;
                            production = Math.Round(SuncorProductionFile.ParseDecimal(productionStringValue, "Production"),3);
                            opening = Math.Round(SuncorProductionFile.ParseDecimal(openingStringValue, "Opening"), 3);
                            closing = Math.Round(SuncorProductionFile.ParseDecimal(closingStringValue, "Closing"), 3);
                            sale = Math.Round(SuncorProductionFile.ParseDecimal(shipmentsStringValue, "Sale"), 3);
                            purchase = Math.Round(SuncorProductionFile.ParseDecimal(receiptsStringValue, "Purchase"), 3);
                        } catch (Exception ex) {
                            ms.Warnings.Add(new WarningMessage(MessageType.Error, product, ex.Message));
                            continue;
                        }
                        ms.AddTagBalance(currentDay, "Sigmafine", "Production", product, null, day, production, opening, closing, sale, purchase, null);
                    }
                }
            }

            return ms;
        }

        private DateTime GetDayFromExcelHeader(string fileName, int row, int column) {
            using (var stream = File.Open(fileName, FileMode.Open, FileAccess.Read)) {
                using (var reader = ExcelReaderFactory.CreateReader(stream)) {
                    var result = reader.AsDataSet(new ExcelDataSetConfiguration() {
                        ConfigureDataTable = (data) => new ExcelDataTableConfiguration() {
                        }
                    });

                    DataTableCollection table = result.Tables;
                    DataTable currentDaySheet = table[0];  // used for productCode = 5
                    DateTime time = DateTime.MinValue;
                    string dayString = currentDaySheet.Rows[row][column].ToString();
                    if (dayString.Contains("-")) dayString = dayString.Substring(dayString.IndexOf("-") + 1);
                    time = DateTime.Parse(dayString);
                    return time;
                }
            }
        }
    }
}
