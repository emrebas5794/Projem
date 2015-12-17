using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Text;

namespace NZLOtomotiv.Models
{
    internal class SenetIslemleri
    {
        internal static string SenetProfilAl()
        {
            SqlConnection connection = new SqlConnection(Database.ConnectionString);
            connection.Open();
            SqlCommand command = new SqlCommand("SELECT * FROM SenetProfil_View ORDER BY Ad ", connection);
            SqlDataReader reader = command.ExecuteReader();
            JArray ja = new JArray();
            int j = 0;
            while (reader.Read())
            {
                JObject jo = new JObject();
                jo["ListIndex"] = j++;
                for (int i = 0; i < reader.FieldCount; i++)
                {
                    jo.Add(reader.GetName(i), reader[i].ToString());
                }
                //jo["Adresler"].Replace(new JArray(jo["Adresler"].Value<string>().Split(new string[] { "/*/" }, StringSplitOptions.RemoveEmptyEntries)));
                //jo["Telefonlar"].Replace(new JArray(jo["Telefonlar"].Value<string>().Split(new string[] { "/*/" }, StringSplitOptions.RemoveEmptyEntries)));
                ja.Add(jo);
            }
            reader.Close();
            connection.Close();
            return JsonConvert.SerializeObject(ja);
        }

        internal static string SecilenSenetProfilAl(string ContactUID)
        {
            SqlConnection connection = new SqlConnection(Database.ConnectionString);
            connection.Open();
            SqlCommand command = new SqlCommand("SELECT * FROM SenetProfil_View  ORDER BY Ad", connection);
          

            SqlDataReader reader = command.ExecuteReader();
            JArray ja = new JArray();
            int j = 0;
            while (reader.Read())
            {
               
               
                if (reader["ContactUID"].ToString()==ContactUID)
                {
                    JObject jo = new JObject();
                    jo["ListIndex"] = j;
                    for (int i = 0; i < reader.FieldCount; i++)
                    {
                        jo.Add(reader.GetName(i), reader[i].ToString());
                    }
                    jo["Adresler"].Replace(new JArray(jo["Adresler"].Value<string>().Split(new string[] { "/*/" }, StringSplitOptions.RemoveEmptyEntries)));
                    jo["Telefonlar"].Replace(new JArray(jo["Telefonlar"].Value<string>().Split(new string[] { "/*/" }, StringSplitOptions.RemoveEmptyEntries)));
                    ja.Add(jo);
                }

                j++;
              
            }
            reader.Close();
            connection.Close();
            return JsonConvert.SerializeObject(ja);
        }


        internal static string SenetProfilEkle(string ContactID)
        {
            SqlConnection connection = new SqlConnection(Database.ConnectionString);
            connection.Open();
            SqlCommand command = new SqlCommand("INSERT INTO SenetProfil(ContactUID) VALUES (@contactid); SELECT * FROM SenetProfil_View WHERE ContactUID = @contactid", connection);
            command.Parameters.AddWithValue("contactid", ContactID);
            SqlDataReader reader = command.ExecuteReader();
            reader.Read();
            JObject jo = new JObject();
            for (int i = 0; i < reader.FieldCount; i++)
            {
                jo.Add(reader.GetName(i), reader[i].ToString());
            }
            jo["Adresler"].Replace(new JArray(jo["Adresler"].Value<string>().Split(new string[] { "/*/" }, StringSplitOptions.RemoveEmptyEntries)));
            jo["Telefonlar"].Replace(new JArray(jo["Telefonlar"].Value<string>().Split(new string[] { "/*/" }, StringSplitOptions.RemoveEmptyEntries)));
            reader.Close();
            connection.Close();
            return JsonConvert.SerializeObject(jo);
        }

        internal static void SenetProfilKaldir(string ContactUID)
        {
            SqlConnection connection = new SqlConnection(Database.ConnectionString);
            connection.Open();
            SqlCommand command = new SqlCommand("DELETE FROM SenetProfil WHERE ContactUID = @contactid; DELETE FROM SenetBloklari WHERE Borclu = @contactid", connection);
            command.Parameters.AddWithValue("contactid", ContactUID);
            command.ExecuteNonQuery();
            connection.Close();
        }

