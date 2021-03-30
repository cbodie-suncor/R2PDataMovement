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

        public SuncorProductionFile LoadFile(string fileName, string plant, DateTime currentDay) {
            Filename = fileName;

            Encoding.RegisterProvider(CodePagesEncodingProvider.Instance);
            SuncorProductionFile ms = new SuncorProductionFile(plant, fileName);
            ms.IsCurrentDay(currentDay);
            string fileContents = File.ReadAllText(fileName);
            DataTable dt = Utilities.ConvertTerraNovaCSVTexttoDataTable(fileContents);

            // load current month
            DataTable currentMonthSheet = dt;
            LoadProductionRecords(currentMonthSheet, ms, currentDay);
            return ms;
        }

        private void LoadProductionRecords(DataTable currentMonth, SuncorProductionFile ms, DateTime currentDay) {
            foreach (var row in currentMonth.AsEnumerable()) {
                string productionCode = row["name"].ToString();
                DateTime day;
                decimal quantity = 0;
                try {
                    day = DateTime.ParseExact(row["ts"].ToString().Substring(0, 9), "dd-MMM-yy", CultureInfo.InvariantCulture);
                    quantity = SuncorProductionFile.ParseDecimal(row["value"].ToString(), "Production");
                } catch (Exception ex) {
                    ms.Warnings.Add(new WarningMessage(MessageType.Error, productionCode, ex.Message));
                    continue;
                }

                ms.AddTagBalance(currentDay, "OPIS", "Production", productionCode, null, day.AddDays(-1), quantity, null, null, null, null, null);
            }
        }
    }
}
