using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Text;
using ExcelDataReader;
using R2PTransformation.Models;

namespace R2PTransformation.src {
    public class MontrealSulphurParser {

        public MontrealSulphurFile LoadFile(byte[] fileContents, string plant, string productCode, DateTime currentDay) {

            Encoding.RegisterProvider(CodePagesEncodingProvider.Instance);
            MontrealSulphurFile ms = new MontrealSulphurFile(plant, productCode);
            ms.IsCurrentDay(currentDay);
            {
                using (var reader = ExcelReaderFactory.CreateReader(new MemoryStream(fileContents))) {
                    var result = reader.AsDataSet(new ExcelDataSetConfiguration() {
                        ConfigureDataTable = (data) => new ExcelDataTableConfiguration() {
                        }
                    });

                    DataTableCollection table = result.Tables;
                    // load current month
                    int month = currentDay.Month;
                    DataTable currentMonthSheet = table[1];  // used for productCode = 5
                    Boolean continueProcessing = true;
                    if (ms.ProductCode == "2" || ms.ProductCode == "3") {
                        currentMonthSheet = table[month];
                        int year = int.Parse(currentMonthSheet.Rows[1][0].ToString());
                        if (year != currentDay.Year) continueProcessing = false;// don't retrieve if not matching
                    }
                    if (continueProcessing) {
                        for (int day = 1; day <= currentDay.Day; day++) {
                            GetProductionRecord(currentDay, currentMonthSheet, ms, new DateTime(currentDay.Year, month, day));
                        }
                    }

                    // load prior month as well
                    continueProcessing = true;
                    if (currentDay.Day <= 10) {
                        DateTime processingDay = currentDay.AddMonths(-1);
                        month = processingDay.Month;
                        currentMonthSheet = table[1];
                        if (ms.ProductCode == "2" || ms.ProductCode == "3") {
                            currentMonthSheet = table[month];
                            int year = int.Parse(currentMonthSheet.Rows[1][0].ToString());
                            if (year != processingDay.Year) continueProcessing = false;// don't retrieve if not matching
                        }
                        if (continueProcessing) {
                            for (int day = 1; day <= DateTime.DaysInMonth(processingDay.Year, month); day++) {
                                GetProductionRecord(currentDay, currentMonthSheet, ms, new DateTime(processingDay.Year, month, day));
                            }
                        }
                    }
                    return ms;
                }
            }
        }

        private void GetProductionRecord(DateTime currentDay, DataTable currentMonth, MontrealSulphurFile ms, DateTime day) {
            decimal production = 0, opening = 0, closing = 0, shipment = 0, receipt = 0;
            try {
                if (ms.ProductCode == "2") {
                    production = MontrealSulphurFile.ParseDecimal(currentMonth.Rows[day.Day + 5][16].ToString(), "Production"); // column Q
                    opening = MontrealSulphurFile.ParseDecimal(currentMonth.Rows[day.Day + 4][2].ToString(), "Tank T-651") +
                            MontrealSulphurFile.ParseDecimal(currentMonth.Rows[day.Day + 4][5].ToString(), "Tank T-652") +
                            MontrealSulphurFile.ParseDecimal(currentMonth.Rows[day.Day + 4][8].ToString(), "Tank T-653") +
                            MontrealSulphurFile.ParseDecimal(currentMonth.Rows[day.Day + 4][11].ToString(), "Tank T-654"); // column C & F & I & M
                    closing = MontrealSulphurFile.ParseDecimal(currentMonth.Rows[day.Day + 5][2].ToString(), "Tank T-651") +
                            MontrealSulphurFile.ParseDecimal(currentMonth.Rows[day.Day + 5][5].ToString(), "Tank T-652") +
                            MontrealSulphurFile.ParseDecimal(currentMonth.Rows[day.Day + 5][8].ToString(), "Tank T-653") +
                            MontrealSulphurFile.ParseDecimal(currentMonth.Rows[day.Day + 5][11].ToString(), "Tank T-654"); // column C & F & I & M
                    shipment = MontrealSulphurFile.ParseDecimal(currentMonth.Rows[day.Day + 5][14].ToString(), "Shipment"); // column O
                }
                if (ms.ProductCode == "3") {
                    production = MontrealSulphurFile.ParseDecimal(currentMonth.Rows[day.Day + 5][11].ToString(),"Production"); // column L
                    opening = MontrealSulphurFile.ParseDecimal(currentMonth.Rows[day.Day + 4][12].ToString(),"Opening"); // column M
                    closing = MontrealSulphurFile.ParseDecimal(currentMonth.Rows[day.Day + 5][12].ToString(),"Closing"); // column M
                    receipt = MontrealSulphurFile.ParseDecimal(currentMonth.Rows[day.Day + 5][10].ToString(),"Receipt"); // column K
                    shipment = MontrealSulphurFile.ParseDecimal(currentMonth.Rows[day.Day + 5][9].ToString(),"Shipment"); // column J
                }
                if (ms.ProductCode == "5") {
                    int row = FindRowInCaustic(ms, currentMonth, day);
                    if (row == 0) return; // not found
                    production = MontrealSulphurFile.ParseDecimal(currentMonth.Rows[row][8].ToString(), "Production") * -1; // column I 
                    opening = MontrealSulphurFile.ParseDecimal(currentMonth.Rows[row-1][7].ToString(), "Opening"); // column H 
                    closing = MontrealSulphurFile.ParseDecimal(currentMonth.Rows[row][7].ToString(), "Closing"); // column H 
                    receipt = MontrealSulphurFile.ParseDecimal(currentMonth.Rows[row][3].ToString(), "Receipt"); // column D 
                }
            } catch (Exception ex) {
                 throw new Exception("invalid format for montreal sulphur");
            }
            ms.AddTagBalance(currentDay, "MTL SP", "Production", ms.ProductCode, null, day, production, opening, closing, shipment, receipt, null);
        }

        private int FindRowInCaustic(MontrealSulphurFile ms, DataTable dt, DateTime day) {
            // find matching date in B column
            string currentDate = null;
            for (int row = 1; row < dt.Rows.Count; row++) {
                currentDate = dt.Rows[row][1].ToString().ToLower();
                DateTime dateValue;
                Boolean isDate = DateTime.TryParse(currentDate, out dateValue);
                if (isDate && dateValue == day)
                    return row;

            }
            return 0;
        }
    }
}
