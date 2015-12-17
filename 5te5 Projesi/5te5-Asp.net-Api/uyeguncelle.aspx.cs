using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class uyeguncelle : System.Web.UI.Page
{
    public bool yasaklikelimekontrol(string kullaniciVerileri)
    {
        string[] strList = kullaniciVerileri.Split(' ');
        string[] yasakliKelimeler ={"where","select","from","delete","drop","alter table",
                                      "insert into","uptade","set","join","script",
                                      "boby","alert","insert","table"
                                  
                                  };
        for (int i = 0; i < strList.Length; i++)
        {
            for (int j = 0; j < yasakliKelimeler.Length; j++)
            {

                if (strList[i] == yasakliKelimeler[j])
                {
                    return false;
                }
            }

        }
        return true;


    }
    protected void Page_Load(object sender, EventArgs e)
    {
        SqlConnection baglanti = new SqlConnection("Server=94.138.196.35;Database=asdasd;User Id=asdasd; Password=Emre1234!;");

        string eposta, takimi, ad, soyad, kullaniciadi, sifre, androidid,tokenid;
        string id;
        string tokenidsyc="";

        
             baglanti.Open();
             string kullaniciid = null;

             if ((Request.QueryString["uyeguncelle"] == "true"))
             {
                 eposta = Request.QueryString["eposta"];
                 ad = Request.QueryString["ad"];
                 soyad = Request.QueryString["soyad"];
                 kullaniciadi = Request.QueryString["kullaniciadi"];
                 sifre = Request.QueryString["sifre"];
                 id = Request.QueryString["uyeid"];
                 tokenid = Request.QueryString["tokenid"];

                 SqlCommand tokenkontrol = new SqlCommand("tokenkontrol", baglanti);
                 tokenkontrol.CommandType = CommandType.StoredProcedure;
                 tokenkontrol.Parameters.AddWithValue("@kullaniciid", id);
                 tokenkontrol.Parameters.AddWithValue("@tokenid", tokenid);
                
                 SqlDataReader tokenkontroloku = tokenkontrol.ExecuteReader();
                 while ((tokenkontroloku.Read()))
                 {
                     tokenidsyc = tokenkontroloku["kontrol"].ToString();
                 }
                 tokenkontroloku.Close();
                
                 bool kontrolsonuc = yasaklikelimekontrol(kullaniciadi + " " + sifre + " " + eposta +" " + ad + " " + soyad);
                 if (kontrolsonuc)
                 {
                     if ((Convert.ToInt32(kullaniciadi.Length) > 11))
                     {
                         Response.Write("{'uyeguncele':[{'deger':kullaniciadi}]}");
                     }
                     else
                     {
                 SqlCommand kontrol = new SqlCommand("kullaniciadiepostakontrol", baglanti);
                 kontrol.CommandType = CommandType.StoredProcedure;

                 int syc = 0;
                 SqlDataReader kontroloku = kontrol.ExecuteReader();
                 while ((kontroloku.Read()))
                 {

                     
                   

                         if ((kontroloku["eposta"].ToString() == eposta) && (kontroloku["id"].ToString() != id))
                         {
                             while ((kontroloku.Read()))
                             {
                                 if (kontroloku["kullaniciadi"].ToString() == kullaniciadi)
                                 {
                                     Response.Write("{'uyeguncele':[{'deger':epostakullaniciadi}]}");
                                     break;
                                 }
                                 else
                                 {
                                     Response.Write("{'uyeguncele':[{'deger':eposta}]}");
                                     break;
                                 }
                             }

                             syc = 1;
                             break;
                         }
                         if ((kontroloku["kullaniciadi"].ToString() == kullaniciadi) && (kontroloku["id"].ToString() != id))
                         {
                             while ((kontroloku.Read()))
                             {
                                 if (kontroloku["eposta"].ToString() == eposta)
                                 {
                                     Response.Write("{'uyeguncele':[{'deger':epostakullaniciadi}]}");
                                     break;
                                 }
                                 else
                                 {
                                     Response.Write("{'uyeguncele':[{'deger':kullaniciadi}]}");
                                     break;
                                 }
                             }
                             syc = 1;
                             break;
                         }
                     }
                
                 kontroloku.Close();

                 if (tokenidsyc == "1")
                 {
                 
                 if (syc == 0)
                 {


                     SqlCommand cmd = new SqlCommand("uyeguncelle", baglanti);
                     cmd.CommandType = CommandType.StoredProcedure;
                     cmd.Parameters.AddWithValue("@eposta", eposta);
                     cmd.Parameters.AddWithValue("@ad", ad);
                     cmd.Parameters.AddWithValue("@soyad", soyad);
                     cmd.Parameters.AddWithValue("@kullaniciadi", kullaniciadi);
                     cmd.Parameters.AddWithValue("@sifre", sifre);
                     cmd.Parameters.AddWithValue("@id", id);
                     SqlDataReader oku = cmd.ExecuteReader();

                     Response.Write("{'uyeguncele':[{'deger':true}]}");
                     oku.Close();


                 }
                 }
                 else
                 {
                     Response.Write("{'uyeguncele':[{'deger':kotu}]}"); 
                 }
                 Response.End();
                 baglanti.Close();
             }
                 }
                 else
                 {
                     Response.Write("{'uyeguncele':[{'deger':kotu}]}");
                 }

         }
        
       
        
    }
}