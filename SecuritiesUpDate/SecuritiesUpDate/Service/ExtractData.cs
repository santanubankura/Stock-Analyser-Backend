using Newtonsoft.Json;
using SecuritiesUpDate.Class;
using SecuritiesUpDate.DataHelper;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.OleDb;
using System.IO;
using System.Linq;

namespace SecuritiesUpDate.Service
{
    public class ExtractData
    {
        public bool ExtractPd(string filepath, DateTime transactionDate)
        {
            try
            {
                string indexName = "";
                string[] filePaths = Directory.GetFiles(filepath, "*.csv", SearchOption.TopDirectoryOnly);
                string fileName = filePaths.Where(m => m.Contains("Pd")).FirstOrDefault();
                var list = ReadCSVFile(fileName, ',', false, false);

                PDTradeCollection pDTradeCollection = new PDTradeCollection();
                List<PDTrade> pDTradeInfo = new List<PDTrade>();
                int iCount = 0;

                foreach (var item in list)
                {
                    //MKT	           //1
                    //SERIES	       //2
                    //SYMBOL	       //3
                    //SECURITY	       //4
                    //PREV_CL_PR	   //5
                    //OPEN_PRICE	   //6
                    //HIGH_PRICE	   //7
                    //LOW_PRICE	       //8
                    //CLOSE_PRICE	   //9
                    //NET_TRDVAL	   //10
                    //NET_TRDQTY	   //11
                    //IND_SEC	       //12
                    //CORP_IND	       //13
                    //TRADES	       //14
                    //HI_52_WK	       //15
                    //LO_52_WK         //16
                    if (iCount > 0 && item[4].Trim() == "" && item[3].Trim() != "")
                    {
                        indexName = item[3].Trim();
                    }

                    if (iCount > 0 && item[4].Trim() != "")
                    {
                        pDTradeInfo.Add(new PDTrade
                        {
                            SecurityInfo = new Security
                            {
                                MKT = item[0].Trim(),
                                SERIES = item[1].Trim(),
                                SYMBOL = item[2].Trim(),
                                SECURITY_NAME = item[3].Trim(),
                                INDEX_NAME = indexName,
                            },
                            TRADING_DATE = transactionDate.ToString("dd/MMM/yyyy"),
                            PREV_CL_PR = Convert.ToDecimal(item[4].Trim()),
                            OPEN_PRICE = Convert.ToDecimal(item[5].Trim()),
                            HIGH_PRICE = Convert.ToDecimal(item[6].Trim()),
                            LOW_PRICE = Convert.ToDecimal(item[7].Trim()),
                            CLOSE_PRICE = Convert.ToDecimal(item[8].Trim()),
                            NET_TRDVAL = Convert.ToDecimal(item[9].Trim()),
                            NET_TRDQTY = Convert.ToDecimal(item[10].Trim()),
                            IND_SEC = item[11].Trim(),
                            CORP_IND = item[12].Trim(),
                            TRADES = Convert.ToDecimal(item[13].Trim()),
                            HI_52_WK = Convert.ToDecimal(item[14].Trim()),
                            LO_52_WK = Convert.ToDecimal(item[15].Trim()),
                        });
                    }
                    iCount++;
                }
                pDTradeCollection.PDTradeInfo = pDTradeInfo;
                string jsonString = JsonConvert.SerializeObject(pDTradeInfo);
                var callSpInsert = new ConnectionManager().ExecuteImportDailyPdData("ImportDailyPdData", jsonString, transactionDate);
                //var callSp = new ConnectionManager().GetDataTable("ImportDailyData", jsonString);
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return true;
        }


        private static List<string[]> ReadCSVFile(string filename, char csvDelimiter, bool ignoreHeadline, bool removeQuoteSign)
        {
            string[] result = new string[0];
            List<string[]> lst = new List<string[]>();

            string line;
            int currentLineNumner = 0;
            int columnCount = 0;

            // Read the file and display it line by line.  
            using (System.IO.StreamReader file = new System.IO.StreamReader(filename))
            {
                while ((line = file.ReadLine()) != null)
                {
                    currentLineNumner++;
                    string[] strAr = line.Split(csvDelimiter);
                    // save column count of dirst line
                    if (currentLineNumner == 1)
                    {
                        columnCount = strAr.Count();
                    }
                    else
                    {
                        //Check column count of every other lines
                        if (strAr.Count() != columnCount)
                        {
                            throw new Exception(string.Format("CSV Import Exception: Wrong column count in line {0}", currentLineNumner));
                        }
                    }

                    if (removeQuoteSign) strAr = RemoveQouteSign(strAr);

                    if (ignoreHeadline)
                    {
                        if (currentLineNumner != 1) lst.Add(strAr);
                    }
                    else
                    {
                        lst.Add(strAr);
                    }
                }

            }

            return lst;
        }
        private static string[] RemoveQouteSign(string[] ar)
        {
            for (int i = 0; i < ar.Count(); i++)
            {
                if (ar[i].StartsWith("\"") || ar[i].StartsWith("'")) ar[i] = ar[i].Substring(1);
                if (ar[i].EndsWith("\"") || ar[i].EndsWith("'")) ar[i] = ar[i].Substring(0, ar[i].Length - 1);

            }
            return ar;
        }

    }
}
