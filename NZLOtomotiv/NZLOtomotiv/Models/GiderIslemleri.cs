using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;

namespace NZLOtomotiv.Models
{
    public static class GiderIslemleri
    {
        public static void GiderKaydet(string Data)
        {
            JToken GiderTipi, AracMaliyetTipi, AracID, Aciklama, Gider, Tarih;
            JObject parameters = (JObject)JsonConvert.DeserializeObject(Data);

            parameters.TryGetValue("GiderTipi", out GiderTipi);
            parameters.TryGetValue("AracMaliyetTipi", out AracMaliyetTipi);
            parameters.TryGetValue("AracID", out AracID);
            parameters.TryGetValue("Aciklama", out Aciklama);
            parameters.TryGetValue("Gider", out Gider);
            parameters.TryGetValue("Tarih", out Tarih);

            StringBuilder query = new StringBuilder("USE NazliOtomotiv; ");
            query.AppendFormat("INSERT INTO Giderler (GiderID, GiderTipi, Gider, AracMaliyetTipi, AracID, Aciklama, Tarih) Values ('{0}', '{1}', {2}, '{3}', '{4}', '{5}', '{6}')",
                Guid.NewGuid(),
                GiderTipi.ToString(),
                Gider.ToString(),
                AracMaliyetTipi == null ? null : AracMaliyetTipi.ToString(),
                AracID == null ? null : AracID.ToString(),
                Aciklama == null ? null : Aciklama.ToString(),
                DateTime.ParseExact(Tarih.ToString(), "dd.MM.yyyy", null).ToString("yyyy.MM.dd")
                );

            SqlConnection connection = new SqlConnection(Database.ConnectionString);
            connection.Open();
            SqlCommand command = new SqlCommand(query.ToString(), connection);
            command.ExecuteNonQuery();
            connection.Close();
        }

        internal static string GiderAl(string Data)
        {
            JToken Tarih_min, Tarih_max;
            JObject parameters = (JObject)JsonConvert.DeserializeObject(Data);

            parameters.TryGetValue("Tarih_min", out Tarih_min);
            parameters.TryGetValue("Tarih_max", out Tarih_max);

            StringBuilder query = new StringBuilder("USE NazliOtomotiv; ");
            query.Append("SELECT * FROM Giderler AS gider ");
            query.Append("LEFT JOIN (SELECT Arac_Uid, Plaka, Marka, Seri, Model FROM Araclar) AS arac ON gider.AracID = arac.Arac_Uid ");
            bool pastfirst = false;
            if (!Globals.IsNullOrEmpty(Tarih_min))
            {
                if (pastfirst)
                    query.Append("AND ");
                else
                {
                    query.Append("WHERE ");
                    pastfirst = true;
                }

                query.AppendFormat("Tarih >= '{0}' ", DateTime.ParseExact(Tarih_min.ToString(), "dd.MM.yyyy", null).ToString("yyyy.MM.dd"));
            }
            if (!Globals.IsNullOrEmpty(Tarih_max))
            {
                if (pastfirst)
                    query.Append("AND ");
                else
                {
                    query.Append("WHERE ");
                    pastfirst = true;
                }

                query.AppendFormat("Tarih <= '{0}' ", DateTime.ParseExact(Tarih_max.ToString(), "dd.MM.yyyy", null).ToString("yyyy.MM.dd"));
            }

            SqlConnection connection = new SqlConnection(Database.ConnectionString);
            connection.Open();
            SqlCommand command = new SqlCommand(query.ToString(), connection);
            SqlDataReader reader = command.ExecuteReader();
            JArray response = new JArray();
            while (reader.Read())
            {
                JObject jo = new JObject();
                for (int i = 0; i < reader.FieldCount; i++)
                {
                    if (reader.GetDataTypeName(i) == "date")
                    {
                        DateTime date;
                        jo.Add(reader.GetName(i), DateTime.TryParse(reader[i].ToString(), out date) ? date.ToString("dd.MM.yyyy") : "");
                    }
                    else
                    {
                        jo.Add(reader.GetName(i), reader[i].ToString());
                    }
                }
                response.Add(jo);
            }
            connection.Close();
            reader.Close();
            return JsonConvert.SerializeObject(response);
        }
    }
}