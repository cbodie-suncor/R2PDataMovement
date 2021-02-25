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
        public SigmafineFile LoadExcel(string fileName, string plant, DateTime currentDay) {
            Encoding.RegisterProvider(CodePagesEncodingProvider.Instance);
            SigmafineFile ms = new SigmafineFile(fileName, plant); // either GP01 or GP02
            ms.IsCurrentDay(currentDay);
            DateTime day = GetDayFromExcelFile(fileName);
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
                        decimal production = 0;
                        try {
                            string productionStringValue = row["production"].ToString();
                            if (string.IsNullOrEmpty(product) || product.ToLower().Contains("total") ) continue;
                            if (string.IsNullOrEmpty(productionStringValue) || productionStringValue == "bbl") continue;
                            production = Math.Round(SigmafineFile.ParseDecimal(productionStringValue),3);
// removed Feb 24, 21                            if (production == 0) continue;
                        } catch (Exception ex) {
                        }
                        ms.AddTagBalance(currentDay, "Sigmafine", product, day, production);
                    }
                }
            }

            return ms;
        }

        private DateTime GetDayFromExcelFile(string fileName) {
            using (var stream = File.Open(fileName, FileMode.Open, FileAccess.Read)) {
                using (var reader = ExcelReaderFactory.CreateReader(stream)) {
                    var result = reader.AsDataSet(new ExcelDataSetConfiguration() {
                        ConfigureDataTable = (data) => new ExcelDataTableConfiguration() {
                        }
                    });

                    DataTableCollection table = result.Tables;
                    DataTable currentDaySheet = table[0];  // used for productCode = 5
                    DateTime time = DateTime.MinValue;
                    try {
                        time = DateTime.Parse(currentDaySheet.Rows[2][12].ToString());
                    } catch (Exception ex) { }
                    return time;
                }
            }
        }
    }
}
