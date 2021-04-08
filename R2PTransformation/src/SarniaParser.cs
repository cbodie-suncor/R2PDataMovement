using System;
using System.Collections.Generic;
using System.Text;
using R2PTransformation.Models;
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

        public static List<ShellSplit> LoadULSDSplits(string fileName) {
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

        public static int UpdateShellSplits(List<ShellSplit> ss, DateTime currentDate) {
            int changes = 0;
            if (ss.Count == 0) return 0;
            List<TagBalance> tbs = AzureModel.GetAllTagBalances().Where(t => t.Plant == "CP03" && t.BalanceDate >= ss.Min(r => r.Day) && t.BalanceDate >= ss.Max(r => r.Day)).ToList();
            foreach (var group in tbs.GroupBy(y => y.BalanceDate)) {
                TagBalance presplit = group.SingleOrDefault(e => e.ValType == "Presplit");
                TagBalance shell = group.SingleOrDefault(e => e.ValType == "Shell");
                TagBalance suncor = group.SingleOrDefault(e => e.ValType == "SUNCOR");
                ShellSplit split = ss.SingleOrDefault(e => e.Day == group.Key);
                if (presplit == null || shell == null || suncor == null || split == null) continue;
                if (shell.Quantity != shell.Quantity) changes++;
                if (suncor.Quantity != (presplit.Quantity - shell.Quantity)) changes++;
                shell.Quantity = shell.Quantity;
                suncor.Quantity = presplit.Quantity - shell.Quantity;
            }
            if (changes> 0) {
                AzureModel.SaveTagBalance(tbs);
                var file = new SuncorProductionFile("CP03", null);
                file.Products = tbs;
                file.ExportProductionJson();
            }
            return changes;
        }

        public static void ApplyShellSplits(SuncorProductionFile pf, List<ShellSplit> splits) {
            List<TagBalance> additionalItems = new List<TagBalance>();
            foreach (var presplit in pf.Products) {
                ShellSplit shell = splits.FirstOrDefault(t => t.Day == presplit.BalanceDate && t.ProductCode == presplit.Tag);
                if (shell == null && splits.Where(y=>y.ProductCode == presplit.Tag).Count() > 0) {
                    pf.Warnings.Add(new WarningMessage(MessageType.Error, presplit.Tag, "No matching ULSD record was for " + presplit.BalanceDate.ToString("yyyy-MM-dd")));
                    continue;
                }

                TagBalance suncorTB = CloneTag(presplit);
                suncorTB.ValType = presplit.ValType;  // Suncor valType comes from the TagMap table, which always should be SUNCOR
                suncorTB.Quantity = presplit.Quantity - shell.Volume;
                additionalItems.Add(suncorTB);

                presplit.ValType = "Presplit";

                TagBalance shellTB = CloneTag(presplit);
                shellTB.ValType = "Shell";
                shellTB.Quantity = shell.Volume;
                additionalItems.Add(shellTB);
            }
            pf.Products.AddRange(additionalItems);
        }

        private static TagBalance CloneTag(TagBalance item) {
            TagBalance newItem = new TagBalance(){ Tag = item.Tag,
                System = item.System, MovementType = item.MovementType, Material = item.Material,
                Plant = item.Plant, WorkCenter = item.WorkCenter, ValType = item.ValType, 
                BalanceDate = item.BalanceDate, Quantity = item.Quantity,
                StandardUnit = item.StandardUnit, BatchId = item.BatchId, LastUpdated = item.LastUpdated, CreatedBy = item.CreatedBy,
                OpeningInventory = item.OpeningInventory, ClosingInventory = item.ClosingInventory, Shipment = item.Shipment,
                Consumption = item.Consumption, Receipt = item.Receipt
            };
            return newItem;
        }
    }
}
