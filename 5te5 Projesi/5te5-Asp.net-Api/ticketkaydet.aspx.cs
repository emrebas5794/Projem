using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;
using System.Data.SqlClient;
using System.Data;
public partial class ticketkaydet : System.Web.UI.Page
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
        if ((Request.QueryString["ticketekle"] == "true"))
        {
            kullaniciid = Request.QueryString["kullaniciid"];




            SqlCommand cmd = new SqlCommand("ticketkaydet", baglanti);

            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.AddWithValue("@kulid", kullaniciid);

            SqlDataReader oku = cmd.ExecuteReader();

            Response.Write("{'ticket':[{'deger':true'}]}");

            oku.Close();
            
        }
          if ((Request.QueryString["jokerekle"] == "true"))
        {
            kullaniciid = Request.QueryString["kullaniciid"];
            SqlCommand cmd2 = new SqlCommand("jokerekle", baglanti);

            cmd2.CommandType = CommandType.StoredProcedure;

            cmd2.Parameters.AddWithValue("@kullaniciid", kullaniciid);

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
          if ((Request.QueryString["facebookjoker"] == "true"))
          {
              kullaniciid = Request.QueryString["kullaniciid"];

              SqlCommand cmd5 = new SqlCommand("Facebook_joker_ekle", baglanti);

              cmd5.CommandType = CommandType.StoredProcedure;

              cmd5.Parameters.AddWithValue("@kullaniciid", kullaniciid);


              SqlDataReader oku5 = cmd5.ExecuteReader();

              Response.Write("{'Facebook_joker_ekle':[{'deger':true'}]}");
              oku5.Close();
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
        baglanti.Close();
        
  }

}