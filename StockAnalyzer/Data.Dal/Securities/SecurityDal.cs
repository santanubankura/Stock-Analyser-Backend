using Core.Entity.Securities;
using Data.Dal.DataHelper;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;

namespace Data.Dal.Securities
{
    public class SecurityDal
    {
        public SecurityCollection GetSecurities()
        {
            SecurityCollection retValue = new SecurityCollection();
            List<Security> dataList = new List<Security>();
            try
            {
                DataSet ds = SqlServerHelper.ExecuteDataSetProc("GetSecurities");
                foreach (DataRow dr in ds.Tables[0].Rows)
                {
                    dataList.Add(new Security
                    {
                        Id = Convert.ToInt16(dr["ID"]),
                        MKT = dr["MKT"].ToString(),
                        SERIES = dr["SERIES"].ToString(),
                        SYMBOL = dr["SYMBOL"].ToString(),
                        SECURITY_NAME = dr["SECURITY_NAME"].ToString()
                    });
                }
                retValue.SecurityInfo = dataList;
            }
            catch (Exception genEx)
            {
                throw genEx;
            }
            return retValue;
        }

        public PDTradeCollection GetSecurityStatusPd(int Id, DateTime FromDate, DateTime ToDate)
        {
            PDTradeCollection retValue = new PDTradeCollection();
            List<PDTrade> dataList = new List<PDTrade>();
            try
            {
                SqlParameter prmId = new SqlParameter("@Id", SqlDbType.Int);
                prmId.Value = Id;

                SqlParameter prmFromDate = new SqlParameter("@FromDate", SqlDbType.Date);
                prmFromDate.Value = FromDate;

                SqlParameter prmToDate = new SqlParameter("@ToDate", SqlDbType.Date);
                prmToDate.Value = ToDate;

                DataSet ds = SqlServerHelper.ExecuteDataSetProc("GetSecurityStatus", prmId, prmFromDate, prmToDate);
                foreach (DataRow dr in ds.Tables[0].Rows)
                {
                    dataList.Add(new PDTrade
                    {
                        Id = Convert.ToInt64(dr["ID"]),
                        SecurityInfo = new Security
                        {
                            MKT = dr["MKT"].ToString(),
                            SERIES = dr["SERIES"].ToString(),
                            SYMBOL = dr["SYMBOL"].ToString(),
                            SECURITY_NAME = dr["SECURITY_NAME"].ToString()
                        },
                        TRADING_DATE = dr["TRADING_DATE"].ToString(),
                        PREV_CL_PR = Convert.ToDecimal(dr["PREV_CL_PR"].ToString()),
                        OPEN_PRICE = Convert.ToDecimal(dr["OPEN_PRICE"].ToString()),
                        HIGH_PRICE = Convert.ToDecimal(dr["HIGH_PRICE"].ToString()),
                        LOW_PRICE = Convert.ToDecimal(dr["LOW_PRICE"].ToString()),
                        CLOSE_PRICE = Convert.ToDecimal(dr["CLOSE_PRICE"].ToString()),
                        NET_TRDVAL = Convert.ToDecimal(dr["NET_TRDVAL"].ToString()),
                        NET_TRDQTY = Convert.ToDecimal(dr["NET_TRDQTY"].ToString()),
                        IND_SEC = dr["IND_SEC"].ToString(),
                        CORP_IND = dr["CORP_IND"].ToString(),
                        TRADES = Convert.ToDecimal(dr["TRADES"].ToString()),
                        HI_52_WK = Convert.ToDecimal(dr["HI_52_WK"].ToString()),
                        LO_52_WK = Convert.ToDecimal(dr["LO_52_WK"].ToString())
                    });
                }
                retValue.PDTradeInfo = dataList;
            }
            catch (Exception genEx)
            {
                throw genEx;
            }
            return retValue;
        }

        public List<SecuritiesStatusChart> GetSecurityStatus(int Id, DateTime FromDate, DateTime ToDate)
        {
            List<SecuritiesStatusChart> retValue = new List<SecuritiesStatusChart>();
            try
            {
                SqlParameter prmId = new SqlParameter("@Id", SqlDbType.Int);
                prmId.Value = Id;

                SqlParameter prmFromDate = new SqlParameter("@FromDate", SqlDbType.Date);
                prmFromDate.Value = FromDate;

                SqlParameter prmToDate = new SqlParameter("@ToDate", SqlDbType.Date);
                prmToDate.Value = ToDate;

                DataSet ds = SqlServerHelper.ExecuteDataSetProc("GetSecurityStatus", prmId, prmFromDate, prmToDate);
                foreach (DataRow dr in ds.Tables[0].Rows)
                {
                    retValue.Add(new SecuritiesStatusChart
                    {
                        x = Convert.ToDateTime(dr["TRADING_DATE"].ToString()),
                        open = Convert.ToDecimal(dr["OPEN_PRICE"].ToString()),
                        high = Convert.ToDecimal(dr["HIGH_PRICE"].ToString()),
                        low = Convert.ToDecimal(dr["LOW_PRICE"].ToString()),
                        close = Convert.ToDecimal(dr["CLOSE_PRICE"].ToString()),
                        volume = Convert.ToDecimal(dr["NET_TRDQTY"].ToString())
                    });
                }
            }
            catch (Exception genEx)
            {
                throw genEx;
            }
            return retValue;
        }
    }
}
