using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using System;
using System.Data;

namespace R2PTransformation.Models {

    public class DBContextWithConnectionString : AzureContext {
        // The DBContext is created by EF, run the following command to rebuild
        //
        // run from the Package Manager Console, cd C:\suncor\R2PDataMovement\R2PTransformation 
        // dotnet ef dbcontext scaffold "Data Source=inmdevarmsvruw2001.database.windows.net;Initial Catalog=inmdevarmsqluw2001;User ID=suncorsqladmin;password=AdvancedAnalytics2020" Microsoft.EntityFrameworkCore.SqlServer -o Models -c "AzureContext" --no-build --force

        public static void SetConnectionString(string connectionString) {
            ConnectionString = connectionString;
        }

        private static DbContextOptions<AzureContext> Options;

        public static DBContextWithConnectionString Create() {
            if (Options != null) return new DBContextWithConnectionString(Options);  // handes the TestContext
            return new DBContextWithConnectionString();
        }

        public static DBContextWithConnectionString CreateTestContext() {
            DBContextWithConnectionString context = null;
            if (Options != null && 1==0) {  // potentially could have the same context for all tests, or teardown for all tests
                context = new DBContextWithConnectionString(Options);
            } else {
                Options = new DbContextOptionsBuilder<AzureContext>()
                   .UseInMemoryDatabase(databaseName: "MovieListDatabase")
                   .Options;
                context = new DBContextWithConnectionString(Options);
                DBContextWithConnectionString.AddTestData(context);
            }
            return context;
        }

        private DBContextWithConnectionString() : base()  {}
        
        private DBContextWithConnectionString(DbContextOptions<AzureContext> options) : base(options) {
        }

        public Boolean DoesConnectionStringExist { get { return !string.IsNullOrEmpty(ConnectionString); } }

        public static string ConnectionString { get; set; }

