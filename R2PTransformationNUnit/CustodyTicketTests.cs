using Microsoft.Extensions.Configuration;
using Newtonsoft.Json;
using NUnit.Framework;
using R2PTransformation.src;
using R2PTransformation.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.IO;
using System.Linq;

namespace STransformNUnit {
    public class CustodyTicketsTests {
        [SetUp]
        public void Setup() {
            DBContextWithConnectionString.SetConnectionString("Data Source=inmdevarmsvruw2001.database.windows.net;Initial Catalog=inmdevarmsqluw2001;User ID=suncorsqladmin;password=AdvancedAnalytics2020;");
        }

        [Test]
        public void LoadCSV() {
            string cs = "Data Source=aaasbxarmsrvuw2015.database.windows.net;Initial Catalog=NLSandbox;User ID=tempR2PIntegration;password=NorthernLights2021";
            DataTable dt = Utilities.ConvertCSVFiletoDataTable(@"..\..\..\..\sampleFiles\CustodyTicket\ct.csv");
            dt.TableName = "custodyticket";
            foreach (DataRow row in dt.AsEnumerable()) {
                foreach(DataColumn col in dt.Columns) {
                    //if (col.DataType.ToString() == "DateTime") 
                        {
                        if (row[col].ToString() == "") row[col] = DBNull.Value; ;
                    }
                }
            }

            Utilities.Save(cs, dt);
            Assert.IsTrue(dt.Rows.Count > 0);
        }

        [Test]
        public void TestBuilder() {
            string targetFile = File.ReadAllText(@"..\..\..\..\sampleFiles\CustodyTicket\SampleTicket.txt");
            CustodyTicket ct1 = new CustodyTicket(){ PostingDateTime = new DateTime(2020, 09, 14, 07, 43, 13),  S4Material = "RBOB",  EnteredBy = "170552311-1",  S4MaterialDocument = "123", NetQuantitySize = 13507, BolNumber = "166438_", Density = 0.7260M };
            /*MOVEMENT_ID,170552311-1
SOURCE_OR_DESTINATION,S
EQUIPMENT,
PRODUCT,RBOB
PACKAGE,
START_QTY,
END_QTY,13507.000
NET_QTY,13507.000
PACKAGE_COUNT,
UNITS,L
COMPANY,
REFERENCE,0.7260
<END MOVEMENT DETAIL REC>
<START MOVEMENT DETAIL REC>
MOVEMENT_ID,170552311-1
SOURCE_OR_DESTINATION,D
EQUIPMENT,
PRODUCT,RBOB
PACKAGE,
START_QTY,
END_QTY,
NET_QTY,13507.000
PACKAGE_COUNT,
UNITS,L
COMPANY,
REFERENCE,166438_*/
            CustodyTicket ct2 = new CustodyTicket() { PostingDateTime = new DateTime(2020, 09, 14, 07, 44, 13), S4Material = "C-0", EnteredBy = "170552311-2", S4MaterialDocument = "123", NetQuantitySize = 12961, BolNumber = "166438_", Density = 0.8660M };

            List<CustodyTicket> tix = new List<CustodyTicket>();
            tix.Add(ct1);
            tix.Add(ct2);
            String generated = CustodyTicketController.CreateHoneywellPBFile(tix);
            Assert.AreEqual(targetFile, generated);
        }
    }
}
