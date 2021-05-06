using System;
using System.Collections.Generic;
using System.Globalization;
using System.Text;

namespace R2PTransformation.src {
    public class BlobFile {
        public string RootFolder;
        public String FullName;
        public String FullDirectoryName;
        public String contents;
        public String Contents { get { return contents.StartsWith("site") ? contents : "site,tag,alias,datetime,value,avgvalue,strvalue,quality\n" + contents; } set { contents = value; } }
        public string DateTimeStr { get { return FullDirectoryName.Replace(RootFolder, ""); } }
        public DateTime DateTime { get { return DateTime.ParseExact(DateTimeStr.Replace("/", "").Replace("date=", ""), "yyyyMMdd", new CultureInfo("en-US")); } }

    }
}