        internal static void YeniSenetBlok(string Data)
        {
            JObject parameters = (JObject)JsonConvert.DeserializeObject(Data);
            JToken Borclu, Kefil, SenetiImzalayan, AlacakTipi, VadeOrani, AnaPara, SenetOlusturulmaTarihi, AracPlakasi, AracBasligi, SenetBlokNot, Senetler;
            parameters.TryGetValue("Borclu", out Borclu);
            parameters.TryGetValue("Kefil", out Kefil);
            parameters.TryGetValue("SenetiImzalayan", out SenetiImzalayan);
            parameters.TryGetValue("AlacakTipi", out AlacakTipi);
            parameters.TryGetValue("VadeOrani", out VadeOrani);
            parameters.TryGetValue("AnaPara", out AnaPara);
            parameters.TryGetValue("SenetOlusturulmaTarihi", out SenetOlusturulmaTarihi);
            parameters.TryGetValue("AracPlakasi", out AracPlakasi);
            parameters.TryGetValue("AracBasligi", out AracBasligi);
            parameters.TryGetValue("SenetBlokNot", out SenetBlokNot);
            string SenetBlokID = Guid.NewGuid().ToString();
            parameters.TryGetValue("Senetler", out Senetler);

            SqlConnection connection = new SqlConnection(Database.ConnectionString);
            SqlCommand command = new SqlCommand();
            command.Connection = connection;
            command.CommandText = "INSERT INTO SenetBloklari(Borclu, SenetBlokID, Kefil, SenetiImzalayan, AlacakTipi, VadeOrani, AnaPara, SenetOlusturulmaTarihi, AracPlakasi, AracBasligi, SenetBlokNot, SenetBlokNo, OdemeTarihi, Miktar, SenetNot) VALUES ";
            command.Parameters.AddWithValue("Borclu", Borclu.ToString());
            command.Parameters.AddWithValue("SenetBlokID", SenetBlokID);
            command.Parameters.AddWithValue("Kefil", Globals.IsNullOrEmpty(Kefil) ? "" : Kefil.ToString());
            command.Parameters.AddWithValue("SenetiImzalayan", Globals.IsNullOrEmpty(SenetiImzalayan) ? "" : SenetiImzalayan.ToString());
            command.Parameters.AddWithValue("AlacakTipi", AlacakTipi.ToString());
            command.Parameters.AddWithValue("VadeOrani", VadeOrani.ToString());
            command.Parameters.AddWithValue("AnaPara", AnaPara.ToString());
            command.Parameters.AddWithValue("SenetOlusturulmaTarihi", DateTime.ParseExact(SenetOlusturulmaTarihi.ToString(), "dd.MM.yyyy", null).ToString("yyyy.MM.dd"));
            command.Parameters.AddWithValue("AracPlakasi", Globals.IsNullOrEmpty(AracPlakasi) ? "" : AracPlakasi.ToString());
            command.Parameters.AddWithValue("AracBasligi", Globals.IsNullOrEmpty(AracBasligi) ? "" : AracBasligi.ToString());
            command.Parameters.AddWithValue("SenetBlokNot", Globals.IsNullOrEmpty(SenetBlokNot) ? "" : SenetBlokNot.ToString());

            int i = 0;
            foreach (JToken senet in Senetler)
            {
                command.CommandText += string.Format("(@Borclu, @SenetBlokID, @Kefil, @SenetiImzalayan, @AlacakTipi, @VadeOrani, @AnaPara, @SenetOlusturulmaTarihi, @AracPlakasi, @AracBasligi, @SenetBlokNot, @SenetBlokNo{0}, @OdemeTarihi{0}, @Miktar{0}, @SenetNot{0}),", i.ToString());
                //@SenetBlokNo{0}, @OdemeTarihi{0}, @Miktar{0}, @SenetNot{0}
                command.Parameters.AddWithValue("@SenetBlokNo" + i, senet.Value<string>("SenetBlokNo"));
                command.Parameters.AddWithValue("@OdemeTarihi" + i, DateTime.ParseExact(senet.Value<string>("OdemeTarihi"), "dd.MM.yyyy", null).ToString("yyyy.MM.dd"));
                command.Parameters.AddWithValue("@Miktar" + i, senet.Value<int>("Miktar"));
                command.Parameters.AddWithValue("@SenetNot" + i, senet.Value<string>("SenetNot"));
                i++;
            }
            command.CommandText = command.CommandText.Substring(0, command.CommandText.Length - 1);

            connection.Open();
            command.ExecuteNonQuery();
            connection.Close();
        }

