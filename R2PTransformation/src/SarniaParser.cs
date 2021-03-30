using System;
using System.Collections.Generic;
using System.Text;
using R2PTransformation.src.db;
using System.Linq;
using System.IO;
using System.Data;
using ExcelDataReader;

namespace R2PTransformation.src {
    public class SarniaParser {

        public class ShellSplit {
            public String ProductCode;
            public DateTime Day;
            public decimal Volume;

            public ShellSplit(DateTime day, string product, decimal volume) {
                this.Day = day;
                this.ProductCode = product;
                Volume = volume;
            }
        }

        public static List<ShellSplit> LoadULSDSplits(string fileName, DateTime currentDay) {
            List<ShellSplit> splits = new List<ShellSplit>();
            Encoding.RegisterProvider(CodePagesEncodingProvider.Instance);
            List<String> productCodes = GetProductCodes(fileName);
            //            SuncorProductionFile ms = new SuncorProductionFile(plant, fileName); // either GP01 or GP02
            using (var stream = File.Open(fileName, FileMode.Open, FileAccess.Read)) {
                using (var reader = ExcelReaderFactory.CreateReader(stream)) {
                    var result = reader.AsDataSet(new ExcelDataSetConfiguration() {
                        ConfigureDataTable = (data) => new ExcelDataTableConfiguration() {
                            UseHeaderRow = true,
                            ReadHeaderRow = rowReader => {
                                for(int i=0;i<18;i++) { rowReader.Read(); }
                            }
                        }
                    });
                    DataTableCollection table = result.Tables;
                    DataTable currentDaySheet = table["Production"];
                    decimal volume = 0;
                    foreach (DataRow row in currentDaySheet.AsEnumerable()) {
                        DateTime? day = row[1] as DateTime?;
                        if (day == null && row[1] is double) {
                            day = DateTime.FromOADate((double)row[1]);
                        }
                        if (day == null || day < new DateTime(2000,1,1)) continue;

                        for(int i=0;i<productCodes.Count;i++) {
                            string volumeStringValue = row[i+2].ToString();
                            try {
                                volume = Math.Round(SuncorProductionFile.ParseDecimal(volumeStringValue, "Volume for " + productCodes[i]), 3);
                            } catch (Exception ex) {
//                                ms.Warnings.Add(new WarningMessage(tank, ex.Message));
                                continue;
                            }
                            splits.Add(new ShellSplit(day.Value, productCodes[i], volume));

                        }
                    }
                }
            }

            return splits;
        }

        private static List<String> GetProductCodes(string fileName) {
            List<String> products = new List<String>();
            int row = 6;
            using (var stream = File.Open(fileName, FileMode.Open, FileAccess.Read)) {
                using (var reader = ExcelReaderFactory.CreateReader(stream)) {
                    var result = reader.AsDataSet(new ExcelDataSetConfiguration() {
                        ConfigureDataTable = (data) => new ExcelDataTableConfiguration() {
                        }
                    });

                    DataTableCollection table = result.Tables;
                    DataTable currentDaySheet = table["Production"];  // used for productCode = 5
                    DateTime time = DateTime.MinValue;
                    int column = 2;
                    while (true) {
                        string productString = currentDaySheet.Rows[row][column].ToString();
                        if (String.IsNullOrEmpty(productString)) break;
                        products.Add(productString);
                        column++;
                    }
                }
            }
            return products;
        }

        public static void ModifyAndAddShellSplits(SuncorProductionFile pf, List<ShellSplit> splits) {
            List<TagBalance> additionalItems = new List<TagBalance>();
            foreach (var item in pf.Products) {
                ShellSplit shell = splits.FirstOrDefault(t => t.Day == item.BalanceDate && t.ProductCode == item.Tag);
                if (shell == null && splits.Where(y=>y.ProductCode == item.Tag).Count() > 0) {
                    pf.Warnings.Add(new WarningMessage(MessageType.Error, item.Tag, "No matching ULSD record was for " + item.BalanceDate.ToString("yyyy-MM-dd")));
                    continue;
                }

/*                if (shell.Volume > item.Quantity) {
                    pf.Warnings.Add(new WarningMessage(item.Tag, "Shell split is greater than AMMDT Quantity for " + item.BalanceDate.ToString("yyyy-MM-dd")));
                    continue;
                }
*/
                TagBalance suncorTB = CloneTag(item);
                suncorTB.ValType = item.ValType;  // Suncor valType comes from the TagMap table
                suncorTB.Quantity = item.Quantity - shell.Volume;
                additionalItems.Add(suncorTB);

                item.ValType = "Presplit";

                TagBalance shellTB = CloneTag(item);
                shellTB.ValType = "Shell";
                shellTB.Quantity = shell.Volume;
                additionalItems.Add(shellTB);
            }
            pf.Products.AddRange(additionalItems);
        }

        private static TagBalance CloneTag(TagBalance item) {
            TagBalance newItem = new TagBalance(){ Tag = item.Tag,
                System = item.System, MovementType = item.MovementType, Material = item.Material,
                Plant = item.Plant, WorkCenter = item.WorkCenter, ValType = item.ValType, Tank = item.Tank,
                QuantityTimestamp = item.QuantityTimestamp, BalanceDate = item.BalanceDate, Quantity = item.Quantity,
                StandardUnit = item.StandardUnit, BatchId = item.BatchId, Created = item.Created, CreatedBy = item.CreatedBy,
                OpeningInventory = item.OpeningInventory, ClosingInventory = item.ClosingInventory, Shipment = item.Shipment,
                Consumption = item.Consumption, Receipt = item.Receipt, Confidence = item.Confidence
            };
            return newItem;
        }
    }
}
