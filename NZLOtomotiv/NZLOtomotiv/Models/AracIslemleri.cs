using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System;
using NZLOtomotiv.Controllers;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;

namespace NZLOtomotiv.Models
{
    public static class AracIslemleri
    
    {

        internal static int AracMaliyetKontrol(string KasaFoyuId)
        {
            SqlConnection connection = new SqlConnection(Database.ConnectionString);
            SqlCommand command = new SqlCommand();
            command.Connection = connection;

            command.CommandText = "SELECT KasaFoyuId FROM AracMaliyet ";       
            connection.Open();
            SqlDataReader reader = command.ExecuteReader();
            int kontrol = 0;
            while (reader.Read())
            {
                if (reader["KasaFoyuId"].ToString() == KasaFoyuId)
                {
                    kontrol = 1;
                    return kontrol;
                }

            }
            connection.Close();
            reader.Close();
            return kontrol;
        }

        internal static string AracMaliyetEkle(string AracUID,string Maliyet,string KasaFoyuId)
        {
            int sonuc = AracMaliyetKontrol(KasaFoyuId);
               
            if (sonuc==0)
            {
                SqlConnection connection = new SqlConnection(Database.ConnectionString);
                SqlCommand command = new SqlCommand();
                command.Connection = connection;
                command.CommandText = "INSERT INTO AracMaliyet  (AracUID,  Maliyet,  Tarih,KasaFoyuId) ";
                command.CommandText += "VALUES(@AracUID, @Maliyet, @Tarih,@KasaFoyuId) ;";
                command.CommandText += "UPDATE KasaFoyu SET AltTip='Araç Maliyeti' WHERE id=@KasaFoyuId";               
                command.Parameters.AddWithValue("AracUID", AracUID);
                command.Parameters.AddWithValue("Maliyet", Maliyet);
                command.Parameters.AddWithValue("Tarih", DateTime.Now);              
                command.Parameters.AddWithValue("KasaFoyuId", KasaFoyuId);
                connection.Open();
                command.ExecuteNonQuery();
                connection.Close();               
                connection.Dispose();
                return "Ok";
            }
            else
            {
                return "Var";
            }
           
           
        }


