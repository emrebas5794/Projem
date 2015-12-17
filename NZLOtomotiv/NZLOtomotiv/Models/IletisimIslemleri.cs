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
    public static class IletisimIslemleri
    {
        internal static string IletisimBilgisiAl(string Data)
        {
            JObject parameters = new JObject();
            if (Data != null)
                parameters = (JObject)JsonConvert.DeserializeObject(Data);
            JToken ContactUid, Ad, Type, KimlikNo, Adres, Telefon;

            parameters.TryGetValue("ContactUid", out ContactUid);
            parameters.TryGetValue("Ad", out Ad);
            parameters.TryGetValue("Type", out Type);
            parameters.TryGetValue("KimlikNo", out KimlikNo);
            parameters.TryGetValue("Adres", out Adres);
            parameters.TryGetValue("Telefon", out Telefon);

            SqlCommand command = new SqlCommand();
            bool pastfirst = false;
            StringBuilder kurallar = new StringBuilder();
            #region Contact Uid
            if (!Globals.IsNullOrEmpty(ContactUid))
            {
                if (pastfirst)
                    kurallar.Append("AND ");
                else
                {
                    kurallar.Append("WHERE ");
                    pastfirst = true;
                }
                kurallar.Append("ContactUID = @ContactUid ");
                command.Parameters.AddWithValue("ContactUid", ContactUid.ToString());
            }
            #endregion
            #region Ad
            if (!Globals.IsNullOrEmpty(Ad))
            {
                if (pastfirst)
                    kurallar.Append("AND ");
                else
                {
                    kurallar.Append("WHERE ");
                    pastfirst = true;
                }
                kurallar.Append("Ad_Soyad LIKE '%' + @Ad + '%' ");
                command.Parameters.AddWithValue("Ad", Ad.ToString());
            }
            #endregion
            #region Type

            if (!Globals.IsNullOrEmpty(Type))
            {
                if (pastfirst)
                    kurallar.Append("AND ");
                else
                {
                    kurallar.Append("WHERE ");
                    pastfirst = true;
                }
                kurallar.AppendFormat("Type = @Type ");
                command.Parameters.AddWithValue("Type", Type.ToString());
            }
            #endregion
            #region Kimlik No
            if (!Globals.IsNullOrEmpty(KimlikNo))
            {
                if (pastfirst)
                    kurallar.Append("AND ");
                else
                {
                    kurallar.Append("WHERE ");
                    pastfirst = true;
                }
                kurallar.Append("KimlikNo = @KimlikNo ");
                command.Parameters.AddWithValue("KimlikNo", KimlikNo.ToString());
            }
            #endregion
            #region Adres
            if (!Globals.IsNullOrEmpty(Adres))
            {
                if (pastfirst)
                    kurallar.Append("AND ");
                else
                {
                    kurallar.Append("WHERE ");
                    pastfirst = true;
                }
                kurallar.Append("BirincilAdres LIKE '%' + @Adres + '%' OR Adresler LIKE '%' + @Adres + '%' ");
                command.Parameters.AddWithValue("Adres", Adres.ToString());
            }
            #endregion
            #region Telefon
            if (!Globals.IsNullOrEmpty(Telefon))
            {
                if (pastfirst)
                    kurallar.Append("AND ");
                else
                {
                    kurallar.Append("WHERE ");
                    pastfirst = true;
                }
                kurallar.AppendFormat("BirincilTelefon LIKE '%' + @Telefon + '%' OR Telefonlar LIKE '%' + @Telefon + '%' ");
                command.Parameters.AddWithValue("Telefon", Telefon.ToString());
            }
            #endregion

            SqlConnection connection = new SqlConnection(Database.ConnectionString);
            command.Connection = connection;
            command.CommandText = "SELECT ContactUID, Type, Ad, KimlikNo, BirincilAdres, Adresler, BirincilTelefon, Telefonlar, VergiDairesi, VergiNo, IletisimNot FROM Iletisim " + kurallar.ToString() + "ORDER BY Ad ASC";
            connection.Open();
            SqlDataReader reader = command.ExecuteReader();
            JArray response = new JArray();
            int index = 0;
            while (reader.Read())
            {
                JObject jo = new JObject();
                jo.Add("ListIndex", index);
                index++;
                for (int i = 0; i < reader.FieldCount; i++)
                {
                    jo.Add(reader.GetName(i), reader[i].ToString());
                }
                jo["Adresler"].Replace(new JArray(jo["Adresler"].Value<string>().Split(new string[] { "/*/" }, StringSplitOptions.RemoveEmptyEntries)));
                jo["Telefonlar"].Replace(new JArray(jo["Telefonlar"].Value<string>().Split(new string[] { "/*/" }, StringSplitOptions.RemoveEmptyEntries)));
                response.Add(jo);
            }
            connection.Close();
            reader.Close();
            return JsonConvert.SerializeObject(response);
        }

        internal static int TcKimlikKontrol(string Tc, string ContactUID)
        {
            SqlConnection connection = new SqlConnection(Database.ConnectionString);
            SqlCommand command = new SqlCommand();
            command.Connection = connection;
            if (ContactUID=="")
            {
                command.CommandText = "SELECT KimlikNo FROM Iletisim where KimlikNo!='' ";
            }
            else
            {
                command.CommandText = "SELECT KimlikNo FROM Iletisim where KimlikNo!='' and ContactUID!=@ContactUID";
                command.Parameters.AddWithValue("ContactUID", ContactUID);
            }
         
            connection.Open();
            SqlDataReader reader = command.ExecuteReader();
            int kontrol=0;
            while (reader.Read())
            {
                if (reader["KimlikNo"].ToString()==Tc)
            	{
                    kontrol = 1;
                    return kontrol;
               	}
               
            }
            connection.Close();
            reader.Close();
            return kontrol;
        }

        internal static int VergiKontrol(string Vergi, string ContactUID)
        {
            SqlConnection connection = new SqlConnection(Database.ConnectionString);
            SqlCommand command = new SqlCommand();
            command.Connection = connection;
            if (ContactUID == "")
            {
                command.CommandText = "SELECT VergiNo FROM Iletisim  where VergiNo!=''";
            }
            else
            {
                command.CommandText = "SELECT VergiNo FROM Iletisim where VergiNo!='' and ContactUID!=@ContactUID";
                command.Parameters.AddWithValue("ContactUID", ContactUID);
            }
          
            connection.Open();
            SqlDataReader reader = command.ExecuteReader();
            int kontrol = 0;
            while (reader.Read())
            {
                if (reader["VergiNo"].ToString() == Vergi)
                {
                    kontrol = 1;
                    return kontrol;
                }

            }
            connection.Close();
            reader.Close();
            return kontrol;
        }

        internal static string IletisimBilgisiKaydet(string Data)
        {
            JObject parameters = (JObject)JsonConvert.DeserializeObject(Data);
            JToken Ad, Type, KimlikNo, BirincilAdres, Adresler, BirincilTelefon, Telefonlar, VergiDairesi, VergiNo, IletisimNot;

            parameters.TryGetValue("Ad", out Ad);
            parameters.TryGetValue("Type", out Type);
            parameters.TryGetValue("KimlikNo", out KimlikNo);
            parameters.TryGetValue("BirincilAdres", out BirincilAdres);
            parameters.TryGetValue("Adresler", out Adresler);
            parameters.TryGetValue("BirincilTelefon", out BirincilTelefon);
            parameters.TryGetValue("Telefonlar", out Telefonlar);
            parameters.TryGetValue("VergiDairesi", out VergiDairesi);
            parameters.TryGetValue("VergiNo", out VergiNo);
            parameters.TryGetValue("IletisimNot", out IletisimNot);

            StringBuilder telefonlar = new StringBuilder();
            if (!Globals.IsNullOrEmpty(Telefonlar))
            {
                foreach (var telefon in Telefonlar.Values())
                {
                    telefonlar.Append(telefon.ToString());
                    if (telefon.Next != null)
                        telefonlar.Append("/*/");
                }
            }
            StringBuilder adresler = new StringBuilder();
            if (!Globals.IsNullOrEmpty(Adresler))
            {
                foreach (var adres in Adresler.Values())
                {
                    adresler.Append(adres.ToString());
                    if (adres.Next != null)
                        adresler.Append("/*/");
                }
            }

            string contact_uid = Guid.NewGuid().ToString();
            SqlConnection connection = new SqlConnection(Database.ConnectionString);
            SqlCommand command = new SqlCommand();
            command.Connection = connection;
            command.CommandText = "INSERT INTO Iletisim (ContactUID, Ad, Type, KimlikNo, BirincilTelefon, Telefonlar, BirincilAdres, Adresler, VergiDairesi, VergiNo, IletisimNot) VALUES (@ContactUID, @Ad, @Type, @KimlikNo, @BirincilTelefon, @Telefonlar, @BirincilAdres, @Adresler, @VergiDairesi, @VergiNo, @IletisimNot)";
            command.Parameters.AddWithValue("ContactUID", contact_uid);
            command.Parameters.AddWithValue("Ad", Ad.ToString());
            command.Parameters.AddWithValue("Type", Type.ToString());
            command.Parameters.AddWithValue("KimlikNo", KimlikNo == null ? null : KimlikNo.ToString());
            command.Parameters.AddWithValue("BirincilTelefon", BirincilTelefon == null ? String.Empty : BirincilTelefon.ToString());
            command.Parameters.AddWithValue("Telefonlar", telefonlar.ToString());
            command.Parameters.AddWithValue("BirincilAdres", BirincilAdres == null ? String.Empty : BirincilAdres.ToString());
            command.Parameters.AddWithValue("Adresler", adresler.ToString());
            command.Parameters.AddWithValue("VergiDairesi", VergiDairesi == null ? String.Empty : VergiDairesi.ToString());
            command.Parameters.AddWithValue("VergiNo", VergiNo == null ? String.Empty : VergiNo.ToString());
            command.Parameters.AddWithValue("IletisimNot", IletisimNot == null ? "" : IletisimNot.ToString());
           
            JObject response = new JObject();
            response.Add("Kontrol", "0");
            response.Add("Ad", Ad.ToString());
            response.Add("Type", Type.ToString());
            response.Add("ContactUID", contact_uid);
            response.Add("KimlikNo", KimlikNo == null ? null : KimlikNo.ToString());
            response.Add("BirincilTelefon", BirincilTelefon == null ? String.Empty : BirincilTelefon.ToString());
            response.Add("Telefonlar", Telefonlar);
            response.Add("BirincilAdres", BirincilAdres == null ? String.Empty : BirincilAdres.ToString());
            response.Add("Adresler", Adresler);
            response.Add("VergiDairesi", VergiDairesi == null ? null : VergiDairesi.ToString());
            response.Add("VergiNo", VergiNo == null ? null : VergiNo.ToString());
            response.Add("IletisimNot", IletisimNot == null ? "" : IletisimNot.ToString());

          int TcSonuc=  TcKimlikKontrol(KimlikNo.ToString(),"");
          int VergiSonuc = VergiKontrol(VergiNo.ToString(),"");
          if (Type.ToString()=="Kişi")
          {
              if (TcSonuc==1)
              {
                  response["Kontrol"]="1";
                  return JsonConvert.SerializeObject(response);
              }
              else
              {
                  connection.Open();
                  command.ExecuteNonQuery();
                  connection.Close();
              }
             
          }
          else
	        {
                if (VergiSonuc==1)
                {
                    response["Kontrol"] = "2";
                    return JsonConvert.SerializeObject(response);
                }
                else
                {
                    connection.Open();
                    command.ExecuteNonQuery();
                    connection.Close();
                }
             
        	}
              
          
         
            
          

           
            
            return JsonConvert.SerializeObject(response);
        }

        internal static string IletisimBilgisiDuzenle(string Data)
        {
            JObject parameters = (JObject)JsonConvert.DeserializeObject(Data);
            JToken ContactUID, Ad, Type, KimlikNo, BirincilAdres, Adresler, BirincilTelefon, Telefonlar, VergiDairesi, VergiNo, IletisimNot;

            parameters.TryGetValue("ContactUID", out ContactUID);
            parameters.TryGetValue("Ad", out Ad);
            parameters.TryGetValue("Type", out Type);
            parameters.TryGetValue("KimlikNo", out KimlikNo);
            parameters.TryGetValue("BirincilAdres", out BirincilAdres);
            parameters.TryGetValue("Adresler", out Adresler);
            parameters.TryGetValue("BirincilTelefon", out BirincilTelefon);
            parameters.TryGetValue("Telefonlar", out Telefonlar);
            parameters.TryGetValue("VergiDairesi", out VergiDairesi);
            parameters.TryGetValue("VergiNo", out VergiNo);
            parameters.TryGetValue("IletisimNot", out IletisimNot);

            StringBuilder telefonlar = new StringBuilder();
            if (!Globals.IsNullOrEmpty(Telefonlar))
            {
                foreach (var telefon in Telefonlar.Values())
                {
                    telefonlar.Append(telefon.ToString());
                    if (telefon.Next != null)
                        telefonlar.Append("/*/");
                }
            }
            StringBuilder adresler = new StringBuilder();
            if (!Globals.IsNullOrEmpty(Adresler))
            {
                foreach (var adres in Adresler.Values())
                {
                    adresler.Append(adres.ToString());
                    if (adres.Next != null)
                        adresler.Append("/*/");
                }
            }

            SqlConnection connection = new SqlConnection(Database.ConnectionString);
            SqlCommand command = new SqlCommand();
            command.Connection = connection;
            command.CommandText = "UPDATE Iletisim SET Ad = @Ad, Type = @Type, KimlikNo = @KimlikNo, BirincilTelefon = @BirincilTelefon, Telefonlar = @Telefonlar, BirincilAdres = @BirincilAdres, Adresler = @Adresler, VergiDairesi = @VergiDairesi, VergiNo = @VergiNo, IletisimNot = @IletisimNot WHERE ContactUID = @ContactUID";
            command.Parameters.AddWithValue("ContactUID", ContactUID.ToString());
            command.Parameters.AddWithValue("Ad", Ad.ToString());
            command.Parameters.AddWithValue("Type", Type.ToString());
            command.Parameters.AddWithValue("KimlikNo", KimlikNo == null ? null : KimlikNo.ToString());
            command.Parameters.AddWithValue("BirincilTelefon", BirincilTelefon == null ? null : BirincilTelefon.ToString());
            command.Parameters.AddWithValue("Telefonlar", telefonlar.ToString());
            command.Parameters.AddWithValue("BirincilAdres", BirincilAdres == null ? null : BirincilAdres.ToString());
            command.Parameters.AddWithValue("Adresler", adresler.ToString());
            command.Parameters.AddWithValue("VergiDairesi", VergiDairesi == null ? null : VergiDairesi.ToString());
            command.Parameters.AddWithValue("VergiNo", VergiNo == null ? null : VergiNo.ToString());
            command.Parameters.AddWithValue("IletisimNot", IletisimNot == null ? null : IletisimNot.ToString());
          

            JObject response = new JObject();
            response.Add("Kontrol", "0");
            response.Add("ContactUID", ContactUID.ToString());
            response.Add("Ad", Ad.ToString());
            response.Add("Type", Type.ToString());
            response.Add("KimlikNo", KimlikNo == null ? null : KimlikNo.ToString());
            response.Add("BirincilTelefon", BirincilTelefon == null ? null : BirincilTelefon.ToString());
            response.Add("Telefonlar", Telefonlar);
            response.Add("BirincilAdres", BirincilAdres == null ? null : BirincilAdres.ToString());
            response.Add("Adresler", Adresler);
            response.Add("VergiDairesi", VergiDairesi == null ? null : VergiDairesi.ToString());
            response.Add("VergiNo", VergiNo == null ? null : VergiNo.ToString());
            response.Add("IletisimNot", IletisimNot == null ? null : IletisimNot.ToString());
            int TcSonuc = TcKimlikKontrol(KimlikNo.ToString(), ContactUID.ToString());
            int VergiSonuc = VergiKontrol(VergiNo.ToString(), ContactUID.ToString());
            if (Type.ToString() == "Kişi")
            {
                if (TcSonuc == 1)
                {
                    response["Kontrol"] = "1";
                    return JsonConvert.SerializeObject(response);

                }
                else
                {
                    connection.Open();
                    command.ExecuteNonQuery();
                    connection.Close();
                }

            }
            else
            {
                if (VergiSonuc == 1)
                {
                    response["Kontrol"] = "2";
                    return JsonConvert.SerializeObject(response);

                }
                else
                {
                    connection.Open();
                    command.ExecuteNonQuery();
                    connection.Close();
                }

            }
              
            
            return JsonConvert.SerializeObject(response);
        }
    }
}