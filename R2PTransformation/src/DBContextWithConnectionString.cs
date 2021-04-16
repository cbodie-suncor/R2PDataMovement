using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using R2PTransformation.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Text;

namespace R2PTransformation.Models {
    public class DBContextWithConnectionString : AzureContext {
        // The DBContext is created by EF, run the following command to rebuild
        // run from the Package Manager Console, cd C:\suncor\R2PDataMovement\R2PTransformation 1st 
        // dotnet ef dbcontext scaffold "Data Source=inmdevarmsvruw2001.database.windows.net;Initial Catalog=inmdevarmsqluw2001;User ID=suncorsqladmin;password=AdvancedAnalytics2020" Microsoft.EntityFrameworkCore.SqlServer -o Model -c "AzureContext" --no-build --force

        public static void SetConnectionString(string connectionString) {
            ConnectionString = connectionString;
        }

        public Boolean DoesConnectionStringExist { get { return !string.IsNullOrEmpty(ConnectionString); } }

        public static string ConnectionString { get; set; }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder) {
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
