using System;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace NZLOtomotiv.Models
{
    public class PersonelIslemleri
    {
        internal static int PersonelKullaniciAdiKontrol(string KullaniciAdi, string id)
        {
            SqlConnection connection = new SqlConnection(Database.ConnectionString);
            SqlCommand command = new SqlCommand();
            command.Connection = connection;

           
            if (id == "")
            {
                command.CommandText = "SELECT username FROM Kullanicilar where username!='' ";
            }
            else
            {
                command.CommandText = "SELECT username FROM Kullanicilar where username!='' and id!=@id";
                command.Parameters.AddWithValue("id", id);
            }

            connection.Open();
            SqlDataReader reader = command.ExecuteReader();
            int kontrol = 0;
            while (reader.Read())
            {
                if (reader["username"].ToString() == KullaniciAdi)
                {
                    kontrol = 1;
                    return kontrol;
                }

            }
            connection.Close();
            reader.Close();
            return kontrol;
        }
        internal static int PersonelemailKontrol(string email,string id)
        {
            SqlConnection connection = new SqlConnection(Database.ConnectionString);
            SqlCommand command = new SqlCommand();
            command.Connection = connection;
            if (id == "")
            {
                command.CommandText = "SELECT email FROM Kullanicilar where email!='' ";
            }
            else
            {
                command.CommandText = "SELECT email FROM Kullanicilar where email!='' and id!=@id";
                command.Parameters.AddWithValue("id", id);
            }

            


            connection.Open();
            SqlDataReader reader = command.ExecuteReader();
            int kontrol = 0;
            while (reader.Read())
            {
                if (reader["email"].ToString() == email)
                {
                    kontrol = 1;
                    return kontrol;
                }

            }
            connection.Close();
            reader.Close();
            return kontrol;
        }
        internal static string PersonelKaydet(string KullaniciAdi,string Sifre,string Email,string Telefon)
        {
            int PersonelKullaniciAdiSonuc = PersonelKullaniciAdiKontrol(KullaniciAdi,"");
            int PersonelEmailSonuc = PersonelemailKontrol(Email,"");
            if (PersonelKullaniciAdiSonuc==1 && PersonelEmailSonuc==1 )
            {
                return "KullaniciAdiEmail";
               
            }
            else if (PersonelEmailSonuc==1)
            {
                 return "Email";
            }
            else if (PersonelKullaniciAdiSonuc == 1)
            {
                return "KullaniciAdi";
            }
            else
            {
                using (SqlConnection connect = new SqlConnection(Database.ConnectionString))
                {
                    connect.Open();


                    using (SqlCommand command = new SqlCommand("INSERT INTO Kullanicilar(username,password_hash,email,phone) values(@KullaniciAdi,@Sifre,@Email,@Telefon)", connect))
                    {
                        command.Parameters.AddWithValue("KullaniciAdi", KullaniciAdi);
                        command.Parameters.AddWithValue("Sifre", HashPass.HashPassword(Sifre));
                        command.Parameters.AddWithValue("Email", Email);
                        command.Parameters.AddWithValue("Telefon", Telefon);
                        command.ExecuteNonQuery();
                    }

                    connect.Close();
                }

                return "Ok";
            }
            
        }

        internal static string PersonelAl()
        {

            SqlConnection connection = new SqlConnection(Database.ConnectionString);
            connection.Open();
            SqlCommand command = new SqlCommand("SELECT * FROM Kullanicilar", connection);
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

        internal static string PersonelDuzenle(string KullaniciAdi, string Sifre, string Email, string Telefon,string id)
        {
            int PersonelKullaniciAdiSonuc = PersonelKullaniciAdiKontrol(KullaniciAdi,id);
            int PersonelEmailSonuc = PersonelemailKontrol(Email,id);
            if (PersonelKullaniciAdiSonuc == 1 && PersonelEmailSonuc == 1)
            {
                return "KullaniciAdiEmail";

            }
            else if (PersonelEmailSonuc == 1)
            {
                return "Email";
            }
            else if (PersonelKullaniciAdiSonuc == 1)
            {
                return "KullaniciAdi";
            }
            else
            {
                using (SqlConnection connect = new SqlConnection(Database.ConnectionString))
                {
                    connect.Open();

                    if (Sifre == "")
                    {
                        using (SqlCommand command = new SqlCommand("Update Kullanicilar Set  username=@KullaniciAdi,email=@Email,phone=@Telefon where id=@id", connect))
                        {
                            command.Parameters.AddWithValue("id", id);
                            command.Parameters.AddWithValue("KullaniciAdi", KullaniciAdi);
                            command.Parameters.AddWithValue("Email", Email);
                            command.Parameters.AddWithValue("Telefon", Telefon);
                            command.ExecuteNonQuery();
                        }

                    }
                    else
                    {
                        using (SqlCommand command = new SqlCommand("Update Kullanicilar Set  username=@KullaniciAdi,password_hash=@Sifre,email=@Email,phone=@Telefon where id=@id", connect))
                        {
                            command.Parameters.AddWithValue("id", id);
                            command.Parameters.AddWithValue("KullaniciAdi", KullaniciAdi);
                            command.Parameters.AddWithValue("Sifre", HashPass.HashPassword(Sifre));
                            command.Parameters.AddWithValue("Email", Email);
                            command.Parameters.AddWithValue("Telefon", Telefon);
                            command.ExecuteNonQuery();
                        }
                    }


                    connect.Close();
                }

                JObject jo = new JObject();
                jo.Add("username", KullaniciAdi);
                jo.Add("email", Email);
                jo.Add("phone", Telefon);
                jo.Add("id", id);


                return JsonConvert.SerializeObject(jo);
            }
           
        }
        internal static string PersonelSil(string id)
        {
            using (SqlConnection connect = new SqlConnection(Database.ConnectionString))
            {
                connect.Open();

               
                    using (SqlCommand command = new SqlCommand("Delete From Kullanicilar where id=@id", connect))
                    {
                        command.Parameters.AddWithValue("id", id);
                        
                        command.ExecuteNonQuery();
                    }
                connect.Close();
                }
            return "Ok";
            
        }
    }
}