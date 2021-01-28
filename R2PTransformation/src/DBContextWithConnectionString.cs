using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using R2PTransformation.src.db;
using System;
using System.Collections.Generic;
using System.Text;

namespace R2PTransformation.src {
    public class DBContextWithConnectionString : MyDbContext {
        public static void SetConnectionString(string connectionString) {
            ConnectionString = connectionString;
        }

        public Boolean DoesConnectionStringExist { get { return !string.IsNullOrEmpty(ConnectionString); } }

        private static string ConnectionString { get; set; }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder) {
            if (!optionsBuilder.IsConfigured && !String.IsNullOrEmpty(ConnectionString)) {
                optionsBuilder.UseSqlServer(ConnectionString);
            }
        }
    }
}
