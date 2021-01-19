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
        // this part will help you to open the connection
        public static SqlConnection OpenConnection() {
            SqlConnection connection = new SqlConnection(ConnectionString);
            connection.Open();
            return connection;
        }

        private static string ConnectionString { get; set; }

        //add the connectionString to options

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder) {
            if (!optionsBuilder.IsConfigured) {
                optionsBuilder.UseSqlServer(ConnectionString);
            }
        }
    }
}