        internal static string AracAra(string Data)
        {
            /*
             *  Araclar_View Metni
                SELECT * FROM Araclar
                LEFT JOIN (SELECT ContactUID, Ad AS RuhsatSahibiAd, Type AS RuhsatSahibiType, KimlikNo AS RuhsatSahibiKimlikNo, Adresler AS RuhsatSahibiAdresler, Telefonlar AS RuhsatSahibiTelefon, VergiDairesi AS RuhsatSahibiVergiDairesi, VergiNo AS RuhsatSahibiVergiNo FROM Iletisim) AS ruhsat ON araclar.RuhsatSahibi = ruhsat.ContactUID 
                LEFT JOIN (SELECT ContactUID, Ad AS AliciAd, Type AS AliciType, KimlikNo AS AliciKimlikNo, Adresler AS AliciAdres, Telefonlar AS AliciTelefon, VergiDairesi AS AliciVergiDairesi, VergiNo AS AliciVergiNo FROM Iletisim) AS alici ON araclar.Alici = alici.ContactUID
                LEFT JOIN (SELECT ContactUID, Ad AS SaticiAd, Type AS SaticiType, KimlikNo AS SaticiKimlikNo, Adresler AS SaticiAdres, Telefonlar AS SaticiTelefon, VergiDairesi AS SaticiVergiDairesi, VergiNo AS SaticiVergiNo FROM Iletisim) AS satici ON araclar.Satici = satici.ContactUID
                LEFT JOIN (SELECT ContactUID, Ad AS SahitAd, Type AS SahitType, KimlikNo AS SahitKimlikNo, Adresler AS SahitAdres, Telefonlar AS SahitTelefon, VergiDairesi AS SahitVergiDairesi, VergiNo AS SahitVergiNo FROM Iletisim) AS sahit ON araclar.Sahit = sahit.ContactUID
                LEFT JOIN (SELECT AracUID, VekaletBitisTarihi FROM Vekaletler) AS vekalet ON araclar.AracUID = vekalet.AracUID
             */
            JArray parameters = (JArray)JsonConvert.DeserializeObject(Data);
            SqlConnection connection = new SqlConnection(Database.ConnectionString);
            SqlCommand command = new SqlCommand();
            command.Connection = connection;
            command.CommandText = "SELECT * FROM Araclar_View";

            if (!Globals.IsNullOrEmpty(parameters))
            {
                int i = 0;
                command.CommandText += " WHERE ";
                foreach (JToken parameter in parameters.Children())
                {
                    
                    string paramname = "value" + i.ToString();
                    command.CommandText += ProcessSearchParameter(parameter.Value<JObject>(), paramname) + " AND ";
                    command.Parameters.AddWithValue(paramname, parameter.Value<string>("value"));
                    i++;
                }
                command.CommandText += " 1=1 ";
            }

            JArray ja = new JArray();
            connection.Open();
            SqlDataReader reader = command.ExecuteReader();
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
                    else if (reader.GetDataTypeName(i) == "bit")
                    {
                        jo.Add(reader.GetName(i), reader.GetBoolean(i));
                    }
                    else
                    {
                        jo.Add(reader.GetName(i), reader[i].ToString());
                    }
                }
                if (!Globals.IsNullOrEmpty(jo["SaticiTelefon"]))
                    jo["SaticiTelefon"].Replace(new JArray(jo["SaticiTelefon"].Value<string>().Split(new string[] { "/*/" }, StringSplitOptions.RemoveEmptyEntries)));
                if (!Globals.IsNullOrEmpty(jo["SaticiAdres"]))
                    jo["SaticiAdres"].Replace(new JArray(jo["SaticiAdres"].Value<string>().Split(new string[] { "/*/" }, StringSplitOptions.RemoveEmptyEntries)));
                if (!Globals.IsNullOrEmpty(jo["AliciTelefon"]))
                    jo["AliciTelefon"].Replace(new JArray(jo["AliciTelefon"].Value<string>().Split(new string[] { "/*/" }, StringSplitOptions.RemoveEmptyEntries)));
                if (!Globals.IsNullOrEmpty(jo["AliciAdres"]))
                    jo["AliciAdres"].Replace(new JArray(jo["AliciAdres"].Value<string>().Split(new string[] { "/*/" }, StringSplitOptions.RemoveEmptyEntries)));
                if (!Globals.IsNullOrEmpty(jo["SahitTelefon"]))
                    jo["SahitTelefon"].Replace(new JArray(jo["SahitTelefon"].Value<string>().Split(new string[] { "/*/" }, StringSplitOptions.RemoveEmptyEntries)));
                if (!Globals.IsNullOrEmpty(jo["SahitAdres"]))
                    jo["SahitAdres"].Replace(new JArray(jo["SahitAdres"].Value<string>().Split(new string[] { "/*/" }, StringSplitOptions.RemoveEmptyEntries)));
                if (!Globals.IsNullOrEmpty(jo["RuhsatSahibiTelefon"]))
                    jo["RuhsatSahibiTelefon"].Replace(new JArray(jo["RuhsatSahibiTelefon"].Value<string>().Split(new string[] { "/*/" }, StringSplitOptions.RemoveEmptyEntries)));
                if (!Globals.IsNullOrEmpty(jo["RuhsatSahibiAdres"]))
                    jo["RuhsatSahibiAdres"].Replace(new JArray(jo["RuhsatSahibiAdres"].Value<string>().Split(new string[] { "/*/" }, StringSplitOptions.RemoveEmptyEntries)));
                JArray resimler = new JArray();
                try
                {
                    FileInfo[] fi = new DirectoryInfo(AppDomain.CurrentDomain.BaseDirectory + "/Data/AracResimleri/" + jo.Value<string>("AracUID")).GetFiles("*.*", SearchOption.TopDirectoryOnly);
                    foreach (FileInfo file in fi)
                    {
                        string ext = file.Extension.ToUpper(new System.Globalization.CultureInfo("en-US", true));
                        if (ext == ".JPG" || ext == ".GIF" || ext == ".JPEG" || ext == ".PNG")
                        {
                            resimler.Add(file.Name);
                        }
                    }

                }
                catch (Exception)
                {

                }
                jo.Add("Resimler", resimler);
                ja.Add(jo);
            }
            reader.Close();
            connection.Close();
            return JsonConvert.SerializeObject(ja);
        }

        private static string ProcessSearchParameter(JObject parameter, string valParamName)
        {
            string field = parameter.Value<string>("field");
            string op = parameter.Value<string>("operator");
            string result = field;
            switch (op)
            {
                default:
                    break;
                case "=":
                    result += " = {0} ";
                    break;
                case "!=":
                    result += " != {0} ";
                    break;
                case "%":
                    result += " LIKE '%{0}%' ";
                    break;
                case "!%":
                    result += " NOT LIKE '%{0}%' ";
                    break;
                case ">":
                    result += " > {0} ";
                    break;
                case "<":
                    result += " < {0} ";
                    break;
                case ">=":
                    result += " >= {0} ";
                    break;
                case "<=":
                    result += " <= {0} ";
                    break;
            }
            result = String.Format(result, "@" + valParamName);
            return result;
        }


        internal static void AracSil(string AracUID)
        {

            SqlConnection connection = new SqlConnection(Database.ConnectionString);
            SqlCommand command = new SqlCommand();
            command.Connection = connection;
            command.CommandText = "DELETE FROM Araclar WHERE AracUID = @AracUID ;";
            command.Parameters.AddWithValue("AracUID", AracUID);
            command.CommandText += "DELETE FROM Vekaletler WHERE AracUID = @AracUID2 ;";
            command.Parameters.AddWithValue("AracUID2", AracUID);
            command.CommandText += "DELETE FROM Tadilatlar WHERE Arac_ID = @AracUID3 ;";
            command.Parameters.AddWithValue("AracUID3", AracUID);
            connection.Open();
            command.ExecuteNonQuery();
             
            connection.Close();
            connection.Dispose();
            
        }

        internal static string AracDuzenle(string Data)
        {
            JObject parameters = (JObject)JsonConvert.DeserializeObject(Data);
            SqlConnection connection = new SqlConnection(Database.ConnectionString);
            SqlCommand command = new SqlCommand();
            command.Connection = connection;
            command.CommandText = "Update Araclar Set Plaka=@Plaka ,Marka=@Marka,  Seri=@Seri,   Model=@Model,  Renk=@Renk,   Yil=@Yil,    KM=@KM,     YakitTipi=@Yakit, VitesTipi=@Vites,   Kapi=@Kapi,   Cekis=@Cekis,  MotorHacmi=@MotorHacim,     MotorGucu=@MotorGuc,  MotorNo=@MotorNo,    SasiNo=@SasiNo,     AlinisTarihi=@AlinisTarih,   AlinisFiyati=@AlinisFiyat,   Liste=@Liste,  Durum=@Durum,  EtiketFiyati=@Etiket,   RuhsatSahibi=@Ruhsat,   Satici=@Satici, YedekAnahtar=@YedekAnahtar, AracMuayeneBitisTarihi=@AracMuayeneBitisTarihi, AracSigortaBitisTarihi=@AracSigortaBitisTarihi Where AracUID=@AracUID ;";
            command.Parameters.AddWithValue("AracUID", parameters.Value<string>("AracUID"));
            command.Parameters.AddWithValue("Plaka", parameters.Value<string>("Plaka"));
            command.Parameters.AddWithValue("Marka", parameters.Value<string>("Marka"));
            command.Parameters.AddWithValue("Seri", parameters.Value<string>("Seri"));
            command.Parameters.AddWithValue("Model", parameters.Value<string>("Model"));
            command.Parameters.AddWithValue("Renk", parameters.Value<string>("Renk"));
            command.Parameters.AddWithValue("Yil", parameters.Value<string>("Yil"));
            command.Parameters.AddWithValue("KM", parameters.Value<string>("KM"));
            command.Parameters.AddWithValue("Yakit", parameters.Value<string>("Yakit"));
            command.Parameters.AddWithValue("Vites", parameters.Value<string>("Vites"));
            command.Parameters.AddWithValue("Kapi", parameters.Value<string>("Kapi"));
            command.Parameters.AddWithValue("Cekis", parameters.Value<string>("Cekis"));
            command.Parameters.AddWithValue("MotorHacim", parameters.Value<string>("MotorHacim"));
            command.Parameters.AddWithValue("MotorGuc", parameters.Value<string>("MotorGuc"));
            command.Parameters.AddWithValue("MotorNo", parameters.Value<string>("MotorNo"));
            command.Parameters.AddWithValue("SasiNo", parameters.Value<string>("SasiNo"));
            command.Parameters.AddWithValue("AlinisTarih", Globals.IsNullOrEmpty(parameters.Value<string>("AlinisTarih")) ? (object)DBNull.Value : DateTime.ParseExact(parameters.Value<string>("AlinisTarih"), "dd.MM.yyyy", null).ToString("yyyy/MM/dd"));
            command.Parameters.AddWithValue("AlinisFiyat", parameters.Value<string>("AlinisFiyat"));
            command.Parameters.AddWithValue("Liste", parameters.Value<string>("Liste"));
            command.Parameters.AddWithValue("Durum", parameters.Value<string>("Durum"));
            command.Parameters.AddWithValue("Etiket", parameters.Value<string>("Etiket"));
            command.Parameters.AddWithValue("Ruhsat", parameters.Value<string>("Ruhsat"));
            command.Parameters.AddWithValue("Satici", parameters.Value<string>("Satici"));
            command.Parameters.AddWithValue("YedekAnahtar", parameters.Value<string>("YedekAnahtar"));
            command.Parameters.AddWithValue("AracMuayeneBitisTarihi", Globals.IsNullOrEmpty(parameters.Value<string>("AracMuayeneBitisTarihi")) ? (object)DBNull.Value : DateTime.ParseExact(parameters.Value<string>("AracMuayeneBitisTarihi"), "dd.MM.yyyy", null).ToString("yyyy/MM/dd"));
            command.Parameters.AddWithValue("AracSigortaBitisTarihi", Globals.IsNullOrEmpty(parameters.Value<string>("AracSigortaBitisTarihi")) ? (object)DBNull.Value : DateTime.ParseExact(parameters.Value<string>("AracSigortaBitisTarihi"), "dd.MM.yyyy", null).ToString("yyyy/MM/dd"));
          
            if (!Globals.IsNullOrEmpty(parameters.GetValue("VekaletBitis")))
            {

                connection.Open();
                string CONNECTION_QUERY = "SELECT AracUID FROM  Vekaletler";
                int vekaletvarmi=0;
                SqlCommand comand = new SqlCommand(CONNECTION_QUERY, connection);   
                SqlDataReader reader = comand.ExecuteReader();
                while (reader.Read())
                {if (reader["AracUID"].ToString()==parameters.Value<string>("AracUID")) { vekaletvarmi = 1; } }
                reader.Close();
                connection.Close();
                if (vekaletvarmi==1)
                {
                    command.CommandText += "Update Vekaletler Set AracUID=@id, VekaletBitisTarihi=@VekaletBitis";
                    command.Parameters.AddWithValue("VekaletBitis", Globals.IsNullOrEmpty(parameters.Value<string>("VekaletBitis")) ? (object)DBNull.Value : DateTime.ParseExact(parameters.Value<string>("VekaletBitis"), "dd.MM.yyyy", null).ToString("yyyy/MM/dd"));
                    command.Parameters.AddWithValue("id", parameters.Value<string>("AracUID"));
                   
                }
                else
                {
                    command.CommandText += "INSERT INTO Vekaletler (VekaletUID, AracUID, VekaletBitisTarihi) VALUES (NEWID(), @id, @VekaletBitis); ";
                    command.Parameters.AddWithValue("VekaletBitis", Globals.IsNullOrEmpty(parameters.Value<string>("VekaletBitis")) ? (object)DBNull.Value : DateTime.ParseExact(parameters.Value<string>("VekaletBitis"), "dd.MM.yyyy", null).ToString("yyyy/MM/dd"));
                    command.Parameters.AddWithValue("id", parameters.Value<string>("AracUID"));
                }

                
            }

            connection.Open();
            command.ExecuteNonQuery();
            connection.Close();
            connection.Dispose();


            string SA = AracAra2(parameters.Value<string>("AracUID"));

            return SA;
        }

        internal static string AracAra2(string AracUID)
        {
            SqlConnection connection = new SqlConnection(Database.ConnectionString);
            
            connection.Open();
            string CONNECTION_QUERY = "SELECT * FROM Araclar_View WHERE AracUID=@AracUID";

            SqlCommand comand = new SqlCommand(CONNECTION_QUERY, connection);
            comand.Parameters.AddWithValue("@AracUID", AracUID);

            SqlDataReader reader = comand.ExecuteReader();
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
                    else if (reader.GetDataTypeName(i) == "bit")
                    {
                        jo.Add(reader.GetName(i), reader.GetBoolean(i));
                    }
                    else
                    {
                        jo.Add(reader.GetName(i), reader[i].ToString());
                    }
                }
                if (!Globals.IsNullOrEmpty(jo["SaticiTelefon"]))
                    jo["SaticiTelefon"].Replace(new JArray(jo["SaticiTelefon"].Value<string>().Split(new string[] { "/*/" }, StringSplitOptions.RemoveEmptyEntries)));
                if (!Globals.IsNullOrEmpty(jo["SaticiAdres"]))
                    jo["SaticiAdres"].Replace(new JArray(jo["SaticiAdres"].Value<string>().Split(new string[] { "/*/" }, StringSplitOptions.RemoveEmptyEntries)));
                if (!Globals.IsNullOrEmpty(jo["AliciTelefon"]))
                    jo["AliciTelefon"].Replace(new JArray(jo["AliciTelefon"].Value<string>().Split(new string[] { "/*/" }, StringSplitOptions.RemoveEmptyEntries)));
                if (!Globals.IsNullOrEmpty(jo["AliciAdres"]))
                    jo["AliciAdres"].Replace(new JArray(jo["AliciAdres"].Value<string>().Split(new string[] { "/*/" }, StringSplitOptions.RemoveEmptyEntries)));
                if (!Globals.IsNullOrEmpty(jo["SahitTelefon"]))
                    jo["SahitTelefon"].Replace(new JArray(jo["SahitTelefon"].Value<string>().Split(new string[] { "/*/" }, StringSplitOptions.RemoveEmptyEntries)));
                if (!Globals.IsNullOrEmpty(jo["SahitAdres"]))
                    jo["SahitAdres"].Replace(new JArray(jo["SahitAdres"].Value<string>().Split(new string[] { "/*/" }, StringSplitOptions.RemoveEmptyEntries)));
                if (!Globals.IsNullOrEmpty(jo["RuhsatSahibiTelefon"]))
                    jo["RuhsatSahibiTelefon"].Replace(new JArray(jo["RuhsatSahibiTelefon"].Value<string>().Split(new string[] { "/*/" }, StringSplitOptions.RemoveEmptyEntries)));
                if (!Globals.IsNullOrEmpty(jo["RuhsatSahibiAdres"]))
                    jo["RuhsatSahibiAdres"].Replace(new JArray(jo["RuhsatSahibiAdres"].Value<string>().Split(new string[] { "/*/" }, StringSplitOptions.RemoveEmptyEntries)));
                JArray resimler = new JArray();
                try
                {
                    FileInfo[] fi = new DirectoryInfo(AppDomain.CurrentDomain.BaseDirectory + "/Data/AracResimleri/" + jo.Value<string>("AracUID")).GetFiles("*.*", SearchOption.TopDirectoryOnly);
                    foreach (FileInfo file in fi)
                    {
                        string ext = file.Extension.ToUpper(new System.Globalization.CultureInfo("en-US", true));
                        if (ext == ".JPG" || ext == ".GIF" || ext == ".JPEG" || ext == ".PNG")
                        {
                            resimler.Add(file.Name);
                        }
                    }

                }
                catch (Exception)
                {

                }
                jo.Add("Resimler", resimler);
                ja.Add(jo);
            }
            reader.Close();
            connection.Close();
            string SA = JsonConvert.SerializeObject(ja);

            return SA;
        }

        internal static string AracKaydet(string Data)
        {
            JObject parameters = (JObject)JsonConvert.DeserializeObject(Data);
            string guid = Guid.NewGuid().ToString();

            SqlConnection connection = new SqlConnection(Database.ConnectionString);
            SqlCommand command = new SqlCommand();
            command.Connection = connection;
            command.CommandText = "INSERT INTO Araclar  (AracUID,  Plaka,  Marka,  Seri,   Model,  Renk,   Yil,    KM,     YakitTipi, VitesTipi,   Kapi,   Cekis,  MotorHacmi,     MotorGucu,  MotorNo,    SasiNo,     AlinisTarihi,   AlinisFiyati,   Liste,  Durum,  EtiketFiyati,   RuhsatSahibi,   Satici, YedekAnahtar, AracMuayeneBitisTarihi,AracSigortaBitisTarihi) ";
            command.CommandText += "VALUES              (@id,      @Plaka, @Marka, @Seri,  @Model, @Renk,  @Yil,   @KM,    @Yakit,    @Vites,      @Kapi,  @Cekis, @MotorHacim,    @MotorGuc,  @MotorNo,   @SasiNo,    @AlinisTarih,   @AlinisFiyat,   @Liste, @Durum, @Etiket,        @Ruhsat,        @Satici,@YedekAnahtar,@AracMuayeneBitisTarihi,@AracSigortaBitisTarihi) ;";
            command.Parameters.AddWithValue("id", guid);
            command.Parameters.AddWithValue("Plaka", parameters.Value<string>("Plaka"));
            command.Parameters.AddWithValue("Marka", parameters.Value<string>("Marka"));
            command.Parameters.AddWithValue("Seri", parameters.Value<string>("Seri"));
            command.Parameters.AddWithValue("Model", parameters.Value<string>("Model"));
            command.Parameters.AddWithValue("Renk", parameters.Value<string>("Renk"));
            command.Parameters.AddWithValue("Yil", parameters.Value<string>("Yil"));
            command.Parameters.AddWithValue("KM", parameters.Value<string>("KM"));
            command.Parameters.AddWithValue("Yakit", parameters.Value<string>("Yakit"));
            command.Parameters.AddWithValue("Vites", parameters.Value<string>("Vites"));
            command.Parameters.AddWithValue("Kapi", parameters.Value<string>("Kapi"));
            command.Parameters.AddWithValue("Cekis", parameters.Value<string>("Cekis"));
            command.Parameters.AddWithValue("MotorHacim", parameters.Value<string>("MotorHacim"));
            command.Parameters.AddWithValue("MotorGuc", parameters.Value<string>("MotorGuc"));
            command.Parameters.AddWithValue("MotorNo", parameters.Value<string>("MotorNo"));
            command.Parameters.AddWithValue("SasiNo", parameters.Value<string>("SasiNo"));
            command.Parameters.AddWithValue("AlinisTarih", Globals.IsNullOrEmpty(parameters.Value<string>("AlinisTarih")) ? (object)DBNull.Value : DateTime.ParseExact(parameters.Value<string>("AlinisTarih"), "dd.MM.yyyy", null).ToString("yyyy/MM/dd"));
            command.Parameters.AddWithValue("AlinisFiyat", parameters.Value<string>("AlinisFiyat"));
            command.Parameters.AddWithValue("Liste", parameters.Value<string>("Liste"));
            command.Parameters.AddWithValue("Durum", parameters.Value<string>("Durum"));
            command.Parameters.AddWithValue("Etiket", parameters.Value<string>("Etiket"));
            command.Parameters.AddWithValue("Ruhsat", parameters.Value<string>("Ruhsat"));
            command.Parameters.AddWithValue("Satici", parameters.Value<string>("Satici"));
            command.Parameters.AddWithValue("YedekAnahtar", parameters.Value<string>("YedekAnahtar"));
            command.Parameters.AddWithValue("AracMuayeneBitisTarihi", Globals.IsNullOrEmpty(parameters.Value<string>("AracMuayeneBitisTarihi")) ? (object)DBNull.Value : DateTime.ParseExact(parameters.Value<string>("AracMuayeneBitisTarihi"), "dd.MM.yyyy", null).ToString("yyyy/MM/dd"));
            command.Parameters.AddWithValue("AracSigortaBitisTarihi", Globals.IsNullOrEmpty(parameters.Value<string>("AracSigortaBitisTarihi")) ? (object)DBNull.Value : DateTime.ParseExact(parameters.Value<string>("AracSigortaBitisTarihi"), "dd.MM.yyyy", null).ToString("yyyy/MM/dd"));
           
           

            if (!Globals.IsNullOrEmpty(parameters.GetValue("VekaletBitis")))
            {
                command.CommandText += "INSERT INTO Vekaletler (VekaletUID, AracUID, VekaletBitisTarihi) VALUES (NEWID(), @id, @VekaletBitis); ";
                command.Parameters.AddWithValue("VekaletBitis", Globals.IsNullOrEmpty(parameters.Value<string>("VekaletBitis")) ? (object)DBNull.Value : DateTime.ParseExact(parameters.Value<string>("VekaletBitis"), "dd.MM.yyyy", null).ToString("yyyy/MM/dd"));
            }

            command.CommandText += "INSERT INTO Tadilatlar(Tamamlanmis, Arac_ID, Manuel_Veri) VALUES (0, @id, 0); ";
            connection.Open();
            command.ExecuteNonQuery();
            connection.Close();
            connection.Dispose();

            string SA = AracAra2(guid);

            return SA;
        }

        internal static void AracSatisYap(string Data)
        {
            JObject parameters = (JObject)JsonConvert.DeserializeObject(Data);
            JToken AracID, AliciID, SatisFiyati, SatisTarihi, NoterDevirTarihi, ResmiSatisFiyati;

            parameters.TryGetValue("AracID", out AracID);
            parameters.TryGetValue("AliciID", out AliciID);
            parameters.TryGetValue("SatisFiyati", out SatisFiyati);
            parameters.TryGetValue("SatisTarihi", out SatisTarihi);
            parameters.TryGetValue("NoterDevirTarihi", out NoterDevirTarihi);
            parameters.TryGetValue("ResmiSatisFiyati", out ResmiSatisFiyati);

            StringBuilder query = new StringBuilder("USE NazliOtomotiv; ");
            query.AppendFormat("UPDATE Araclar SET Arac_Durumu = 'Satışı Yapılmış Araç', Alici_ID = '{0}', Satis_Fiyati = {1}, Satis_Tarihi = '{2}', Noter_Devir_Tarihi='{3}', Resmi_Satis_Fiyati={4} ",
                AliciID.ToString(),
                SatisFiyati.ToString(),
                DateTime.ParseExact(SatisTarihi.ToString(), "dd.MM.yyyy", null).ToString("yyyy.MM.dd"),
                DateTime.ParseExact(NoterDevirTarihi.ToString(), "dd.MM.yyyy", null).ToString("yyyy.MM.dd"),
                ResmiSatisFiyati.ToString());
            query.AppendFormat("WHERE Arac_Uid = '{0}'", AracID.ToString());

            SqlConnection connection = new SqlConnection(Database.ConnectionString);
            connection.Open();
            SqlCommand command = new SqlCommand(query.ToString(), connection);
            command.ExecuteNonQuery();
            connection.Close();
        }

        internal static void MaliyetEkle(string Data)
        {
            JObject parameters = JObject.Parse(Data);
            JToken Tip, Arac, Miktar;

            parameters.TryGetValue("Tip", out Tip);
            parameters.TryGetValue("Arac", out Arac);
            parameters.TryGetValue("Miktar", out Miktar);

            StringBuilder query = new StringBuilder("USE NazliOtomotiv;");
            query.AppendFormat("INSERT INTO Maliyetler(Maliyet_Tipi, Maliyet_Arac, Maliyet_Miktar, Maliyet_Odeme) VALUES ('{0}', '{1}', '{2}', '{3}')", Tip, Arac, Miktar, 0);

            SqlConnection connection = new SqlConnection(Database.ConnectionString);
            connection.Open();

            SqlCommand command = new SqlCommand(query.ToString(), connection);
            command.ExecuteNonQuery();
            connection.Close();
        }
        #region Maliyetler OLD
        //internal static JArray MaliyetleriGoruntule(string Data)
        //{
        //    JArray ReturnArray = new JArray();
        //    using (SqlConnection connection = new SqlConnection(Database.ConnectionString))
        //    {
        //        connection.Open();

        //        using (SqlCommand command = new SqlCommand("SELECT * FROM Maliyetler LEFT JOIN (SELECT Marka, Seri, Model, Arac_Uid, Plaka FROM Araclar) AS Arac ON Arac.Arac_Uid = Maliyet_Arac WHERE Maliyet_Tipi = @Maliyet_Tipi", connection))
        //        {
        //            command.Parameters.AddWithValue("Maliyet_Tipi", Data);
        //            using (SqlDataReader commandReader = command.ExecuteReader())
        //            {
        //                while (commandReader.Read())
        //                {
        //                    JObject ReturnObject = new JObject();
        //                    ReturnObject.Add("id", commandReader["id"].ToString());
        //                    ReturnObject.Add("Maliyet_Tipi", commandReader["Maliyet_Tipi"].ToString());
        //                    ReturnObject.Add("Maliyet_Odeme", commandReader["Maliyet_Odeme"].ToString());
        //                    ReturnObject.Add("Maliyet_Value", commandReader["Maliyet_Arac"].ToString());
        //                    ReturnObject.Add("Plaka", commandReader["Plaka"].ToString());
        //                    ReturnObject.Add("Marka", commandReader["Marka"].ToString());
        //                    ReturnObject.Add("Seri", commandReader["Seri"].ToString());
        //                    ReturnObject.Add("Model", commandReader["Model"].ToString());
        //                    ReturnObject.Add("Miktar", commandReader["Maliyet_Miktar"].ToString());
        //                    ReturnArray.Add(ReturnObject);
        //                }
        //                commandReader.Close();
        //            }
        //        }
        //        connection.Close();
        //    }
        //    return ReturnArray;
        //}
        #endregion
        internal static JObject MaliyetleriGoruntule()
        {
            JObject ReturnObject = new JObject();
            JArray MaliyetArray = new JArray();

            using (SqlConnection connect = new SqlConnection(Database.ConnectionString))
            {
                connect.Open();

                #region Maliyet Bilgileri
                using (SqlCommand command = new SqlCommand("SELECT * FROM [Maliyetler] LEFT JOIN (SELECT * FROM Araclar) AS ARAC ON ARAC.Arac_Uid = Arac_ID", connect))
                {
                    SqlDataReader commandReader = command.ExecuteReader();
                    while (commandReader.Read())
                    {
                        JObject Obj = new JObject();
                        if (Convert.ToBoolean(commandReader["Manuel_Veri"]))
                        {
                            Obj.Add("Arac_TamAd", commandReader["Manuel_Arac"].ToString());
                        }

                        for (int i = 0; i < commandReader.FieldCount; i++)
                        {
                            try
                            {
                                if (Convert.ToBoolean(commandReader["Manuel_Veri"]) && commandReader.GetName(i) == "Plaka")
                                {
                                    Obj.Add("Plaka", commandReader["Manuel_Plaka"].ToString());
                                    continue;
                                }

                                if (commandReader.GetDataTypeName(i) == "date")
                                {
                                    DateTime date;
                                    Obj.Add(commandReader.GetName(i), DateTime.TryParse(commandReader[i].ToString(), out date) ? date.ToString("dd.MM.yyyy") : "");
                                }
                                else
                                {
                                    Obj.Add(commandReader.GetName(i).ToString(), commandReader[i].ToString());
                                }
                                if (!Convert.ToBoolean(commandReader["Manuel_Veri"]) && i == 1)
                                    Obj.Add("Arac_TamAd", commandReader["Marka"].ToString() + " " + commandReader["Seri"].ToString() + " " + commandReader["Model"].ToString());
                            }
                            catch
                            { }
                        }
                        MaliyetArray.Add(Obj);
                    }
                    commandReader.Close();
                }

                #endregion
                #region Tarihler
                using (SqlCommand command = new SqlCommand("SELECT " +
                                                                "(SELECT TOP 1 Kesim_KaportaBoya FROM Maliyetler WHERE CAST(Kesim_KaportaBoya AS date) < GETDATE()) AS 'Kesim_KaportaBoya'," +
                                                                "(SELECT TOP 1 Kesim_Yikama FROM Maliyetler WHERE CAST(Kesim_Yikama AS date) < GETDATE()) AS 'Kesim_Yikama'," +
                                                                "(SELECT TOP 1 Kesim_Mekanik FROM Maliyetler WHERE CAST(Kesim_Mekanik AS date) < GETDATE()) AS 'Kesim_Mekanik'", connect))
                {
                    SqlDataReader commandReader = command.ExecuteReader();
                    while (commandReader.Read())
                    {
                        ReturnObject.Add("Kesim_KaportaBoya", commandReader["Kesim_KaportaBoya"].ToString() == "" ? "" : DateTime.Parse(commandReader["Kesim_KaportaBoya"].ToString()).ToString("dd/MM/yyyy"));
                        ReturnObject.Add("Kesim_Yikama", commandReader["Kesim_Yikama"].ToString() == "" ? "" : DateTime.Parse(commandReader["Kesim_Yikama"].ToString()).ToString("dd/MM/yyyy"));
                        ReturnObject.Add("Kesim_Mekanik", commandReader["Kesim_Mekanik"].ToString() == "" ? "" : DateTime.Parse(commandReader["Kesim_Mekanik"].ToString()).ToString("dd/MM/yyyy"));
                    }
                    commandReader.Close();
                }
                #endregion

                connect.Close();
            }
            ReturnObject.Add("Veriler", MaliyetArray);
            return ReturnObject;
        }

        internal static void MaliyetManuelAracKayit(string Data)
        {
            JObject parameters = JObject.Parse(Data);
            JToken Manuel_Veri, Manuel_Plaka, Manuel_Arac, Manuel_KaportaBoya, Manuel_Yikama, Manuel_Mekanik;

            parameters.TryGetValue("Manuel_Veri", out Manuel_Veri);
            parameters.TryGetValue("Manuel_Plaka", out Manuel_Plaka);
            parameters.TryGetValue("Manuel_Arac", out Manuel_Arac);
            parameters.TryGetValue("Manuel_KaportaBoya", out Manuel_KaportaBoya);
            parameters.TryGetValue("Manuel_Yikama", out Manuel_Yikama);
            parameters.TryGetValue("Manuel_Mekanik", out Manuel_Mekanik);


            using (SqlConnection connect = new SqlConnection(Database.ConnectionString))
            {
                connect.Open();

                using (SqlCommand command = new SqlCommand("INSERT INTO Maliyetler(Arac_ID, Manuel_Veri, Manuel_Plaka, Manuel_Arac, Maliyet_KaportaBoya, Maliyet_Yikama, Maliyet_Mekanik, Hesap_KaportaBoya, Hesap_Yikama, Hesap_Mekanik) " +
                    "VALUES(@Arac_ID, @Manuel_Veri, @Manuel_Plaka, @Manuel_Arac, @Maliyet_KaportaBoya, @Maliyet_Yikama, @Maliyet_Mekanik, @Hesap_KaportaBoya, @Hesap_Yikama, @Hesap_Mekanik)", connect))
                {
                    command.Parameters.AddWithValue("Arac_ID", "0");
                    command.Parameters.AddWithValue("Manuel_Veri", 1);
                    command.Parameters.AddWithValue("Manuel_Plaka", Manuel_Plaka.ToString());
                    command.Parameters.AddWithValue("Manuel_Arac", Manuel_Arac.ToString());
                    command.Parameters.AddWithValue("Maliyet_KaportaBoya", Manuel_KaportaBoya == null ? "" : Manuel_KaportaBoya.ToString());
                    command.Parameters.AddWithValue("Maliyet_Yikama", Manuel_Yikama == null ? "" : Manuel_Yikama.ToString());
                    command.Parameters.AddWithValue("Maliyet_Mekanik", Manuel_Mekanik == null ? "" : Manuel_Mekanik.ToString());
                    command.Parameters.AddWithValue("Hesap_KaportaBoya", 0);
                    command.Parameters.AddWithValue("Hesap_Yikama", 0);
                    command.Parameters.AddWithValue("Hesap_Mekanik", 0);

                    command.ExecuteNonQuery();
                }

                connect.Close();
            }

        }

        internal static void MaliyetNotKaydet(string Data)
        {
            JObject parameters = JObject.Parse(Data);
            JToken ID, Column, NotValue;

            parameters.TryGetValue("ID", out ID);
            parameters.TryGetValue("Column", out Column);
            parameters.TryGetValue("NotValue", out NotValue);

            string sColumn = Column.ToString() == "Maliyet_KaportaBoya" ? "Not_KaportaBoya" : Column.ToString() == "Maliyet_Yikama" ? "Not_Yikama" : Column.ToString() == "Maliyet_Mekanik" ? "Not_Mekanik" : "";

            using (SqlConnection connect = new SqlConnection(Database.ConnectionString))
            {
                connect.Open();

                using (SqlCommand command = new SqlCommand("UPDATE Maliyetler SET " + sColumn + "=@NotVerisi WHERE id=@ID", connect))
                {
                    command.Parameters.AddWithValue("NotVerisi", NotValue.ToString());
                    command.Parameters.AddWithValue("ID", Convert.ToInt32(ID.ToString()));

                    command.ExecuteNonQuery();
                }

                connect.Close();
            }
        }

        internal static void MaliyetTemizle(string Tip)
        {
            using (SqlConnection connect = new SqlConnection(Database.ConnectionString))
            {
                connect.Open();

                JArray MevcutMaliyet = new JArray();
                using (SqlCommand command = new SqlCommand("SELECT * FROM Maliyetler WHERE Maliyet_Tipi = @Maliyet_Tipi", connect))
                {
                    command.Parameters.AddWithValue("Maliyet_Tipi", Tip);
                    SqlDataReader commandReader = command.ExecuteReader();
                    while (commandReader.Read())
                    {
                        JObject MaliyetVerisi = new JObject();
                        for (int i = 0; i < commandReader.FieldCount; i++)
                        {

                            if (commandReader.GetDataTypeName(i) == "date")
                            {
                                DateTime date;
                                MaliyetVerisi.Add(commandReader.GetName(i), DateTime.TryParse(commandReader[i].ToString(), out date) ? date.ToString("dd.MM.yyyy") : "");
                            }
                            else
                            {
                                MaliyetVerisi.Add(commandReader.GetName(i).ToString(), commandReader[i].ToString());
                            }
                        }
                        MevcutMaliyet.Add(MaliyetVerisi);
                    }
                    commandReader.Close();
                }
                if (MevcutMaliyet.Count < 1)
                    return;

                using (SqlCommand command = new SqlCommand("SET DATEFORMAT ymd; INSERT INTO MaliyetlerArsiv(ArsivTipi, KayitTarihi, ArsivData) VALUES(@ArsivTipi, @KayitTarihi, @ArsivData)", connect))
                {
                    command.Parameters.AddWithValue("ArsivTipi", Tip); ;
                    command.Parameters.AddWithValue("KayitTarihi", DateTime.Now.ToString("yyyy.MM.dd"));
                    command.Parameters.AddWithValue("ArsivData", MevcutMaliyet.ToString());
                    command.ExecuteNonQuery();
                }

                using (SqlCommand command = new SqlCommand("DELETE FROM Maliyetler WHERE Maliyet_Tipi = @Maliyet_Tipi", connect))
                {
                    command.Parameters.AddWithValue("Maliyet_Tipi", Tip);
                    command.ExecuteNonQuery();
                }

                connect.Close();
            }
        }

        internal static void MaliyetSil(string MaliyetID)
        {
            using (SqlConnection connect = new SqlConnection(Database.ConnectionString))
            {
                connect.Open();

                using (SqlCommand command = new SqlCommand("DELETE FROM Maliyetler WHERE id = @id", connect))
                {
                    command.Parameters.AddWithValue("id", MaliyetID);
                    command.ExecuteNonQuery();
                }

                connect.Close();
            }
        }

        internal static void MaliyetGuncelle(string Data)
        {
            JObject paramaters = JObject.Parse(Data);
            JToken KeyID, KeyTip, KeyValue;

            paramaters.TryGetValue("KeyID", out KeyID);
            paramaters.TryGetValue("KeyTip", out KeyTip);
            paramaters.TryGetValue("KeyValue", out KeyValue);

            string Value = KeyValue.ToString() == null ? "" : KeyValue.ToString();

            using (SqlConnection connect = new SqlConnection(Database.ConnectionString))
            {
                connect.Open();

                using (SqlCommand command = new SqlCommand("UPDATE Maliyetler SET " + KeyTip.ToString() + "= @Value WHERE id=@ID", connect))
                {
                    command.Parameters.AddWithValue("Value", Value);
                    command.Parameters.AddWithValue("ID", KeyID.ToString());

                    command.ExecuteNonQuery();
                }

                connect.Close();
            }
        }


        internal static void MaliyetKaydet(string Data)
        {
            JObject parameters = JObject.Parse(Data);
            JToken VeriID, AracID, KayitTipi, VeriMiktar, VeriNot;

            parameters.TryGetValue("VeriID", out VeriID);
            parameters.TryGetValue("AracID", out AracID);
            parameters.TryGetValue("KayitTipi", out KayitTipi);
            parameters.TryGetValue("VeriMiktar", out VeriMiktar);
            parameters.TryGetValue("VeriNot", out VeriNot);

            string Tip = KayitTipi.ToString() == "Kaporta-Boya" ? "Hesap_KaportaBoya" : KayitTipi.ToString() == "Yıkama" ? "Hesap_Yikama" : KayitTipi.ToString() == "Mekanik" ? "Hesap_Mekanik" : KayitTipi.ToString() == "Diğer" ? "Hesap_Diger" : "";

            using (SqlConnection connect = new SqlConnection(Database.ConnectionString))
            {
                connect.Open();

                using (SqlCommand command = new SqlCommand("SET DATEFORMAT ymd; INSERT INTO Giderler(GiderID, GiderTipi, AracMaliyetTipi, AracID, Gider, Aciklama, Tarih) " +
                                                             "VALUES(@GiderID, @GiderTipi, @AracMaliyetTipi, @AracID, @Gider, @Aciklama, @Tarih)", connect))
                {
                    command.Parameters.AddWithValue("GiderID", Guid.NewGuid().ToString());
                    command.Parameters.AddWithValue("GiderTipi", "Araç Maliyeti");
                    command.Parameters.AddWithValue("AracMaliyetTipi", KayitTipi.ToString());
                    command.Parameters.AddWithValue("AracID", AracID.ToString());
                    command.Parameters.AddWithValue("Gider", Convert.ToInt32(VeriMiktar.ToString()));
                    command.Parameters.AddWithValue("Aciklama", VeriNot.ToString() == "" ? "" : VeriNot.ToString());
                    command.Parameters.AddWithValue("Tarih", DateTime.Now.ToString("yyyy.MM.dd"));

                    command.ExecuteNonQuery();
                }

                if (Tip == "") return;

                using (SqlCommand command = new SqlCommand("UPDATE Maliyetler SET " + Tip + "= @Hesap WHERE id=@ID", connect))
                {
                    command.Parameters.AddWithValue("Hesap", 1);
                    command.Parameters.AddWithValue("ID", Convert.ToInt32(VeriID.ToString()));

                    command.ExecuteNonQuery();
                }

                connect.Close();
            }

        }

        internal static string OpsiyonGuncelle(string Opsiyon, string AracUID, DateTime Opsiyon_Tarihi, string Opsiyon_Koyan)
        {
            

            using (SqlConnection connect = new SqlConnection(Database.ConnectionString))
            {
                string OpsiyonVarmi="";
                connect.Open();
                string CONNECTION_QUERY = "SELECT Opsiyon FROM Araclar_View WHERE AracUID=@AracUID";

                SqlCommand comand = new SqlCommand(CONNECTION_QUERY, connect);
                comand.Parameters.AddWithValue("@AracUID", AracUID);

                SqlDataReader reader = comand.ExecuteReader();
             
                while (reader.Read())
                {

                    OpsiyonVarmi = reader["Opsiyon"].ToString();
                    
                  
                }
                reader.Close();
                connect.Close();

              
                if (OpsiyonVarmi=="True")
                {
                    using (SqlCommand command = new SqlCommand("UPDATE Araclar SET Opsiyon=@Opsiyon, OpsiyonTarihi=@Opsiyon_Tarihi, OpsiyonKoyan=@Opsiyon_Koyan Where AracUID=@AracUID ", connect))
                    {
                        connect.Open();
                        command.Parameters.AddWithValue("Opsiyon", "False");
                        command.Parameters.AddWithValue("Opsiyon_Tarihi", "");
                        command.Parameters.AddWithValue("Opsiyon_Koyan", "");
                        command.Parameters.AddWithValue("AracUID", AracUID);
                        command.ExecuteNonQuery();
                        connect.Close();
                    }
                    return "Var";   
                }
                else
                {
                    using (SqlCommand command = new SqlCommand("UPDATE Araclar SET Opsiyon=@Opsiyon, OpsiyonTarihi=@Opsiyon_Tarihi, OpsiyonKoyan=@Opsiyon_Koyan Where AracUID=@AracUID ", connect))
                    {
                        connect.Open();
                        command.Parameters.AddWithValue("Opsiyon", Opsiyon);
                        command.Parameters.AddWithValue("Opsiyon_Tarihi", Opsiyon_Tarihi);
                        command.Parameters.AddWithValue("Opsiyon_Koyan", Opsiyon_Koyan);
                        command.Parameters.AddWithValue("AracUID", AracUID);
                        command.ExecuteNonQuery();
                        connect.Close();
                    }
                    JArray ja = new JArray();
                   
                    ja.Add(Opsiyon_Tarihi.ToString());
                    ja.Add(Opsiyon_Koyan);
                  
                    string sa = JsonConvert.SerializeObject(ja);
                    return sa; 
                }
               
               

                

            }
        }

        internal static string ResmiGirisYap(string AracUID, string ResmiAlınanTipi, string ResmiAlınanKisi, string NoterAlisTarihi, string ResmiGirisBedeli, string ResmiGirisTcVergiNo, string ResmiGirisFatura)
        {
               SqlConnection connection = new SqlConnection(Database.ConnectionString);
            connection.Open();
            SqlCommand command = new SqlCommand("Update Araclar set ResmiAlınanTipi=@ResmiAlınanTipi,ResmiAlınanKisi=@ResmiAlınanKisi,NoterAlisTarihi=@NoterAlisTarihi, ResmiGirisBedeli=@ResmiGirisBedeli,ResmiGirisFatura=@ResmiGirisFatura,ResmiGirisTcVergiNo=@ResmiGirisTcVergiNo  WHERE AracUID=@AracUID ", connection);
            command.Parameters.AddWithValue("AracUID", AracUID);
            command.Parameters.AddWithValue("ResmiAlınanKisi", ResmiAlınanKisi);
            command.Parameters.AddWithValue("NoterAlisTarihi", Globals.IsNullOrEmpty(NoterAlisTarihi) ? (object)DBNull.Value : DateTime.ParseExact(NoterAlisTarihi, "dd.MM.yyyy", null).ToString("yyyy/MM/dd"));
            command.Parameters.AddWithValue("ResmiAlınanTipi", ResmiAlınanTipi);
            command.Parameters.AddWithValue("ResmiGirisBedeli",ResmiGirisBedeli);
            command.Parameters.AddWithValue("ResmiGirisTcVergiNo", ResmiGirisTcVergiNo);
            command.Parameters.AddWithValue("ResmiGirisFatura", Globals.IsNullOrEmpty(ResmiGirisFatura) ? (object)DBNull.Value : ResmiGirisFatura);


            command.ExecuteNonQuery();
            connection.Close();
            JArray ja = new JArray();

            ja.Add(ResmiAlınanKisi.ToString());
            ja.Add(NoterAlisTarihi.ToString());
            ja.Add(ResmiAlınanTipi.ToString());
            ja.Add(ResmiGirisBedeli.ToString());
            ja.Add(ResmiGirisTcVergiNo.ToString());
            ja.Add(ResmiGirisFatura.ToString());

            string sa = JsonConvert.SerializeObject(ja);
            return sa; 

        }

        internal static string ResmiCikisYap(string AracUID, string ResmiCikisKisi, string ResmiCikisBedeli, string ResmiCikisTarihi, string ResmiCikisTcVergiNo)
        {
            SqlConnection connection = new SqlConnection(Database.ConnectionString);
            connection.Open();
            SqlCommand command = new SqlCommand("Update Araclar set ResmiCikisKisi=@ResmiCikisKisi,ResmiCikisBedeli=@ResmiCikisBedeli,ResmiCikisTarihi=@ResmiCikisTarihi,ResmiCikisTcVergiNo=@ResmiCikisTcVergiNo WHERE AracUID=@AracUID", connection);
            command.Parameters.AddWithValue("AracUID", AracUID);
            command.Parameters.AddWithValue("ResmiCikisKisi", ResmiCikisKisi);
            command.Parameters.AddWithValue("ResmiCikisBedeli", ResmiCikisBedeli);
            command.Parameters.AddWithValue("ResmiCikisTarihi", Globals.IsNullOrEmpty(ResmiCikisTarihi) ? (object)DBNull.Value : DateTime.ParseExact(ResmiCikisTarihi, "dd.MM.yyyy", null).ToString("yyyy/MM/dd"));
            command.Parameters.AddWithValue("ResmiCikisTcVergiNo", ResmiCikisTcVergiNo);
            command.ExecuteNonQuery();
            connection.Close();
            JArray ja = new JArray();

            ja.Add(ResmiCikisKisi.ToString());
            ja.Add(ResmiCikisBedeli.ToString());           
            ja.Add(ResmiCikisTarihi.ToString());
            ja.Add(ResmiCikisTcVergiNo.ToString());


            string sa = JsonConvert.SerializeObject(ja);
            return sa; 

        }
    }
}