        internal static string SenetBlokAl(string Borclu)
        {
            SqlConnection connection = new SqlConnection(Database.ConnectionString);
            connection.Open();
            SqlCommand command = new SqlCommand("SELECT * FROM SenetBloklari_View WHERE Borclu = @Borclu ORDER BY AddDate DESC", connection);
            command.Parameters.AddWithValue("Borclu", Borclu);
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

                //jo["KefilTelefonlari"].Replace(new JArray(jo["KefilTelefonlari"].Value<string>().Split(new string[] { "/*/" }, StringSplitOptions.RemoveEmptyEntries)));
                //jo["SenetiImzalayanTelefonlari"].Replace(new JArray(jo["SenetiImzalayanTelefonlari"].Value<string>().Split(new string[] { "/*/" }, StringSplitOptions.RemoveEmptyEntries)));
                ja.Add(jo);
            }
            reader.Close();
            connection.Close();
            return JsonConvert.SerializeObject(ja);
        }

        internal static void SenetProfilNotKaydet(string ContactID, string Not)
        {
            SqlConnection connection = new SqlConnection(Database.ConnectionString);
            connection.Open();
            SqlCommand command = new SqlCommand(String.Format("UPDATE Iletisim SET SenetNot='{0}' WHERE ContactUID='{1}'", Not.Replace("'", "''"), ContactID), connection);
            command.ExecuteNonQuery();
            connection.Close();
        }

