using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using NZLOtomotiv.Models;
using Newtonsoft.Json.Linq;
using System.Data.SqlClient;
using System.IO;

namespace NZLOtomotiv.Models
{
    public class TadilatIslemleri
    {
        public JObject TadilatListesiAl()
        {
            JObject ReturnObject = new JObject();
            JArray BaslikArray = new JArray();
            JArray ListeArray = new JArray();
            JArray SummaryArray = new JArray();
            using (SqlConnection connect = new SqlConnection(Database.ConnectionString))
            {
                connect.Open();

                #region Tadilat başlık kısımı
                using (SqlCommand command = new SqlCommand("SELECT * FROM TadilatBaslik", connect))
                {
                    SqlDataReader commandReader = command.ExecuteReader();
                    while (commandReader.Read())
                    {
                        JObject Obj = new JObject();
                        Obj.Add("dataField", commandReader["Ad"].ToString());
                        Obj.Add("Ad", commandReader["Ad"].ToString());
                        Obj.Add("caption", commandReader["GorunenAd"].ToString());
                        Obj.Add("Tip", commandReader["Tip"].ToString());
                        Obj.Add("Oncelik", commandReader["Oncelik"].ToString());

                        if (Convert.ToBoolean(commandReader["Oncelik"]))
                            SummaryArray.Add(commandReader["Ad"].ToString());

                        BaslikArray.Add(Obj);
                    }
                    commandReader.Close();
                }
                #endregion
                #region Tadilat listesi kısımı
                using (SqlCommand command = new SqlCommand("SELECT * FROM Tadilatlar LEFT JOIN (SELECT * FROM Araclar) AS ARAC ON ARAC.AracUID = Arac_ID WHERE Tamamlanmis=0", connect))
                {
                    SqlDataReader commandReader = command.ExecuteReader();

                    while (commandReader.Read())
                    {
                        JObject Obj = new JObject();
                        if (Convert.ToBoolean(commandReader["Manuel_Veri"]))
                        {
                            Obj.Add("Arac_TamAd", commandReader["Manuel_AracAdi"].ToString());
                            Obj.Add("Arac_Yil", commandReader["Manuel_AracYil"].ToString());
                            Obj.Add("Arac_Renk", commandReader["Manuel_AracRenk"].ToString());
                        }

                        for (int i = 0; i < commandReader.FieldCount; i++)
                        {
                            try
                            {
                                if (Convert.ToBoolean(commandReader["Manuel_Veri"]) && commandReader.GetName(i) == "Plaka")
                                {
                                    Obj.Add("Plaka", commandReader["Manuel_AracPlaka"].ToString());
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
                                {
                                    Obj.Add("Arac_TamAd", commandReader["Marka"].ToString() + " " + commandReader["Seri"].ToString() + " " + commandReader["Model"].ToString());
                                    Obj.Add("Arac_Yil", commandReader["Yil"].ToString());
                                    Obj.Add("Arac_Renk", commandReader["Renk"].ToString());
                                }
                            }
                            catch
                            { }
                        }
                        ListeArray.Add(Obj);
                    }
                    commandReader.Close();
                }
                #endregion

                connect.Close();
            }
            ReturnObject.Add("Baslik", BaslikArray);
            ReturnObject.Add("Liste", ListeArray);
            ReturnObject.Add("Ozet", SummaryArray);

            return ReturnObject;
        }

        public void TadilatSutunOlustur(string Data)
        {

            JObject parameters = JObject.Parse(Data);
            JToken Sutun_Adi, Sutun_Tipi;

            parameters.TryGetValue("Sutun_Adi", out Sutun_Adi);
            parameters.TryGetValue("Sutun_Tipi", out Sutun_Tipi);

            string SutunAdi = Globals.StringExp(Sutun_Adi.ToString());
            string SutunTip = Globals.StringExp(Sutun_Tipi.ToString());

            using (SqlConnection connect = new SqlConnection(Database.ConnectionString))
            {
              

                using (SqlCommand command = new SqlCommand("INSERT INTO TadilatBaslik(Oncelik, Ad, Tip, GorunenAd)" +
                    " VALUES(@Oncelik, @Ad, @Tip, @GorunenAd)", connect))
                {
                    command.Parameters.AddWithValue("Oncelik", 1);
                    command.Parameters.AddWithValue("Ad", SutunTip + "_" + SutunAdi);
                    command.Parameters.AddWithValue("Tip", Sutun_Tipi.ToString());
                    command.Parameters.AddWithValue("GorunenAd", Sutun_Tipi.ToString() + "(" + Sutun_Adi.ToString() + ")");
                    connect.Open();
                    command.ExecuteNonQuery();
                    connect.Close();
                }               
            }


            using (SqlConnection connect2 = new SqlConnection(Database.ConnectionString))
            {


                using (SqlCommand command2 = new SqlCommand("ALTER TABLE Tadilatlar ADD Maliyet_" + SutunTip + "_" + SutunAdi + " INT, Not_" + SutunTip + "_" + SutunAdi + " NVARCHAR(255), Hesap_" + SutunTip + "_" + SutunAdi + " BIT, Kayit_" + SutunTip + "_" + SutunAdi + " BIT, Kesim_" + SutunTip + "_" + SutunAdi + " DATE", connect2))
                {

                    StreamWriter SW = new StreamWriter(AppDomain.CurrentDomain.BaseDirectory + @"/Data/deneme.txt");
                    SW.WriteLine(command2.CommandText);
                    SW.Close();
                    connect2.Open();
                    command2.ExecuteNonQuery();
                    connect2.Close();
                }


            }




        }

        public void TadilatNotKaydet(string Data)
        {
            JObject parameters = JObject.Parse(Data);
            JToken ID, Column, NotValue;

            parameters.TryGetValue("ID", out ID);
            parameters.TryGetValue("Column", out Column);
            parameters.TryGetValue("NotValue", out NotValue);

            string sColumn = "Not_" + Column.ToString();

            using (SqlConnection connect = new SqlConnection(Database.ConnectionString))
            {
                connect.Open();

                using (SqlCommand command = new SqlCommand("UPDATE Tadilatlar SET " + sColumn + "=@NotVerisi WHERE id=@ID", connect))
                {
                    command.Parameters.AddWithValue("NotVerisi", NotValue.ToString());
                    command.Parameters.AddWithValue("ID", Convert.ToInt32(ID.ToString()));

                    command.ExecuteNonQuery();
                }

                connect.Close();
            }
        }

        public void TadilatManuelAracEkle(string Data)
        {
            JObject parameters = JObject.Parse(Data);
            JToken Manuel_Veri, Manuel_AracPlaka, Manuel_AracAdi, Manuel_AracYil, Manuel_AracRenk, Manuel_Data,ColonAdi;
          
            parameters.TryGetValue("Manuel_Veri", out Manuel_Veri);
            parameters.TryGetValue("Manuel_AracPlaka", out Manuel_AracPlaka);
            parameters.TryGetValue("Manuel_AracAdi", out Manuel_AracAdi);
            parameters.TryGetValue("Manuel_AracYil", out Manuel_AracYil);
            parameters.TryGetValue("Manuel_AracRenk", out Manuel_AracRenk);
            parameters.TryGetValue("Manuel_Data", out Manuel_Data);
            JObject Manuel_Dataparameters = JObject.Parse(Manuel_Data.ToString());

            string Colonlar = "";
            string ColonVerileri = "";
            int i;
            foreach (var item in Manuel_Dataparameters)
            {
                
                if (int.TryParse(item.Value.ToString(), out i))
                {
                    Colonlar += "," + item.Key;
                    ColonVerileri += "," + item.Value.ToString();
                }
                else
                {
                    Colonlar += "," + "Manuel_AracAdi";
                    ColonVerileri += ",'" + item.Value.ToString()+"'";
                }
                
               
                
            }
            using (SqlConnection connect = new SqlConnection(Database.ConnectionString))
            {
                connect.Open();
               

                using (SqlCommand command = new SqlCommand("INSERT INTO Tadilatlar(Manuel_Veri,Tamamlanmis"+Colonlar+") VALUES(@Manuel_Veri,0"+ColonVerileri+")", connect))
                {
                    command.Parameters.AddWithValue("Manuel_Veri", Convert.ToInt32(Manuel_Veri.ToString()));
                    //command.Parameters.AddWithValue("Manuel_AracPlaka", Manuel_AracPlaka.ToString() ==null? (object)DBNull.Value : Manuel_AracPlaka.ToString());
                    //command.Parameters.AddWithValue("Manuel_AracAdi", Manuel_AracAdi.ToString() == null ? (object)DBNull.Value : Manuel_AracAdi.ToString());
                    //command.Parameters.AddWithValue("Manuel_AracRenk", Manuel_AracRenk.ToString()  == null ? (object)DBNull.Value : Manuel_AracRenk.ToString());
                    //command.Parameters.AddWithValue("Manuel_AracYil", Manuel_AracYil.ToString() == null ? (object)DBNull.Value : Manuel_AracYil.ToString());

                    command.ExecuteNonQuery();
                }

                connect.Close();
            }

        }

        public void TadilatSutunSil(string Data)
        {
            JObject parameters = JObject.Parse(Data);
            JToken Sutun_Adi;
            parameters.TryGetValue("Sutun_Adi", out Sutun_Adi);

            using (SqlConnection connect = new SqlConnection(Database.ConnectionString))
            {
              
                using (SqlCommand command = new SqlCommand("DELETE TadilatBaslik WHERE Ad=@Sutun_Adi", connect))
                {
                    command.Parameters.AddWithValue("Sutun_Adi", Sutun_Adi.ToString());
                    connect.Open();
                    command.ExecuteNonQuery();
                    connect.Close();
                }             
             
            }

            using (SqlConnection connect2 = new SqlConnection(Database.ConnectionString))
            {
                using (SqlCommand command2 = new SqlCommand("ALTER TABLE Tadilatlar DROP COLUMN Maliyet_" + Sutun_Adi.ToString() + ", Not_" + Sutun_Adi.ToString() + ", Hesap_" + Sutun_Adi.ToString() + ", Kayit_" + Sutun_Adi.ToString() + ", Kesim_" + Sutun_Adi.ToString(), connect2))
                {
                    connect2.Open();
                    command2.ExecuteNonQuery();
                    connect2.Close();
                }

              
            }
        }

        public void TadilatKaydiGuncelle(string Data)
        {
            JObject parameters = JObject.Parse(Data);
            JToken Kayit_ID, Kayit_Sutun;

            parameters.TryGetValue("Kayit_ID", out Kayit_ID);
            parameters.TryGetValue("Kayit_Sutun", out Kayit_Sutun);

            JObject Kayit_Sutunparameters = JObject.Parse(Kayit_Sutun.ToString());

            string Colonlar = "";
          
            int i;
            foreach (var item in Kayit_Sutunparameters)
            {

                if (int.TryParse(item.Value.ToString(), out i))
                {
                    Colonlar += item.Key + "=" + item.Value.ToString()+",";
                    
                }
                else
                {
                    Colonlar +="Manuel_AracAdi='" + item.Value.ToString() + "',";
                   
                }



            }


            using (SqlConnection connect = new SqlConnection(Database.ConnectionString))
            {
                connect.Open();
                string Guncellenecekler = Colonlar.Substring(0, Colonlar.Length - 1);
                using (SqlCommand command = new SqlCommand("UPDATE Tadilatlar SET " + Guncellenecekler + " WHERE id=@ID", connect))
                {
                  
                    command.Parameters.AddWithValue("ID", Convert.ToInt32(Kayit_ID.ToString()));

                    command.ExecuteNonQuery();
                }

                connect.Close();
            }

        }

        public void TadilatKayitAracGonder(string Data)
        {
            JObject parameters = JObject.Parse(Data);
            JToken VeriID, AracID, SutunAdi, KayitTipi, VeriMiktar, VeriNot;

            parameters.TryGetValue("VeriID", out VeriID);
            parameters.TryGetValue("AracID", out AracID);
            parameters.TryGetValue("SutunAdi", out SutunAdi);
            parameters.TryGetValue("KayitTipi", out KayitTipi);
            parameters.TryGetValue("VeriMiktar", out VeriMiktar);
            parameters.TryGetValue("VeriNot", out VeriNot);

            using (SqlConnection connect = new SqlConnection(Database.ConnectionString))
            {
               

                using (SqlCommand command = new SqlCommand("SET DATEFORMAT ymd; INSERT INTO Giderler(GiderID, GiderTipi, AracMaliyetTipi, AracID, Gider, Aciklama, Tarih,KimeKesildi) " +
                                                             "VALUES(@GiderID, @GiderTipi, @AracMaliyetTipi, @AracID, @Gider, @Aciklama, @Tarih,@KimeKesildi)", connect))
                {
                    command.Parameters.AddWithValue("GiderID", Guid.NewGuid().ToString());
                    command.Parameters.AddWithValue("GiderTipi",AracID.ToString()==""?"Faliyet Dışı": "Araç Maliyeti");
                    command.Parameters.AddWithValue("AracMaliyetTipi", KayitTipi.ToString());
                    command.Parameters.AddWithValue("AracID", AracID.ToString());
                    command.Parameters.AddWithValue("Gider", Convert.ToInt32(VeriMiktar.ToString()));
                    command.Parameters.AddWithValue("Aciklama", VeriNot.ToString() == "" ? "" : VeriNot.ToString());
                    command.Parameters.AddWithValue("Tarih", DateTime.Now.ToString("yyyy.MM.dd"));
                    command.Parameters.AddWithValue("KimeKesildi", SutunAdi.ToString());
                    connect.Open();
                    command.ExecuteNonQuery();
                    connect.Close();
                }

                if (SutunAdi == null) return;

                using (SqlCommand command2 = new SqlCommand("UPDATE Tadilatlar SET Kayit_" + SutunAdi.ToString() + "= @Hesap WHERE id=@ID", connect))
                {
                    command2.Parameters.AddWithValue("Hesap", 1);
                    command2.Parameters.AddWithValue("ID", Convert.ToInt32(VeriID.ToString()));

                    connect.Open();
                    command2.ExecuteNonQuery();
                    connect.Close();
                }

                
            }
        }

        public void TadilatHesapKes(string Data)
        {
            JObject parameters = JObject.Parse(Data);
            JToken Sutun_Adi;
            parameters.TryGetValue("Sutun_Adi", out Sutun_Adi);

            using (SqlConnection connect = new SqlConnection(Database.ConnectionString))
            {
                connect.Open();
                JArray IndexArray = new JArray();
                using (SqlCommand command = new SqlCommand("UPDATE Tadilatlar SET Hesap_" + Sutun_Adi.ToString() + "= 1, Kesim_" + Sutun_Adi.ToString() + "= GETDATE() OUTPUT Inserted.* WHERE Kayit_" + Sutun_Adi.ToString() + "= 1", connect))
                {
                    SqlDataReader commandReader = command.ExecuteReader();
                    while (commandReader.Read())
                    {
                        JObject obj = new JObject();
                        obj.Add("ID", Convert.ToInt32(commandReader["id"].ToString()));
                        obj.Add("Arac_ID", commandReader["Arac_ID"].ToString());
                        obj.Add("Manuel_Veri", commandReader["Manuel_Veri"].ToString());
                        obj.Add("Manuel_AracPlaka", commandReader["Manuel_AracPlaka"].ToString());
                        obj.Add("Manuel_AracAdi", commandReader["Manuel_AracAdi"].ToString());
                        obj.Add("Manuel_AracRenk", commandReader["Manuel_AracRenk"].ToString());
                        obj.Add("Manuel_AracYil", commandReader["Manuel_AracYil"].ToString());

                        int a = Convert.ToInt32(commandReader["Maliyet_" + Sutun_Adi.ToString() + ""].ToString());
                        obj.Add("Maliyet_" + Sutun_Adi.ToString(), a);
                        obj.Add("Not_" + Sutun_Adi.ToString(), commandReader["Not_" + Sutun_Adi.ToString()].ToString());
                        obj.Add("Hesap_" + Sutun_Adi.ToString(), commandReader["Hesap_" + Sutun_Adi.ToString()].ToString());
                        obj.Add("Kayit_" + Sutun_Adi.ToString(), commandReader["Kayit_" + Sutun_Adi.ToString()].ToString());
                        obj.Add("Kesim_" + Sutun_Adi.ToString(), commandReader["Kesim_" + Sutun_Adi.ToString()].ToString());
                        IndexArray.Add(obj);
                    }
                    commandReader.Close();
                }

                int ToplamMiktar = 0;
                for (int i = 0; i < IndexArray.Count; i++)
                {
                    ToplamMiktar += Convert.ToInt32(IndexArray[i]["Maliyet_" + Sutun_Adi.ToString()].ToString());
                }

                using (SqlCommand command = new SqlCommand("SET DATEFORMAT ymd; INSERT INTO TadilatKesimler(Hesap_Tipi, Hesap_KesimTarih, Hesap_Data, Hesap_Miktar) VALUES(@Hesap_Tipi, @Hesap_KesimTarih, @Hesap_Data, @Hesap_Miktar)", connect))
                {
                    command.Parameters.AddWithValue("Hesap_Tipi", Sutun_Adi.ToString());
                    command.Parameters.AddWithValue("Hesap_KesimTarih", DateTime.Now.ToString("yyyy.MM.dd"));
                    command.Parameters.AddWithValue("Hesap_Data", IndexArray.ToString());
                    command.Parameters.AddWithValue("Hesap_Miktar", ToplamMiktar);

                    command.ExecuteNonQuery();
                }

                connect.Close();
            }
        }

        public void TadilatKayitKalidr(string Data) {
            JObject parameters = JObject.Parse(Data);
            JToken Satir_ID;
            parameters.TryGetValue("Satir_ID", out Satir_ID);

            using (SqlConnection connect = new SqlConnection(Database.ConnectionString))
            {
                connect.Open();

                using (SqlCommand command = new SqlCommand("UPDATE Tadilatlar SET Tamamlanmis=1 WHERE id=@ID", connect))
                {
                    command.Parameters.AddWithValue("ID", Convert.ToInt32(Satir_ID.ToString()));
                    command.ExecuteNonQuery();
                }

                connect.Close();
            }
        }
    }
}