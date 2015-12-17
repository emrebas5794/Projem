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
    public class KasaFoyuIslemleri
    {
        internal static string KasaFoyuAl()
        {
            SqlConnection connection = new SqlConnection(Database.ConnectionString);
            connection.Open();
            SqlCommand command = new SqlCommand("SELECT * FROM KasaFoyu", connection);
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

            return JsonConvert.SerializeObject(response);
        }

        internal static void KasaFoyuGir(string Data)
        {
            JObject parameters = (JObject)JsonConvert.DeserializeObject(Data);
            JToken Tip, Miktar, ParaBirimi, Aciklama, BaslangicTarihi;

            parameters.TryGetValue("Tip", out Tip);
            parameters.TryGetValue("Miktar", out Miktar);
            parameters.TryGetValue("ParaBirimi", out ParaBirimi);
            parameters.TryGetValue("Aciklama", out Aciklama);
            parameters.TryGetValue("BaslangicTarihi", out BaslangicTarihi);

            if (Globals.IsNullOrEmptyAny(Tip, Miktar, ParaBirimi, Aciklama, BaslangicTarihi))
                throw new Exception("Gerekli bazı parametreler sağlanmadığından işlem gerçekleştirilemedi.");

            StringBuilder query = new StringBuilder("INSERT INTO KasaFoyu(Tip, Miktar, ParaBirimi, Aciklama, BaslangicTarihi) ");
            query.AppendFormat("VALUES ('{0}', {1}, '{2}', '{3}', '{4}')",
                Tip.ToString(),
                Miktar.ToString(),
                ParaBirimi.ToString(),
                Aciklama.ToString(),
                DateTime.ParseExact(BaslangicTarihi.ToString(), "dd.MM.yyyy", null).ToString("yyyy.MM.dd")
                );
            SqlConnection connection = new SqlConnection(Database.ConnectionString);
            connection.Open();
            SqlCommand command = new SqlCommand(query.ToString(), connection);
            command.ExecuteNonQuery();
            connection.Close();
        }

        internal static void KasaFoyuUpdate(string Data)
        {
            JObject parameters = (JObject)JsonConvert.DeserializeObject(Data);
            JToken id, Tip, AltTip, Alt2Tip, BaglantiID, Miktar, ParaBirimi, Aciklama;

            parameters.TryGetValue("id", out id);
            parameters.TryGetValue("Tip", out Tip);
            parameters.TryGetValue("AltTip", out AltTip);
            parameters.TryGetValue("Alt2Tip", out Alt2Tip);
            parameters.TryGetValue("BaglantiID", out BaglantiID);
            parameters.TryGetValue("Miktar", out Miktar);
            parameters.TryGetValue("ParaBirimi", out ParaBirimi);
            parameters.TryGetValue("Aciklama", out Aciklama);

            if (Globals.IsNullOrEmpty(id))
                throw new Exception("Gerekli bazı parametreler sağlanmadığından işlem gerçekleştirilemedi.");

            StringBuilder query = new StringBuilder("UPDATE KasaFoyu SET ");
            if (!Globals.IsNullOrEmpty(Tip))
            {
                query.AppendFormat("Tip='{0}', ", Tip.ToString());
            }
            if (!Globals.IsNullOrEmpty(AltTip))
            {
                query.AppendFormat("AltTip='{0}', ", AltTip.ToString());
            }
            if (!Globals.IsNullOrEmpty(Alt2Tip))
            {
                query.AppendFormat("Alt2Tip='{0}', ", Alt2Tip.ToString());
            }
            if (!Globals.IsNullOrEmpty(BaglantiID))
            {
                query.AppendFormat("BaglantiID='{0}', ", BaglantiID.ToString());
            }
            if (!Globals.IsNullOrEmpty(Miktar))
            {
                query.AppendFormat("Miktar={0}, ", Miktar.ToString());
            }
            if (!Globals.IsNullOrEmpty(ParaBirimi))
            {
                query.AppendFormat("ParaBirimi='{0}', ", ParaBirimi.ToString());
            }
            if (!Globals.IsNullOrEmpty(Aciklama))
            {
                query.AppendFormat("Aciklama='{0}', ", Aciklama.ToString());
            }
            query.Remove(query.ToString().Length - 2, 1); //sondaki virgülü kaldır

            query.AppendFormat("WHERE id={0}", id.ToString());

            SqlConnection connection = new SqlConnection(Database.ConnectionString);
            connection.Open();
            SqlCommand command = new SqlCommand(query.ToString(), connection);
            command.ExecuteNonQuery();

            //using (SqlCommand command2 = new SqlCommand("DELETE FROM Maliyetler WHERE Maliyet_Kasaid = @Maliyet_Kasaid", connection))
            //{
            //    command2.Parameters.AddWithValue("Maliyet_Kasaid", id.ToString());
            //    command2.ExecuteNonQuery();
            //}

            connection.Close();
        }

        internal static void KasaFoyuMaliyetGirdisi(string Data)
        {
            JObject AlinanData = JObject.Parse(Data);
            JToken Tip, Fiyat, Aciklama, KasaFoyID;

            AlinanData.TryGetValue("Tip", out Tip);
            AlinanData.TryGetValue("Fiyat", out Fiyat);
            AlinanData.TryGetValue("Aciklama", out Aciklama);
            AlinanData.TryGetValue("KasaFoyID", out KasaFoyID);

            using (SqlConnection connection = new SqlConnection(Database.ConnectionString))
            {
                connection.Open();

                using (SqlCommand command = new SqlCommand("DELETE FROM Maliyetler WHERE Maliyet_Kasaid = @Maliyet_Kasaid", connection))
                {
                    command.Parameters.AddWithValue("Maliyet_Kasaid", KasaFoyID.ToString());
                    command.ExecuteNonQuery();
                }

                using (SqlCommand command = new SqlCommand("INSERT INTO Maliyetler(Maliyet_Tipi, Maliyet_Arac, Maliyet_Miktar, Maliyet_Odeme, Maliyet_Kasaid) VALUES (@Maliyet_Tipi, @Maliyet_Arac, @Maliyet_Miktar, @Maliyet_Odeme, @Maliyet_Kasaid)", connection))
                {
                    command.Parameters.AddWithValue("Maliyet_Tipi", Tip.ToString());
                    command.Parameters.AddWithValue("Maliyet_Arac", Aciklama.ToString());
                    command.Parameters.AddWithValue("Maliyet_Miktar", Fiyat.ToString());
                    command.Parameters.AddWithValue("Maliyet_Odeme", 1);
                    command.Parameters.AddWithValue("Maliyet_Kasaid", KasaFoyID.ToString());
                    command.ExecuteNonQuery();
                }

                using (SqlCommand command = new SqlCommand("UPDATE KasaFoyu SET AltTip=@AltTip WHERE id=@id", connection))
                {
                    command.Parameters.AddWithValue("AltTip", Tip.ToString());
                    command.Parameters.AddWithValue("id", KasaFoyID.ToString());
                    command.ExecuteNonQuery();
                }

                connection.Close();
            }
        }

        internal static int KasaFoyuSifilaKontrol()
        {
            SqlConnection connection = new SqlConnection(Database.ConnectionString);
            connection.Open();
            SqlCommand command = new SqlCommand("SELECT COUNT(*) SatirSayisi FROM KasaFoyu where AltTip is null ", connection);
            SqlDataReader reader = command.ExecuteReader();
            JArray response = new JArray();
            int SatirSayisi=0;
            while (reader.Read())
            {
                 SatirSayisi = Convert.ToInt32(reader["SatirSayisi"]);
                        
            }
            connection.Close();
            if (SatirSayisi>0)
            {
                return 1;
            }
            else
            {
                return 0;
            }
            

          
        }
        internal static string KasaFoyuSifirla(string BaslangicTarihi, string Miktar)
        {
            int Kontrol= KasaFoyuSifilaKontrol();
            if (Kontrol==0)
            {           
            using (SqlConnection connect = new SqlConnection(Database.ConnectionString))
            {
                connect.Open();
                JArray MevcutKasaFoyu = new JArray();
                using (SqlCommand command = new SqlCommand("SELECT * FROM KasaFoyu", connect))
                {
                    SqlDataReader commandReader = command.ExecuteReader();
                    while (commandReader.Read())
                    {
                        JObject KasaFoyuVerisi = new JObject();
                        for (int i = 0; i < commandReader.FieldCount; i++)
                        {

                            if (commandReader.GetDataTypeName(i) == "date")
                            {
                                DateTime date;
                                KasaFoyuVerisi.Add(commandReader.GetName(i), DateTime.TryParse(commandReader[i].ToString(), out date) ? date.ToString("dd.MM.yyyy") : "");
                            }
                            else
                            {
                                KasaFoyuVerisi.Add(commandReader.GetName(i).ToString(), commandReader[i].ToString());
                            }
                        }
                        MevcutKasaFoyu.Add(KasaFoyuVerisi);
                    }
                    commandReader.Close();
                }

                using (SqlCommand command = new SqlCommand("SET DATEFORMAT ymd; INSERT INTO KasaFoyuArsiv(BaslangicTarihi, BitisTarihi, ArsivData) VALUES(@BaslangicTarihi, @BitisTarihi, @ArsivData)", connect))
                {
                    command.Parameters.AddWithValue("BaslangicTarihi", DateTime.Parse(BaslangicTarihi).ToString("yyyy.MM.dd"));
                    command.Parameters.AddWithValue("BitisTarihi", DateTime.Now.ToString("yyyy.MM.dd"));
                    command.Parameters.AddWithValue("ArsivData", MevcutKasaFoyu.ToString());
                    command.ExecuteNonQuery();
                }

                using (SqlCommand command = new SqlCommand("DELETE FROM KasaFoyu SET DATEFORMAT ymd; INSERT INTO KasaFoyu(Tip, AltTip, Miktar, ParaBirimi, Aciklama, BaslangicTarihi) VALUES(@Tip, @AltTip, @Miktar, @ParaBirimi, @Aciklama, @BaslangicTarihi)", connect))
                {
                    command.Parameters.AddWithValue("Tip", "Giriş");
                    command.Parameters.AddWithValue("AltTip", "Kasa Açılışı");
                    command.Parameters.AddWithValue("Miktar", Convert.ToInt32(Miktar));
                    command.Parameters.AddWithValue("ParaBirimi", "TR");
                    command.Parameters.AddWithValue("Aciklama", "Kasa Açılışı");
                    command.Parameters.AddWithValue("BaslangicTarihi", DateTime.Now.ToString("yyyy.MM.dd"));
                    command.ExecuteNonQuery();
                }

                connect.Close();
            }
            return "Ok";
            }
            else
            {
                return "Hata";
            }
        }

        internal static void KasaFoyuSil(string KasaFoyID)
        {
            using (SqlConnection connect = new SqlConnection(Database.ConnectionString))
            {
                connect.Open();

                using (SqlCommand command = new SqlCommand("DELETE FROM KasaFoyu WHERE id = @id", connect))
                {
                    command.Parameters.AddWithValue("id", KasaFoyID);
                    command.ExecuteNonQuery();
                }

                using (SqlCommand command = new SqlCommand("DELETE FROM AracMaliyet WHERE KasaFoyuId = @KasaFoyuId", connect))
                {
                    command.Parameters.AddWithValue("KasaFoyuId", KasaFoyID);
                    command.ExecuteNonQuery();
                }

                connect.Close();
            }
        }
    }
}