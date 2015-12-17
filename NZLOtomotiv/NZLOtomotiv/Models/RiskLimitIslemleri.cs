using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace NZLOtomotiv.Models
{
    public static class RiskLimitIslemleri
    {
        internal static string RisklerVeLimitAl()
        {
            SqlConnection connection = new SqlConnection(Database.ConnectionString);
            SqlCommand command = new SqlCommand("SELECT * FROM RiskLimitleri_View", connection);
            connection.Open();
            SqlDataReader reader = command.ExecuteReader();

            JArray ja = new JArray();
            while (reader.Read())
            {
                JObject jo = new JObject();
                for (int i = 0; i < reader.FieldCount; i++)
                {
                    if (reader.GetDataTypeName(i) == "date")
                    {
                        DateTime date;
                        jo.Add(reader.GetName(i), DateTime.TryParse(reader[i].ToString(), out date) ? date.ToString("yyyy/MM/dd") : "");
                    }
                    else
                    {
                        jo.Add(reader.GetName(i), reader[i].ToString());
                    }
                }
                ja.Add(jo);
            }
            reader.Close();
            connection.Close();
            return JsonConvert.SerializeObject(ja);
        }

        internal static string RisklerVeLimitAl(string ContactUID)
        {
            SqlConnection connection = new SqlConnection(Database.ConnectionString);
            SqlCommand command = new SqlCommand("SELECT * FROM RiskLimitleri_View WHERE ContactUID = @ContactUID", connection);
            command.Parameters.AddWithValue("ContactUID", ContactUID);
            connection.Open();
            SqlDataReader reader = command.ExecuteReader();
            JObject jo = new JObject();
            if (reader.Read())
            {
                for (int i = 0; i < reader.FieldCount; i++)
                {
                    if (reader.GetDataTypeName(i) == "date")
                    {
                        DateTime date;
                        jo.Add(reader.GetName(i), DateTime.TryParse(reader[i].ToString(), out date) ? date.ToString("yyyy/MM/dd") : "");
                    }
                    else
                    {
                        jo.Add(reader.GetName(i), reader[i].ToString());
                    }
                }
            }
            reader.Close();
            connection.Close();
            return JsonConvert.SerializeObject(jo);
        }
        internal static string GenelRisk()
        {
            string Limit="";
            SqlConnection connection = new SqlConnection(Database.ConnectionString);
            SqlCommand command = new SqlCommand("SELECT Limit FROM GenelRisk ", connection);
           
            connection.Open();
            SqlDataReader reader = command.ExecuteReader();
         
            if (reader.Read())
            {
                Limit = reader["Limit"].ToString();
            }
            reader.Close();
            connection.Close();
            return Limit;
        }

        internal static string GenelRiskGuncelle(string Limit)
        {
            SqlConnection connection = new SqlConnection(Database.ConnectionString);
            connection.Open();
            SqlCommand command = new SqlCommand("Update GenelRisk set Limit=@Limit ", connection);
            command.Parameters.AddWithValue("Limit", Convert.ToInt32(Limit));
            command.ExecuteNonQuery();
            connection.Close();
            return Limit;
        }


        internal static void RiskLimitDuzenle(string ContactUID, int RiskLimit)
        {
            SqlConnection connection = new SqlConnection(Database.ConnectionString);
            SqlCommand command = new SqlCommand("SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;" +
                "BEGIN TRANSACTION;" +
                "UPDATE RiskLimitleri SET RiskLimit = @RiskLimit WHERE ContactUID = @ContactUID;" +
                "IF @@ROWCOUNT = 0" +
                "BEGIN" +
                "  INSERT RiskLimitleri(ContactUID, RiskLimit) VALUES(@ContactUID, @RiskLimit);" +
                "END " +
                "COMMIT TRANSACTION;", connection);
            command.Parameters.AddWithValue("ContactUID", ContactUID);
            command.Parameters.AddWithValue("RiskLimit", RiskLimit > 0 ? RiskLimit : (object)DBNull.Value);
            connection.Open();
            command.ExecuteNonQuery();
            connection.Close();
        }

        internal static class Filtre
        {

            internal static string LimitAsan()
            {
                SqlConnection connection = new SqlConnection(Database.ConnectionString);
                SqlCommand command = new SqlCommand("SELECT * FROM RiskLimitleri_View WHERE ToplamRisk >= RiskLimit", connection);
                connection.Open();
                SqlDataReader reader = command.ExecuteReader();

                JArray ja = new JArray();
                while (reader.Read())
                {
                    JObject jo = new JObject();
                    for (int i = 0; i < reader.FieldCount; i++)
                    {
                        if (reader.GetDataTypeName(i) == "date")
                        {
                            DateTime date;
                            jo.Add(reader.GetName(i), DateTime.TryParse(reader[i].ToString(), out date) ? date.ToString("yyyy/MM/dd") : "");
                        }
                        else
                        {
                            jo.Add(reader.GetName(i), reader[i].ToString());
                        }
                    }
                    ja.Add(jo);
                }
                reader.Close();
                connection.Close();
                return JsonConvert.SerializeObject(ja);
            }

            internal static string RiskAralik(int Min, int Max)
            {
                SqlConnection connection = new SqlConnection(Database.ConnectionString);
                SqlCommand command = new SqlCommand();
              
                if (Max==0)
                {
                   command = new SqlCommand("SELECT * FROM RiskLimitleri_View WHERE ToplamRisk>=@min", connection);
                   command.Parameters.AddWithValue("min", Min);
                }
                else
                {
                    command = new SqlCommand("SELECT * FROM RiskLimitleri_View WHERE ToplamRisk BETWEEN @min AND @max", connection);
                    command.Parameters.AddWithValue("min", Min);
                    command.Parameters.AddWithValue("max", Max);
                }
                 
              
                connection.Open();
                SqlDataReader reader = command.ExecuteReader();

                JArray ja = new JArray();
                while (reader.Read())
                {
                    JObject jo = new JObject();
                    for (int i = 0; i < reader.FieldCount; i++)
                    {
                        if (reader.GetDataTypeName(i) == "date")
                        {
                            DateTime date;
                            jo.Add(reader.GetName(i), DateTime.TryParse(reader[i].ToString(), out date) ? date.ToString("yyyy/MM/dd") : "");
                        }
                        else
                        {
                            jo.Add(reader.GetName(i), reader[i].ToString());
                        }
                    }
                    ja.Add(jo);
                }
                reader.Close();
                connection.Close();
                return JsonConvert.SerializeObject(ja);
            }
        }
    }
}