        public static void AddTestData(AzureContext context) {
            context.Conversion.RemoveRange(context.Conversion);
            context.SaveChanges();

            context.TagMap.RemoveRange(context.TagMap);
            context.SaveChanges();

            context.StandardUnit.RemoveRange(context.StandardUnit);
            context.SaveChanges();

            var testConversion1 = new Conversion {
                StandardUnit = "BBL",
                ToUnit = "M3",
                Material = "3",
                Factor = 2
            };

            context.Conversion.Add(testConversion1);
            context.SaveChanges();

            context.StandardUnit.Add(new StandardUnit { Name = "BBL" });
            context.StandardUnit.Add(new StandardUnit { Name = "M3" });
            context.TagMap.Add(new TagMap { Tag = "ASPH_SOUR", Plant = "GP01", Type = "Inv", DefaultValuationType = "SUNCOR",  MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "Asphalt Unit Crude", Plant = "GP02", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "EP Sweet Crude Trucks", Plant = "GP01", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });

            context.TagMap.Add(new TagMap { Tag = "Upgrader_Diluted Bitumen", Plant = "AP01", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });

            context.TagMap.Add(new TagMap { Tag = "Firebag_Bitumen_SU", Plant = "AP02", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "Firebag_Diluent", Plant = "AP02", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "Kerosene", Plant = "AP02", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "Firebag_Intermediate Kerosene", Plant = "AP02", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });

            context.TagMap.Add(new TagMap { Tag = "Mackay River_Bitumen_SU", Plant = "AP03", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "Mackay River_Crude Oil - OSA", Plant = "AP03", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });

            context.TagMap.Add(new TagMap { Tag = "Mackay River_Crude Oil - OSB", Plant = "AP03", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "Mackay River_Crude Oil - OSN", Plant = "AP03", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "Mackay River_Diluent", Plant = "AP03", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });

            context.TagMap.Add(new TagMap { Tag = "Mackay River_Light Vacuum Gas Oil (LVGO)", Plant = "AP03", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            //            context.TagMap.Add(new TagMap { Tag = "Mackay River_Light Vacuum Gas Oil (LVGO)", Plant = "AP03", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });

            context.TagMap.Add(new TagMap { Tag = "RBOB", Plant = "CP03", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "DIESEL", Plant = "CP03", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });

            context.TagMap.Add(new TagMap { Tag = "2", Plant = "CP02", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "3", Plant = "CP02", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "5", Plant = "CP02", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });

            context.TagMap.Add(new TagMap { Tag = "BCNRL", Plant = "CP04", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "BSUNCOR", Plant = "CP04", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "BSUNOSP", Plant = "CP04", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "BSYNCR", Plant = "CP04", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "D50", Plant = "CP04", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "HSR", Plant = "CP04", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "JETA", Plant = "CP04", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "STOM", Plant = "CP04", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "FCOMFG", Plant = "CP04", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "FNGAS", Plant = "CP04", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "PEFLGNF", Plant = "CP04", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "C5C6", Plant = "CP04", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "DILUENT", Plant = "CP04", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "RBOB", Plant = "CP04", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "RGUA", Plant = "CP04", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "RGUB", Plant = "CP04", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "RGUM", Plant = "CP04", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "SBOB", Plant = "CP04", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "SUPB", Plant = "CP04", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "AIRP_H2", Plant = "CP04", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "FBUT", Plant = "CP04", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "SLOP", Plant = "CP04", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "B806", Plant = "CP04", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "ECCOKE", Plant = "CP04", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "PROP", Plant = "CP04", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "PROS", Plant = "CP04", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "SULP_MKT", Plant = "CP04", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "COKF", Plant = "CP04", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "EDDF", Plant = "CP04", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "FCCF", Plant = "CP04", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "IBUT", Plant = "CP04", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "NBUT", Plant = "CP04", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "REFF", Plant = "CP04", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "RSLOP", Plant = "CP04", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "MGO", Plant = "CP04", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "HIOCT", Plant = "CP04", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "R100", Plant = "CP04", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "C-0", Plant = "CP04", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.SaveChanges();

            context.TagMap.Add(new TagMap { Tag = "14BUT_CONS", Plant = "CP01", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "14GZ_COMB_RAFFR", Plant = "CP01", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "14GZ_REJ_CONS", Plant = "CP01", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "14PROP_CONS", Plant = "CP01", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "48AMNIAC_CONS", Plant = "CP01", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "14GAZ_NAT", Plant = "CP01", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "02COKE_CONS", Plant = "CP01", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "14MAZ_RAFF_CONS", Plant = "CP01", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "26GZ_TRCH_CONS", Plant = "CP01", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "BRUT_AMNA", Plant = "CP01", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "BRUT_ASGARD", Plant = "CP01", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "BRUT_AZERI", Plant = "CP01", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "BRUT_BAKKEN_NDS_RAIL", Plant = "CP01", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "BRUT_BAKKEN_UHC_L9", Plant = "CP01", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "BRUT_BRASS-RIVER", Plant = "CP01", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "BRUT_BRENT", Plant = "CP01", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "BRUT_DRAGEN", Plant = "CP01", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "BRUT_DUC", Plant = "CP01", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "BRUT_EAGLE_FORD", Plant = "CP01", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "BRUT_EKOFISK", Plant = "CP01", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "BRUT_FLOTTA", Plant = "CP01", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "BRUT_FORTIES", Plant = "CP01", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "BRUT_GALEOTA", Plant = "CP01", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "BRUT_GIRASSOL", Plant = "CP01", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "BRUT_GULFAKS", Plant = "CP01", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "BRUT_HIBERNIA", Plant = "CP01", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.SaveChanges();

            context.TagMap.Add(new TagMap { Tag = "BRUT_HSC", Plant = "CP01", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "BRUT_ISTHMUS", Plant = "CP01", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "BRUT_LLS", Plant = "CP01", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "BRUT_LSB", Plant = "CP01", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "BRUT_MELLITAH", Plant = "CP01", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "BRUT_MESA", Plant = "CP01", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "BRUT_MSB", Plant = "CP01", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "BRUT_MST", Plant = "CP01", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "BRUT_MSW", Plant = "CP01", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "BRUT_OLMECA", Plant = "CP01", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "BRUT_OSC", Plant = "CP01", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "BRUT_OSEBERG", Plant = "CP01", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "BRUT_PSY", Plant = "CP01", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "BRUT_SAHARAN", Plant = "CP01", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "BRUT_SANTA-BARBARA", Plant = "CP01", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "BRUT_SAXI_BATUQUE", Plant = "CP01", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "BRUT_SSX", Plant = "CP01", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "BRUT_STATFJORD", Plant = "CP01", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "BRUT_SYN", Plant = "CP01", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "BRUT_SYR_LE", Plant = "CP01", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "BRUT_TERRA-NOVA", Plant = "CP01", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "BRUT_TH90", Plant = "CP01", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "BRUT_TH95", Plant = "CP01", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "BRUT_TROLL", Plant = "CP01", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "BRUT_URAL", Plant = "CP01", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.SaveChanges();

            context.TagMap.Add(new TagMap { Tag = "BRUT_WTI", Plant = "CP01", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "BRUT_ZARZAITINE", Plant = "CP01", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "BRUT_BCF-22", Plant = "CP01", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "BRUT_BHB", Plant = "CP01", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "BRUT_COLD_LAKE", Plant = "CP01", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "BRUT_IST-MAYA_10-90", Plant = "CP01", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "BRUT_IST-MAYA_15-85", Plant = "CP01", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "BRUT_IST-MAYA_20-80", Plant = "CP01", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "BRUT_IST-MAYA_25-75", Plant = "CP01", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "BRUT_IST-MAYA_30-70", Plant = "CP01", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "BRUT_IST-MAYA_40-60", Plant = "CP01", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "BRUT_IST-MAYA_50-50", Plant = "CP01", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "BRUT_MENEMOTA", Plant = "CP01", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "BRUT_OLM-MAYA_20-80", Plant = "CP01", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "BRUT_OLM-MAYA_30-70", Plant = "CP01", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "BRUT_SYR_LO", Plant = "CP01", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "BRUT_WCS", Plant = "CP01", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "BEN_TOL_MIX", Plant = "CP01", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "HUILE_FOOTES", Plant = "CP01", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "IMP_GAZOLE", Plant = "CP01", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "IMP_GAZOLE_LUBES", Plant = "CP01", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "IMP_RES_ATM", Plant = "CP01", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "REJET_ALIM", Plant = "CP01", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "05ESS_LE_HT", Plant = "CP01", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "05ESS_LO_HT", Plant = "CP01", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });

            context.TagMap.Add(new TagMap { Tag = "43DIS_LE", Plant = "CP01", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "ALKYLAT", Plant = "CP01", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "BASE_ESS_REGUL", Plant = "CP01", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "BASE_ESS_SUPER", Plant = "CP01", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "C9AROM", Plant = "CP01", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "IMP_PLATFRM", Plant = "CP01", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "RAFFINAT", Plant = "CP01", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "RBOB_10", Plant = "CP01", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "SUPER", Plant = "CP01", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "BENZENE", Plant = "CP01", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "NONENES", Plant = "CP01", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "TOLUENE_NITRATION", Plant = "CP01", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "XYLENES", Plant = "CP01", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "DIESEL_1_FTS", Plant = "CP01", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "DIESEL_MARIN", Plant = "CP01", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "DIESEL_RENOUV", Plant = "CP01", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "DIESEL_SAISN_FTS", Plant = "CP01", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "DIESEL_SAISN_HTS", Plant = "CP01", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "MANUF_SOLV_LCO", Plant = "CP01", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "MAZOUT_LE-2", Plant = "CP01", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "MAZOUT_LE_1", Plant = "CP01", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "02BOUL_B-L", Plant = "CP01", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "14MAZ_RAFFR", Plant = "CP01", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "MAZOUT_LO_6C_1", Plant = "CP01", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "MAZOUT_LO_6C_1.5", Plant = "CP01", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });

            context.TagMap.Add(new TagMap { Tag = "MAZOUT_MARIN", Plant = "CP01", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "38REJT_PARAF_S-V", Plant = "CP01", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "BIT_FLUX_2000", Plant = "CP01", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "BIT_PG52-34", Plant = "CP01", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "BIT_PG58-28", Plant = "CP01", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "BIT_PG64-22", Plant = "CP01", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "BUTANE", Plant = "CP01", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "ISOBUTANE", Plant = "CP01", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "PPMIX", Plant = "CP01", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "PROPANE_HD5", Plant = "CP01", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "PROPANE_NON-ODORISE", Plant = "CP01", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "36TRIM_FND", Plant = "CP01", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "41EXT_ALIM", Plant = "CP01", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "41EXT_EXTRAIT", Plant = "CP01", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "43RES_FRAC", Plant = "CP01", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "51ALIM", Plant = "CP01", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "55ESS_POLY", Plant = "CP01", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "BBMIX", Plant = "CP01", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "GAZOLE", Plant = "CP01", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "GAZOLE_LUB", Plant = "CP01", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "GA_S-V_LE_LUB", Plant = "CP01", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "GA_S-V_LO_LUB", Plant = "CP01", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "ISOBUTANE_STORAGE", Plant = "CP01", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "NAPHTA", Plant = "CP01", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "NAPHTA_LUB", Plant = "CP01", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });

            context.TagMap.Add(new TagMap { Tag = "REJET", Plant = "CP01", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "RES_ATM", Plant = "CP01", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "RES_S-V", Plant = "CP01", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "14GAZ_NAT_CONS", Plant = "CP01", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });

            context.TagMap.Add(new TagMap { Tag = "OIL-STORAGE-CORR-LD", Plant = "EP01", Type = "Prod", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });

            context.TagMap.Add(new TagMap { Tag = "REFF", Plant = "CP04", Type = "Inv", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "BRUT_MSW", Plant = "CP01", Type = "Inv", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "BRUT_LSB", Plant = "CP01", Type = "Inv", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "DB_INV_PA", Plant = "AP01", Type = "Inv", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });
            context.TagMap.Add(new TagMap { Tag = "YT.08WL014.VOLN", Plant = "CP03", Type = "Inv", DefaultValuationType = "SUNCOR", MaterialNumber = "10" });

            context.SaveChanges();
        }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder) {
            /*
            if (!optionsBuilder.IsConfigured && ConnectionString == null) {
                optionsBuilder.UseInMemoryDatabase(databaseName: Guid.NewGuid().ToString());
                //if (Options != null) optionsBuilder.Options;
            }*/

            if (!optionsBuilder.IsConfigured && !String.IsNullOrEmpty(ConnectionString)) {
                optionsBuilder.UseSqlServer(ConnectionString);
            }
        }

        public static void BulkLoadConversion(string cs, DataTable dt) {
            if (dt == null) { throw new ArgumentNullException(nameof(dt)); }

            using (var connection = new SqlConnection(cs)) {
                connection.Open();
                using (var transaction = connection.BeginTransaction()) {
                    using (var sqlBulkCopy = new SqlBulkCopy(connection, SqlBulkCopyOptions.TableLock, transaction)) {
                        sqlBulkCopy.DestinationTableName = dt.TableName;
                        sqlBulkCopy.BatchSize = 10000;
                        sqlBulkCopy.WriteToServer(dt);
                    }
                    transaction.Commit();
                }
            }
            return;
        }
    }
}
