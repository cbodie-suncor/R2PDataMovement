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
        public SigmafineFile LoadExcel(string fileName, string plant) {
            Encoding.RegisterProvider(CodePagesEncodingProvider.Instance);
            SigmafineFile ms = new SigmafineFile(plant); // either GP01 or GP02
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
                            production = Math.Round(SigmafineFile.ParseDecimal(productionStringValue),0);
                            if (production == 0) continue;
                        } catch (Exception ex) {
                        }
                        TagBalance tb = ms.GetNewTagBalance("Sigmafine", product, day, production);
                        if (tb != null) ms.Products.Add(tb);
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

        [Obsolete]
        public SigmafineFile Load(string fileName, string plant, DateTime dateTime) {
            SigmafineFile ms = new SigmafineFile(plant); // either GP01 or GP02
            List<Sigmafinex> sigmafineRecords = null;
            if (fileName != null) {
                string fileContents = File.ReadAllText(fileName);
                DataTable dt = Utilities.ConvertCSVTexttoDataTable(fileContents);
                sigmafineRecords = AzureModel.TransformToSigmafinex(dt);
                AzureModel.PersistSigmafinex(sigmafineRecords);
            } else {
                sigmafineRecords = AzureModel.GetCommerceCity();
            }
            sigmafineRecords = sigmafineRecords.Where(i => (i.FlowCc == "West_Plt" && plant == "GP01") || (i.FlowCc == "East_Plt" && plant == "GP02")).ToList();
            List<SigmaTransformedResult> transformedRecords = TransformRows(sigmafineRecords);

            foreach (var item in transformedRecords) {
                var production = ms.GetNewTagBalance("Sigmafine", item.Product, item.Day, item.Production);
                if (production != null) ms.Products.Add(production);
            }
            return ms;
        }

        private static List<SigmaTransformedResult> TransformRows(List<Sigmafinex> items) {
            return items.GroupBy(t => new { StartTime = t.StartTime.Value, Plant = t.FlowCc, t.Product, t.ProductDesc }).Select(y => new SigmaTransformedResult(
                        y.Key.StartTime,
                        y.Key.Plant,
                        y.Key.Product,
                        y.Key.ProductDesc,
                        y.Sum(x => x.OpenFlag == "Y" || x.CloseFlag == "Y" ? x.TankOpenVol ?? 0 : 0),
                        y.Sum(x => x.OpenFlag == "Y" || x.CloseFlag == "Y" ? x.TankCloseVol ?? 0 : 0),
                        y.Sum(x => x.FlowType == "S" ? x.MeasLiqVol.Value : 0),
                        y.Sum(x => x.FlowType == "R" ? x.MeasLiqVol.Value : 0),
                        y.Max(x => x.IsCharge == "Y"))).ToList();
        }
        /*
        public SigmafineFile LoadWest(List<Sigmafinex> overrideRecords = null) {
            Encoding.RegisterProvider(CodePagesEncodingProvider.Instance);
            SigmafineFile ms = new SigmafineFile("GP01");
            foreach (var item in AzureModel.GetCommerceCityWest(overrideRecords)) {
                var production = ms.GetNewTagBalance("Sigmafine", item.Product, item.Day, item.Production);
                if (production != null) ms.Products.Add(production);
            }
            return ms;
        }

        public SigmafineFile LoadEast(List<Sigmafinex> overrideRecords = null) {
            Encoding.RegisterProvider(CodePagesEncodingProvider.Instance);
            SigmafineFile ms = new SigmafineFile("GP02");
            foreach (var item in AzureModel.GetCommerceCityEast(overrideRecords)) {
                var production = ms.GetNewTagBalance("Sigmafine", item.Product, item.Day, item.Production);
                if (production != null) ms.Products.Add(production);
            }
            return ms;
        }
        
        public decimal CalculateProduction(List<Sigmafinex> items) {
            return 23;

 * select product,productdesc, casevolrec-volship+volopen-volclose product,ischarge
from (
select product,productdesc,
sum(case when openflag = 'Y' or closeflag = 'Y' then TankOpenVol else 0 end) VolOpen,
sum(case when closeflag = 'Y' or closeflag = 'Y' then TankCloseVol else 0 end) VolClose,
sum(case when flowtype = 'S' then MeasLiqVol else 0 end) VolShip,
sum(case when flowtype = 'R' then MeasLiqVol else 0 end) VolRec,
ischarge
from dbo.sigmafinex
where 
starttime = '2020-11-07'-- and product = 'E_CR820H'
group by product,productdesc,ischarge
) r
order by 2
*/
    }
}
