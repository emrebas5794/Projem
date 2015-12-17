using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Web.Script.Serialization;
using System.Data;
using System.IO;
using System.Runtime.Serialization.Formatters.Binary;
using System.Text;
using System.Security.Cryptography;

public partial class sayiekle : System.Web.UI.Page
{
    class jsonimage
    {
        public string islem { get; set; }



        public jsonimage(string islem)
        {
            this.islem = islem;


        }
        public jsonimage() { }
    }
    class jsonimage2
    {
        public string deger{ get; set; }



        public jsonimage2(string deger)
        {
            this.deger = deger;


        }
        public jsonimage2() { }
    }
    class jsonjokersayisi
    {
        public string jokersayisi { get; set; }



        public jsonjokersayisi(string jokersayisi)
        {
            this.jokersayisi = jokersayisi;


        }
        public jsonjokersayisi() { }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        SqlConnection baglanti = new SqlConnection("Server=94.138.196.35;Database=asdasd;User Id=asdasd; Password=Emre1234!;");
        baglanti.Open();
        string kullaniciid = null;
        string jokersayisi = null;
        int ticket;
        string tokenidsyc = "";
        string tokenid;

        kullaniciid = Request.QueryString["kullaniciid"];
        tokenid = Request.QueryString["tokenid"];
      
      

      
            SqlCommand tokenkontrol = new SqlCommand("tokenkontrol", baglanti);
            tokenkontrol.CommandType = CommandType.StoredProcedure;
            tokenkontrol.Parameters.AddWithValue("@kullaniciid", kullaniciid);
            tokenkontrol.Parameters.AddWithValue("@tokenid", tokenid);

            SqlDataReader tokenkontroloku = tokenkontrol.ExecuteReader();
            while ((tokenkontroloku.Read()))
            {
                tokenidsyc = tokenkontroloku["kontrol"].ToString();
            }
            tokenkontroloku.Close();
          
        
        
       

        if (tokenidsyc == "1")
        {
        if ((Request.QueryString["ticketekle"] == "true"))
        {

                jsonimage2 json2;
                //Json datamızı oluşturacak classımız
                JavaScriptSerializer ser2 = new JavaScriptSerializer();

                // birden fazla data objemızı json'a çevirmek için objeleri liste halinde 
                // teker teker yaratıp listeye ekliyoruz.
                // json objemizi temsil edecek jsonimage tipi List'yi oluşturuyoruz

                List<jsonimage2> im2 = new List<jsonimage2>();

                SqlCommand cmd = new SqlCommand("ticketkaydet", baglanti);

                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@kulid", kullaniciid);

                SqlDataReader oku = cmd.ExecuteReader();

                json2 = new jsonimage2("true");
                im2.Add(json2);

                oku.Close();
               
             
                  
                  
                    Response.Write("{'ticket':" + ser2.Serialize(im2) + "}");
                   
             
               

            }
        string nerden;
            if ((Request.QueryString["jokerekle"] == "true"))
            {
                kullaniciid = Request.QueryString["kullaniciid"];
                nerden = Request.QueryString["nerden"];
                SqlCommand cmd2 = new SqlCommand("jokerekle", baglanti);

                cmd2.CommandType = CommandType.StoredProcedure;

                cmd2.Parameters.AddWithValue("@kullaniciid", kullaniciid);
                cmd2.Parameters.AddWithValue("@nerden", nerden);

                SqlDataReader oku2 = cmd2.ExecuteReader();

                Response.Write("{'jokerekle':[{'deger':true'}]}");
                oku2.Close();
            }
            if ((Request.QueryString["jokersil"] == "true"))
            {
                kullaniciid = Request.QueryString["kullaniciid"];
                jokersayisi = Request.QueryString["jokersayisi"];
                SqlCommand cmd3 = new SqlCommand("jokersil", baglanti);

                cmd3.CommandType = CommandType.StoredProcedure;

                cmd3.Parameters.AddWithValue("@kullaniciid", kullaniciid);
                cmd3.Parameters.AddWithValue("@jokersayisi", jokersayisi);

                SqlDataReader oku3 = cmd3.ExecuteReader();

                Response.Write("{'jokersil':[{'deger':true'}]}");
                oku3.Close();
            }
            if ((Request.QueryString["jokersayisi"] == "true"))
            {
                kullaniciid = Request.QueryString["kullaniciid"];
                SqlCommand cmd4 = new SqlCommand("jokersayisi", baglanti);

                cmd4.CommandType = CommandType.StoredProcedure;

                cmd4.Parameters.AddWithValue("@kullaniciid", kullaniciid);


                jsonjokersayisi json;
                //Json datamızı oluşturacak classımız
                JavaScriptSerializer ser = new JavaScriptSerializer();

                // birden fazla data objemızı json'a çevirmek için objeleri liste halinde 
                // teker teker yaratıp listeye ekliyoruz.
                // json objemizi temsil edecek jsonimage tipi List'yi oluşturuyoruz

                List<jsonjokersayisi> im = new List<jsonjokersayisi>();
                SqlDataReader oku4 = cmd4.ExecuteReader();
                while ((oku4.Read()))
                {

                    json = new jsonjokersayisi(oku4["jokersayisi"].ToString());
                    im.Add(json);


                }
                Response.Write("{'rjokersayisi':" + ser.Serialize(im) + "}");
                oku4.Close();
            }
        }
        else
        {

        }
        baglanti.Close();
        

    }
    public static class HashHelper
    {
        public static string ComputeHash(string data)
        {
            string key = "besibiyerde";
            byte[] keyBytes = Encoding.UTF8.GetBytes(key);


            byte[] dataBytes = Encoding.UTF8.GetBytes(data);

            HMACSHA1 algorithm = new HMACSHA1(keyBytes);

            byte[] hash = algorithm.ComputeHash(dataBytes);

            return ByteArrayToHexString(hash);

        }

        public static string ByteArrayToHexString(byte[] bytes)
        {
            StringBuilder sb = new StringBuilder();
            foreach (byte b in bytes)
            {
                sb.AppendFormat("{0:x2}", b);
            }
            return sb.ToString();
        }

    }
}