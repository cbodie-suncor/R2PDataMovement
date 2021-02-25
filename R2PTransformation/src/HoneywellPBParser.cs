using System;
using System.Collections.Generic;
using System.IO;

namespace R2PTransformation.src {
    public class HoneywellPBParser {
        private string Filename = "";

        public HoneywellPBFile LoadFile(string fileName, string plant, DateTime currentDay) {
            Filename = fileName;
            HoneywellPBFile pf = new HoneywellPBFile(fileName, plant);
            pf.IsCurrentDay(currentDay);
            string fileText = File.ReadAllText(fileName);
            if (string.IsNullOrEmpty(fileText)) throw new Exception("File is empty");
            fileText = fileText.Replace("\r", "");  // only care about \n
            Contents fileContents = GetTagContents(fileText, "<<NP UPLOAD FILE>>");
            Contents defaultContents = GetTagContents(fileContents.TagContents, "<<DEFAULTS>>");
            pf.SetDefaults(ParseCSVContents(defaultContents.TagContents));
            pf.SetValues(ParseCSVContents(defaultContents.OuterContents));

            Contents balanceContents = GetTagContents(fileContents.TagContents, "<<START BALANCE REC>>");
            pf.BalanceRecords = GetBalanceRecords(defaultContents.OuterContents, pf);


            foreach (var item in pf.ProductionRecords()) {
                item.TagBalance(currentDay);
            }

            return pf;
        }

        private Dictionary<string,string> ParseCSVContents(string contents) {
            // disregard any << >> content
            contents = RemoveInnerTags(contents);

            Dictionary<string, string> values = new Dictionary<string, string>();
            foreach (string row in contents.Split("\n")) {
                if (String.IsNullOrEmpty(row)) continue;
                if (row.Split(',').Length < 2) throw new Exception("Incomplete row:" + row);
                string key = row.Split(',')[0];
                string value = row.Split(',')[1];
                values.Add(key, value);
            }
            return values;
        }

        private ContentTag GetNextFileTag(string contents) {
            ContentTag tag = new ContentTag();
            tag.Start = contents.IndexOf("<<");
            if (tag.Start == -1) return null;
            int next = contents.IndexOf(">>", tag.Start);
            tag.InnerContentStart = next + 2;
            tag.Name = contents.Substring(tag.Start + 2, next - tag.Start - 2).Replace("START ", "");
            tag.EndTagName = "END " + tag.Name;
            tag.EndTagIndex = contents.IndexOf("<<" + tag.EndTagName + ">>");
            tag.End = tag.EndTagIndex + ("<<" + tag.EndTagName + ">>").Length;
            tag.InnerContents = contents.Substring(tag.InnerContentStart, tag.EndTagIndex - tag.InnerContentStart);
            tag.OuterContents = contents.Substring(0, tag.Start) + contents.Substring(tag.EndTagIndex + ("<<" + tag.EndTagName + ">>").Length);

            return tag;
        }

        private string RemoveInnerTags(string contents) {
            string results = contents;
            while(true) {
                ContentTag tag = GetNextFileTag(results);
                if (tag == null) return results;
                results = tag.OuterContents;
            }
        }

        private List<BalanceRecord> GetBalanceRecords(string contents, HoneywellPBFile pf) {
            List<BalanceRecord> bals = new List<BalanceRecord>();
            while (true) {
                ContentTag tag = GetNextFileTag(contents);
                if (tag == null) break;
                if (tag.Name != "BALANCE REC") throw new Exception("Tag does not match BALANCE REC:" + tag.Name);
                BalanceRecord br = new BalanceRecord();
                br.SetValues(ParseCSVContents(tag.InnerContents));
                br.ProductionRecords = GetProductionRecords(tag.InnerContents, pf);
                contents = contents.Substring(tag.End);
                bals.Add(br);
            }
            return bals;
        }

        private List<HoneywellPBProductionRecord> GetProductionRecords(string contents, HoneywellPBFile pf) {
            List<HoneywellPBProductionRecord> recs = new List<HoneywellPBProductionRecord>();
            while (true) {
                ContentTag tag = GetNextFileTag(contents);
                if (tag == null) break;
                if (tag.Name != "PRODUCT REC") throw new Exception("Tag does not match PRODUCT REC:" + tag.Name);

                HoneywellPBProductionRecord pr = new HoneywellPBProductionRecord(ParseCSVContents(tag.InnerContents), pf);
                recs.Add(pr);
                contents = contents.Substring(tag.End);
            }
            return recs;
        }

        private Contents GetTagContents(string text, string tagName) {
            ContentTag tag = GetNextFileTag(text);

            Contents contents = new Contents();
            int start = text.IndexOf(tagName);
            string endTag = tagName.Replace("START ", "").Replace("<<","<<END ");
            if (start == -1) throw new Exception("Cannot find initial tag:" + tag);
            int end = text.IndexOf(endTag);
            if (end == -1) throw new Exception("Cannot find end tag:" + endTag);

            contents.TagContents = text.Substring(start + tagName.Length + 1, end - start - tagName.Length -2);
            contents.OuterContents = "";
            if (start > 0) contents.OuterContents += text.Substring(0, start - 1);
            if (start + (end + endTag.Length) < text.Length) contents.OuterContents += "\n" + text.Substring(end + endTag.Length);
            return contents;
        }
    }
    public struct Contents {
        public string TagContents;
        public string OuterContents;
    }

    public class ContentTag {
        public int Start;
        public int End;
        public int InnerContentStart;
        public string Name;
        public string EndTagName;
        public int EndTagIndex;
        public string InnerContents;
        public string OuterContents;
    }
}
