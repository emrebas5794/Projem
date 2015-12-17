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
    public class CekIslemleri
    {
        internal static string CekListesiAl()
        {
            SqlConnection connection = new SqlConnection(Database.ConnectionString);
            connection.Open();
            SqlCommand command = new SqlCommand("SELECT * FROM CekListesi_View", connection);
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

        internal static void CekEkle(string Data)
        {
            JObject data = (JObject)JsonConvert.DeserializeObject(Data);
            JToken Tarih, Miktar, CekAlinanKisi, CekAsilSahibi, Banka, BankaSubesi, CekNo, TakastaOlduguHesap, CekNot;
            data.TryGetValue("Tarih", out Tarih);
            data.TryGetValue("Miktar", out Miktar);
            data.TryGetValue("CekAlinanKisi", out CekAlinanKisi);
            data.TryGetValue("CekAsilSahibi", out CekAsilSahibi);
            data.TryGetValue("Banka", out Banka);
            data.TryGetValue("BankaSubesi", out BankaSubesi);
            data.TryGetValue("CekNo", out CekNo);
            data.TryGetValue("TakastaOlduguHesap", out TakastaOlduguHesap);
            data.TryGetValue("CekNot", out CekNot);
            SqlConnection connection = new SqlConnection(Database.ConnectionString);
            connection.Open();
            SqlCommand comm = new SqlCommand("INSERT INTO Cek(Tarih, Miktar, CekAlinanKisi, CekAsilSahibi, Banka, BankaSubesi, CekNo, TakastaOlduguHesap, CekNot) VALUES(@Tarih, @Miktar, @CekAlinanKisi, @CekAsilSahibi, @Banka, @BankaSubesi, @CekNo, @TakastaOlduguHesap, @CekNot)", connection);
            comm.Parameters.AddWithValue("Tarih", DateTime.ParseExact(Tarih.ToString(), "dd.MM.yyyy", null).ToString("yyyy.MM.dd"));
            comm.Parameters.AddWithValue("Miktar", Miktar.Value<int>());
            comm.Parameters.AddWithValue("CekAlinanKisi", CekAlinanKisi.ToString());
            comm.Parameters.AddWithValue("CekAsilSahibi", Globals.IsNullOrEmpty(CekAsilSahibi) ? "" : CekAsilSahibi.ToString());
            comm.Parameters.AddWithValue("Banka", Banka.ToString());
            comm.Parameters.AddWithValue("BankaSubesi", BankaSubesi.ToString());
            comm.Parameters.AddWithValue("CekNo", CekNo.ToString());
            comm.Parameters.AddWithValue("TakastaOlduguHesap", Globals.IsNullOrEmpty(TakastaOlduguHesap) ? "" : TakastaOlduguHesap.ToString());
            comm.Parameters.AddWithValue("CekNot", Globals.IsNullOrEmpty(CekNot) ? "" : CekNot.ToString().Replace("'", "''"));
            comm.ExecuteNonQuery();
            connection.Close();
        }

        internal static string CekRiskiAl(string ContactUID)
        {
            SqlConnection connection = new SqlConnection(Database.ConnectionString);
            connection.Open();
            SqlCommand command = new SqlCommand("SELECT dbo.CekRiskiHesapla(@ContactUID)", connection);
            command.Parameters.AddWithValue("ContactUID", ContactUID);
            SqlDataReader reader = command.ExecuteReader();
            reader.Read();
            string toplamCekRiski = reader[0].ToString();
            reader.Close();
            connection.Close();
            return toplamCekRiski.Length > 0 ? toplamCekRiski : "0";
        }

        internal static string CekAl(string CekAlinanKisi)
        {
            SqlConnection connection = new SqlConnection(Database.ConnectionString);
            connection.Open();
            SqlCommand command = new SqlCommand(String.Format("SELECT * FROM Cek WHERE CekAlinanKisi='{0}'", CekAlinanKisi), connection);
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

        internal static string CekArsivAl()
        {
            SqlConnection connection = new SqlConnection(Database.ConnectionString);
            connection.Open();
            SqlCommand command = new SqlCommand("SELECT * FROM CekArsiv AS cekler LEFT JOIN (SELECT Ad as CekAlinanKisi_Ad, ContactUID as CekAlinanKisi_ID FROM Iletisim) AS cekalinan ON cekler.CekAlinanKisi = cekalinan.CekAlinanKisi_ID", connection);
            SqlDataReader reader = command.ExecuteReader();
            JArray ja = new JArray();
            while (reader.Read())
            {
                JObject jo = new JObject();
                for (int i = 0; i < reader.FieldCount; i++)
                {
                    if (reader.GetDataTypeName(i) == "datetime")
                    {
                        DateTime date;
                        jo.Add(reader.GetName(i), DateTime.TryParse(reader[i].ToString(), out date) ? date.ToString("yyyy/MM/dd HH:mm") : "");
                    }
                    else if (reader.GetDataTypeName(i) == "date")
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

        internal static void CekSilArsivle(string CekID)
        {
            SqlConnection connection = new SqlConnection(Database.ConnectionString);
            connection.Open();
            SqlCommand command = new SqlCommand("BEGIN TRAN "
                                                + "BEGIN TRY "
                                                + "INSERT INTO CekArsiv "
                                                + "SELECT [CekID] ,[CekNo] ,[Tarih] ,[Miktar] ,[CekAlinanKisi] ,[CekAsilSahibi] ,[Banka] ,[BankaSubesi] ,[TakastaOlduguHesap] ,[CekNot] ,[SistemeKayitTarihi], GETDATE() as [ArsivlenmeTarihi], @kullanici as [ArsivleyenKisi] FROM Cek WHERE CekID = @cekid "
                                                + "DELETE FROM Cek WHERE CekID = @cekid "
                                                + "COMMIT TRAN "
                                                + "END TRY "
                                                + "BEGIN CATCH "
                                                + "ROLLBACK TRAN "
                                                + "END CATCH", connection);
            command.Parameters.AddWithValue("cekid", CekID);
            command.Parameters.AddWithValue("kullanici", HttpContext.Current.Session["Username"]);
            command.ExecuteNonQuery();
            connection.Close();
        }

        internal static void CekDuzenle(string CekID, string Data)
        {
            SqlConnection connection = new SqlConnection(Database.ConnectionString);
            connection.Open();
            JObject data = (JObject)JsonConvert.DeserializeObject(Data);
            StringBuilder columns = new StringBuilder();
            foreach (KeyValuePair<string, JToken> item in data)
            {
                columns.Append(item.Key + "=" + "@" + item.Key + ",");
            }
            columns.Remove(columns.Length - 1, 1);
            SqlCommand command = new SqlCommand(String.Format("UPDATE Cek SET {0} WHERE CekID = @cekid", columns.ToString()), connection);
            command.Parameters.AddWithValue("cekid", CekID);
            foreach (KeyValuePair<string, JToken> item in data)
            {
                command.Parameters.AddWithValue(item.Key, item.Value.ToString());
            }
            command.ExecuteNonQuery();
            connection.Close();
        }

        internal static void CekSil(string CekID)
        {
            SqlConnection connection = new SqlConnection(Database.ConnectionString);
            connection.Open();
            SqlCommand command = new SqlCommand("DELETE FROM Cek WHERE CekID = @cekid", connection);
            command.Parameters.AddWithValue("cekid", CekID);
            command.ExecuteNonQuery();
            connection.Close();
        }

        internal static void CekArsivSil(string CekID)
        {
            SqlConnection connection = new SqlConnection(Database.ConnectionString);
            connection.Open();
            SqlCommand command = new SqlCommand("DELETE FROM CekArsiv WHERE CekID = @cekid", connection);
            command.Parameters.AddWithValue("cekid", CekID);
            command.ExecuteNonQuery();
            connection.Close();
        }
    }
}