        internal static string SenetDuzenle(string DuzenlenenSenetler, string EklenenSenetler, string SilinenSenetler, string BlokBilgileri, string SenetBlokID)
        {
            StringBuilder commandString = new StringBuilder();
            JArray duzenlenenSenetler = JsonConvert.DeserializeObject<JArray>(DuzenlenenSenetler);
            foreach (JToken senet in duzenlenenSenetler.Children())
            {
                commandString.AppendFormat("UPDATE SenetBloklari SET Miktar={0}, Odenen={1}, OdemeTarihi='{2}', SenetNot='{3}',SenetBlokNo={5}  WHERE SenetID='{4}'; ",
                    senet.Value<int>("Miktar"),
                    senet.Value<int>("Odenen"),
                    DateTime.ParseExact(senet.Value<string>("OdemeTarihi"), "dd.MM.yyyy", null).ToString("yyyy.MM.dd"),
                    senet.Value<string>("Not").Replace("'", "''"),
                    senet.Value<string>("SenetID"),
                    senet.Value<string>("SenetBlokNo")
                    );
            }
            JArray eklenenSenetler = JsonConvert.DeserializeObject<JArray>(EklenenSenetler);
            foreach (JToken senet in eklenenSenetler)
            {
                commandString.AppendFormat("INSERT INTO SenetBloklari(Borclu, Kefil, SenetiImzalayan, SenetBlokID, AlacakTipi, VadeOrani, SenetOlusturulmaTarihi, SenetBlokNot, AracPlakasi, AracBasligi, SenetID, SenetBlokNo, Miktar, Odenen, OdemeTarihi, SenetNot) SELECT TOP 1 Borclu, Kefil, SenetiImzalayan, SenetBlokID, AlacakTipi, VadeOrani, SenetOlusturulmaTarihi, SenetBlokNot, AracPlakasi, AracBasligi, {0}, '{1}', {2}, {3}, '{4}', '{5}' from SenetBloklari where SenetBlokID = '{6}'; ",
                    "NEWID()",
                    senet.Value<string>("SenetBlokNo"),
                    senet.Value<int>("Miktar"),
                    senet.Value<int>("Odenen"),
                    DateTime.ParseExact(senet.Value<string>("OdemeTarihi"), "dd.MM.yyyy", null).ToString("yyyy.MM.dd"),
                    senet.Value<string>("Not").Replace("'", "''"),
                    SenetBlokID
                    );
            }
            JArray silinenSenetler = JsonConvert.DeserializeObject<JArray>(SilinenSenetler);
            if (silinenSenetler.Count > 0)
            {
                StringBuilder silinenIDs = new StringBuilder();
                foreach (JToken senet in silinenSenetler.Children())
                {
                    silinenIDs.AppendFormat("'{0}',", senet.Value<string>("SenetID"));
                }
                silinenIDs.Remove(silinenIDs.Length - 1, 1);
                commandString.AppendFormat("DELETE FROM SenetBloklari WHERE SenetID IN ({0}); ", silinenIDs.ToString());
            }
            JObject blokBilgileri = JsonConvert.DeserializeObject<JObject>(BlokBilgileri);
            commandString.AppendFormat("UPDATE SenetBloklari SET AlacakTipi = {0}, Kefil = @Kefil WHERE SenetBlokID = @SenetBlokID", Globals.IsNullOrEmpty(blokBilgileri["AlacakTipi"]) ? "AlacakTipi" : "@AlacakTipi");

            SqlConnection connection = new SqlConnection(Database.ConnectionString);
            SqlCommand command = new SqlCommand(commandString.ToString(), connection);
            command.Parameters.AddWithValue("SenetBlokID", SenetBlokID);
            if (!Globals.IsNullOrEmpty(blokBilgileri["AlacakTipi"]))
                command.Parameters.AddWithValue("AlacakTipi", blokBilgileri["AlacakTipi"].ToString());
            command.Parameters.AddWithValue("Kefil", blokBilgileri["Kefil"].ToString());
            connection.Open();
            command.ExecuteNonQuery();

            SqlCommand command2 = new SqlCommand("SELECT * FROM SenetBloklari_View WHERE SenetBlokID = @SenetBlokID ORDER BY OdemeTarihi", connection);
            command2.Parameters.AddWithValue("SenetBlokID", SenetBlokID);
            SqlDataReader reader = command2.ExecuteReader();
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
                jo["KefilTelefonlari"].Replace(new JArray(jo["KefilTelefonlari"].Value<string>().Split(new string[] { "/*/" }, StringSplitOptions.RemoveEmptyEntries)));
                //jo["SenetiImzalayanTelefonlari"].Replace(new JArray(jo["SenetiImzalayanTelefonlari"].Value<string>().Split(new string[] { "/*/" }, StringSplitOptions.RemoveEmptyEntries)));
                ja.Add(jo);
            }
            reader.Close();
            connection.Close();
            return JsonConvert.SerializeObject(ja);
        }

        internal static string SenetRiskiAl(string ContactUID)
        {
            SqlConnection connection = new SqlConnection(Database.ConnectionString);
            connection.Open();
            SqlCommand command = new SqlCommand("SELECT dbo.SenetRiskiHesapla(@ContactUID)", connection);
            command.Parameters.AddWithValue("ContactUID", ContactUID);
            SqlDataReader reader = command.ExecuteReader();
            reader.Read();
            string toplamSenetRiski = reader[0].ToString();
            connection.Close();
            return toplamSenetRiski.Length > 0 ? toplamSenetRiski : "0";
        }

        internal static void SenetBlokNotKaydet(string SenetBlokID, string Not)
        {
            SqlConnection connection = new SqlConnection(Database.ConnectionString);
            connection.Open();
            SqlCommand command = new SqlCommand(String.Format("UPDATE SenetBloklari SET SenetBlokNot='{0}' WHERE SenetBlokID='{1}'", Not.Replace("'", "''"), SenetBlokID), connection);
            command.ExecuteNonQuery();
            connection.Close();
        }

        internal static void SenetBlokSil(string SenetBlokID)
        {
            SqlConnection connection = new SqlConnection(Database.ConnectionString);
            connection.Open();
            SqlCommand command = new SqlCommand(String.Format("DELETE FROM SenetBloklari WHERE SenetBlokID = '{0}'", SenetBlokID), connection);
            command.ExecuteNonQuery();
        }




        internal static class Filtre
        {
            internal static string TarihiGecmis()
            {
                SqlConnection connection = new SqlConnection(Database.ConnectionString);
                connection.Open();
                SqlCommand command = new SqlCommand("SELECT * FROM SenetBloklari_View WHERE OdemeTarihi <= GETDATE() AND Kalan > 0 ORDER BY OdemeTarihi", connection);
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
                    jo["KefilTelefonlari"].Replace(new JArray(jo["KefilTelefonlari"].Value<string>().Split(new string[] { "/*/" }, StringSplitOptions.RemoveEmptyEntries)));
                    jo["SenetiImzalayanTelefonlari"].Replace(new JArray(jo["SenetiImzalayanTelefonlari"].Value<string>().Split(new string[] { "/*/" }, StringSplitOptions.RemoveEmptyEntries)));
                    jo["BorcluTelefonlari"].Replace(new JArray(jo["BorcluTelefonlari"].Value<string>().Split(new string[] { "/*/" }, StringSplitOptions.RemoveEmptyEntries)));
                    ja.Add(jo);
                }
                reader.Close();
                connection.Close();
                return JsonConvert.SerializeObject(ja);
            }

            internal static string TarihAraligi(string BasTarih, string SonTarih)
            {
                SqlConnection connection = new SqlConnection(Database.ConnectionString);
                connection.Open();

                DateTime _temp;
                string basStr = DateTime.TryParse(BasTarih, out _temp) ? "@tbas" : "(SELECT MIN(OdemeTarihi) FROM SenetBloklari_View)";
                string sonStr = DateTime.TryParse(SonTarih, out _temp) ? "@tson" : "(SELECT MAX(OdemeTarihi) FROM SenetBloklari_View)";
                SqlCommand command = new SqlCommand(String.Format("SELECT * FROM SenetBloklari_View WHERE OdemeTarihi >= {0} AND OdemeTarihi <= {1} ORDER BY OdemeTarihi", basStr, sonStr), connection);
                command.Parameters.AddWithValue("tbas", BasTarih);
                command.Parameters.AddWithValue("tson", SonTarih);
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
                    jo["KefilTelefonlari"].Replace(new JArray(jo["KefilTelefonlari"].Value<string>().Split(new string[] { "/*/" }, StringSplitOptions.RemoveEmptyEntries)));
                    jo["SenetiImzalayanTelefonlari"].Replace(new JArray(jo["SenetiImzalayanTelefonlari"].Value<string>().Split(new string[] { "/*/" }, StringSplitOptions.RemoveEmptyEntries)));
                    jo["BorcluTelefonlari"].Replace(new JArray(jo["BorcluTelefonlari"].Value<string>().Split(new string[] { "/*/" }, StringSplitOptions.RemoveEmptyEntries)));
                    ja.Add(jo);
                }
                reader.Close();
                connection.Close();
                return JsonConvert.SerializeObject(ja);
            }

            internal static string AlacakTipi(string AlacakTipi)
            {
                SqlConnection connection = new SqlConnection(Database.ConnectionString);
                connection.Open();
                SqlCommand command = new SqlCommand("SELECT * FROM SenetBloklari_View WHERE [AlacakTipi] LIKE '%' + @AlacakTipi + '%' ORDER BY OdemeTarihi", connection);
                command.Parameters.AddWithValue("AlacakTipi", AlacakTipi);
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
                    jo["KefilTelefonlari"].Replace(new JArray(jo["KefilTelefonlari"].Value<string>().Split(new string[] { "/*/" }, StringSplitOptions.RemoveEmptyEntries)));
                    jo["SenetiImzalayanTelefonlari"].Replace(new JArray(jo["SenetiImzalayanTelefonlari"].Value<string>().Split(new string[] { "/*/" }, StringSplitOptions.RemoveEmptyEntries)));
                    jo["BorcluTelefonlari"].Replace(new JArray(jo["BorcluTelefonlari"].Value<string>().Split(new string[] { "/*/" }, StringSplitOptions.RemoveEmptyEntries)));
                    ja.Add(jo);
                }
                reader.Close();
                connection.Close();
                return JsonConvert.SerializeObject(ja);
            }

            internal static string AlacakTipiOzet()
            {
                SqlConnection connection = new SqlConnection(Database.ConnectionString);
                connection.Open();
                SqlCommand command = new SqlCommand("SELECT * FROM AlacakTipineGoreSenetBorclari_View", connection);
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