using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Text;
using ExcelDataReader;
using R2PTransformation.src.db;

namespace R2PTransformation.src {
    public class MontrealSulphurParser {
        private string Filename = "";

        public MontrealSulphurFile LoadFile(string fileName, string plant, string productCode, DateTime currentDay) {
            Filename = fileName;

            Encoding.RegisterProvider(CodePagesEncodingProvider.Instance);
            MontrealSulphurFile ms = new MontrealSulphurFile(fileName, plant, productCode);
            using (var stream = File.Open(fileName, FileMode.Open, FileAccess.Read)) {
                using (var reader = ExcelReaderFactory.CreateReader(stream)) {
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
                            var item = GetProductionRecord(currentMonthSheet, ms, new DateTime(currentDay.Year, month, day));
                            if(item != null) ms.Products.Add(item);
                        }
                    }

                    // load prior month as well
                    continueProcessing = true;
                    if (currentDay.Day <= 10) {
                        currentDay = currentDay.AddMonths(-1);
                        month = currentDay.Month;
                        currentMonthSheet = table[1];
                        if (ms.ProductCode == "2" || ms.ProductCode == "3") {
                            currentMonthSheet = table[month];
                            int year = int.Parse(currentMonthSheet.Rows[1][0].ToString());
                            if (year != currentDay.Year) continueProcessing = false;// don't retrieve if not matching
                        }
                        if (continueProcessing) {
                            for (int day = 1; day <= DateTime.DaysInMonth(currentDay.Year, month); day++) {
                                var item = GetProductionRecord(currentMonthSheet, ms, new DateTime(currentDay.Year, month, day));
                                if (item != null) ms.Products.Add(item);
                            }
                        }
                    }
                    return ms;
                }
            }
        }

        private TagBalance GetProductionRecord(DataTable currentMonth, MontrealSulphurFile ms, DateTime day) {
            decimal quantity = 0;
            try { 
                if (ms.ProductCode == "2") quantity = MontrealSulphurFile.ParseDecimal(currentMonth.Rows[day.Day + 5][16].ToString()); // column Q
                if (ms.ProductCode == "3") quantity = MontrealSulphurFile.ParseDecimal(currentMonth.Rows[day.Day + 5][11].ToString()); // column L
                if (ms.ProductCode == "5") quantity = MontrealSulphurFile.ParseDecimal(currentMonth.Rows[FindRowInCaustic(ms, currentMonth, day)][8].ToString()) * -1; // column I for Caustic
            } catch (Exception ex) {
                 throw new Exception("invalid format for montreal sulphur");
            }
            if (quantity == 0) return null;
            return ms.GetNewTagBalance("MTL SP", ms.ProductCode, day, quantity);
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
