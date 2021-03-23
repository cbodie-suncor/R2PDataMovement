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
            txt = txt.Replace("\r", "");
            string[] lines = txt.Split("\n");
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

        public static string GetHBHistory(string contents, DateTime mdtTime) {
            string hbHistory = "";
            // only use the first 2 lines
            if (!String.IsNullOrEmpty(contents)) {
                contents = contents.Replace("\r", "");
                string nextHB = contents.Split('\n')[0].Replace("Next Heartbeat:", "");
                string lastHB = contents.Split('\n')[1].Replace("Last Heartbeat:", ""); ;
                if (contents.IndexOfNth("\n", 3) > 0) hbHistory = contents.Substring(contents.IndexOfNth("\n", 3) + 1);
                if ((mdtTime - DateTime.Parse(nextHB)).TotalMinutes > 2) hbHistory += DateTime.Parse(nextHB).ToString("yyyy-MM-dd HH:mm:ss") + "\n";
            }
            return hbHistory;
        }
    }
    public static class Utilities2 {
        public static int IndexOfNth(this string str, string value, int nth = 0) {
            if (nth < 0)
                throw new ArgumentException("Can not find a negative index of substring in string. Must start with 0");

            int offset = str.IndexOf(value);
            for (int i = 0; i < nth; i++) {
                if (offset == -1) return -1;
                offset = str.IndexOf(value, offset + 1);
            }

            return offset;
        }
    }
}
