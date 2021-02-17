using Microsoft.Extensions.Configuration;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Text;

namespace R2PTransformation.src {
    public class Utilities {
        public static DataTable ConvertCSVFiletoDataTable(string strFilePath) {
            DataTable dt = new DataTable();
            using (StreamReader sr = new StreamReader(strFilePath)) {
                string[] headers = sr.ReadLine().Split(',');
                foreach (string header in headers) {
                    dt.Columns.Add(header);
                }
                while (!sr.EndOfStream) {
                    string line = sr.ReadLine();
                    if (string.IsNullOrEmpty(line)) continue;
                    string[] rows = line.Split(',');
                    DataRow dr = dt.NewRow();
                    for (int i = 0; i < headers.Length; i++) {
                        dr[i] = rows[i];
                    }
                    dt.Rows.Add(dr);
                }
            }
            return dt;
        }

        public static DataTable ConvertTerraNovaCSVTexttoDataTable(string txt) {
            DataTable dt = new DataTable();
            string[] lines = txt.Split("\r\n");
            if (lines.Length < 2) return null;

            string[] headers = lines[0].Split(' ', StringSplitOptions.RemoveEmptyEntries);
            foreach (string header in headers) {
                dt.Columns.Add(header.Trim());
            }
            for (int z = 2; z < lines.Length; z++) {
                string line = lines[z];
                if (string.IsNullOrEmpty(line)) continue;
                string[] rows = line.Split(',');
                DataRow dr = dt.NewRow();
                for (int i = 0; i < headers.Length; i++) {
                    dr[i] = rows[i].Trim();
                }
                dt.Rows.Add(dr);
            }
            return dt;
        }

        public static DataTable ConvertCSVTexttoDataTable(string txt) {
            DataTable dt = new DataTable();
            string[] lines = txt.Split("\r\n");
            if (lines.Length < 2) return null;

            string[] headers = lines[0].Split(',');
            foreach (string header in headers) {
                dt.Columns.Add(header);
            }
            for (int z = 1; z < lines.Length; z++) {
                string line = lines[z];
                if (string.IsNullOrEmpty(line)) continue;
                string[] rows = line.Split(',');
                DataRow dr = dt.NewRow();
                for (int i = 0; i < headers.Length; i++) {
                    dr[i] = rows[i];
                }
                dt.Rows.Add(dr);
            }
            return dt;
        }

        // retrieves the ENV variable from the JSON file local.settings.json or from the configuraton file in Azure
        public static string GetEnvironmentVariable(string name) {
            return System.Environment.GetEnvironmentVariable(name, EnvironmentVariableTarget.Process);
        }
    }
}
