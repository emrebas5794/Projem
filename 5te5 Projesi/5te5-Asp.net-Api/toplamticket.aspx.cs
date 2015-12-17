using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;
using System.Data.OleDb;
using System.Data.SqlClient;
using System.Data;
public partial class toplamticket : System.Web.UI.Page
{
    class jsonimage
    {
        public string deger { get; set; }
        public string sirasi { get; set; }
        public string takimi { get; set; }
        public string kullaniciadi { get; set; }
        public string sayi { get; set; }


        public jsonimage( string deger,string sirasi,string takimi, string kullaniciadi, string sayi)
        {
            this.deger = deger;
            this.sirasi = sirasi;
            this.takimi = takimi;
            this.kullaniciadi = kullaniciadi;
            this.sayi = sayi;
           
           
        }
        public jsonimage() { }
    }


    protected void Page_Load(object sender, EventArgs e)
    {
        int toplam = 0;
        string takim, kullaniciadi;
     int sirasayisi1, sirasayisi2;
        if (Request.QueryString["toplamticket"] == "true")

        {
          
            kullaniciadi = Request.QueryString["kullaniciadi"];

            SqlConnection baglanti = new SqlConnection("Server=94.138.196.35;Database=asdasd;User Id=asdasd; Password=Emre1234!;");
            baglanti.Open();

            SqlCommand cmd = new SqlCommand("haftaninilkbesi", baglanti);
            cmd.CommandType = CommandType.StoredProcedure;
          
            cmd.Parameters.AddWithValue("@kullaniciadi", kullaniciadi);
          

          
            jsonimage json;
            JavaScriptSerializer ser = new JavaScriptSerializer();
            List<jsonimage> im = new List<jsonimage>();

            Boolean syc = false;
                SqlDataReader dr = cmd.ExecuteReader();
            
                while (dr.Read())
                {


                    json = new jsonimage("true",dr["sirasi"].ToString(), dr["takimi"].ToString(), dr["kullaniciadi"].ToString(), dr["ticketsayisi"].ToString());
                    im.Add(json);
                 syc=true;
                }
                if (syc==true)
                {
                    Response.Write("{'toplam':" + ser.Serialize(im) + "}");
                    
                }
                else
                {
                    Response.Write("{'toplam':[{'deger':false}]}");
                }
               
               
            
          
        
                cmd.Dispose();
                Response.End();
                baglanti.Close();
                baglanti.Dispose();


            

        }

        if (Request.QueryString["ayliktoplamticket"] == "true")
        {

            kullaniciadi = Request.QueryString["kullaniciadi"];

            SqlConnection baglanti = new SqlConnection("Server=94.138.196.35;Database=asdasd;User Id=asdasd; Password=Emre1234!;");
            baglanti.Open();

            SqlCommand cmd = new SqlCommand("ayinilkbesi", baglanti);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.AddWithValue("@kullaniciadi", kullaniciadi);
           


            jsonimage json;
            JavaScriptSerializer ser = new JavaScriptSerializer();
            List<jsonimage> im = new List<jsonimage>();

            Boolean syc = false;
            SqlDataReader dr = cmd.ExecuteReader();

            while (dr.Read())
            {


                json = new jsonimage("true", dr["sirasi"].ToString(), dr["takimi"].ToString(), dr["kullaniciadi"].ToString(), dr["ticketsayisi"].ToString());
                im.Add(json);
                syc = true;
            }
            if (syc == true)
            {
                Response.Write("{'toplam':" + ser.Serialize(im) + "}");

            }
            else
            {
                Response.Write("{'toplam':[{'deger':false}]}");
            }





            cmd.Dispose();
            Response.End();
            baglanti.Close();
            baglanti.Dispose();




        }


        string kullaniciid;
        if (Request.QueryString["toplamticketsayisi"] == "true")
        {
            kullaniciid = Request.QueryString["kullaniciid"];
            SqlConnection baglanti = new SqlConnection("Server=94.138.196.35;Database=asdasd;User Id=asdasd; Password=Emre1234!;");
            baglanti.Open();

            SqlCommand cmd = new SqlCommand("toplamticketsayisi", baglanti);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@kullaniciid", kullaniciid);

              SqlDataReader dr = cmd.ExecuteReader();
              while (dr.Read())
              {
                  Response.Write("{'toplam':[{'toplamticket':'" + dr["toplamticket"].ToString() + "'}]}");
              }


        }




    }
}