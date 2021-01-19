using System;
using System.Collections.Generic;
using System.Text;
using R2PTransformation.src.db;
using System.Linq;
using System.IO;
using System.Data;

namespace R2PTransformation.src {
    public class SigmafineParser {
        public SigmafineFile Load(string fileContents, string plant, DateTime dateTime) {
            SigmafineFile ms = new SigmafineFile(plant); // either GP01 or GP02
            List<Sigmafinex> sigmafineRecords = null;
            if (fileContents != null) {
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
