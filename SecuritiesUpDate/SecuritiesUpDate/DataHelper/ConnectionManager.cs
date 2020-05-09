using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace SecuritiesUpDate.DataHelper
{
    public class ConnectionManager
    {
        public string SQLConnectionString()
        {
            return ConfigurationManager.ConnectionStrings["SqlDBCon"].ToString();
        }
        public SqlConnection DBConnection()
        {
            SqlConnection oConnection = new SqlConnection(SQLConnectionString());
            oConnection.Open();
            return oConnection;
        }

        public bool ExecuteImportDailyPdData(string pSql, string p1, DateTime transactionDate)
        {
            bool retVal = false;
            SqlCommand oCommand = new SqlCommand();
            try
            {
                using (SqlConnection con = new SqlConnection(SQLConnectionString()))
                {
                    using (SqlCommand cmd = new SqlCommand(pSql, con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add("@Data", SqlDbType.VarChar).Value = p1;
                        cmd.Parameters.Add("@TradingDate", SqlDbType.Date).Value = transactionDate;
                        con.Open();
                        cmd.ExecuteNonQuery();
                    }
                }
                retVal = true;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return retVal;
        }

        public DataTable GetDataTable( string pSql, string p1)
        {
            DataSet oDataSet = new DataSet();
            SqlDataAdapter oDataAdapter = new SqlDataAdapter();
            SqlCommand oCommand = new SqlCommand();
            try
            {
                oCommand.Connection = DBConnection();
                oCommand.CommandText = pSql;
                oCommand.CommandType = CommandType.StoredProcedure;
                oCommand.Parameters.Add("@Data", SqlDbType.VarChar).Value = p1;
                oDataAdapter = new SqlDataAdapter(oCommand);
                oDataAdapter.Fill(oDataSet);
                return oDataSet.Tables[0];
            }
            catch (Exception ex)
            {
                throw ex;
            }
        } 
    }
}
