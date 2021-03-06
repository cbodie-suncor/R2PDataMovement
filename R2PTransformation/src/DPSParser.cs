﻿using System;
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
            ms.IsCurrentDay(currentDay);
            using (var stream = File.Open(fileName, FileMode.Open, FileAccess.Read)) {
                using (var reader = ExcelReaderFactory.CreateReader(stream)) {
                    var result = reader.AsDataSet(new ExcelDataSetConfiguration() {
                        ConfigureDataTable = (data) => new ExcelDataTableConfiguration() {
                            UseHeaderRow = true
                        }
                    });

                    DataTableCollection table = result.Tables;
                    DataTable currentMonthSheet = table[0];
                    LoadProductionRecords(currentMonthSheet, ms, currentDay);
                    return ms;
                }
            }
        }

        public void LoadProductionRecords(DataTable currentMonth, DPSFile ms, DateTime currentDay) {
            foreach (var row in currentMonth.AsEnumerable()) {
                string productionCode = row["Plant"].ToString() + "_" + row["Material Description OR Product Code in DPS"].ToString();
                string uom = row["Display Unit of Measure"].ToString();
                DateTime? day = row["transaction date"] as DateTime?;
        
                decimal quantity = DPSFile.ParseDecimal(row["production"].ToString());
                try {
                    quantity = AzureModel.ConvertQuantityToStandardUnit(uom, quantity);
                } catch(Exception ex) {
                    ms.Warnings.Add(new WarningMessage(productionCode, ex.Message));
                    continue;
                }
                ms.AddTagBalance(currentDay, "DPS", productionCode, day.Value, quantity);
            }
        }
    }
}
