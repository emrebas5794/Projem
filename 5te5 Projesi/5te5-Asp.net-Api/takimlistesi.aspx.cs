using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Web.Script.Serialization;

public partial class takimlistesi : System.Web.UI.Page
{
    class jsonimage
    {
        public string takimid { get; set; }
        public string takimadi { get; set; }
        public string takimresmi { get; set; }


        public jsonimage(string takimid, string takimadi, string takimresmi)
        {
            this.takimid = takimid;
            this.takimadi = takimadi;
            this.takimresmi = takimresmi;
          
        }
        public jsonimage() { }
    }
    class jsonimage2
    {
        public string takimresim { get; set; }
        public string facebook { get; set; }

        public string facebook_paylas { get; set; }
        public string yildiz_ver { get; set; }
        public string versiyon_Kontrol { get; set; }



        public jsonimage2(string takimresim, string facebook, string facebook_paylas, string yildiz_ver, string versiyon_Kontrol)
        {
            this.takimresim = takimresim;
           
             this.facebook = facebook;
             this.facebook_paylas = facebook_paylas;
             this.yildiz_ver = yildiz_ver;
             this.versiyon_Kontrol = versiyon_Kontrol;
        }
        public jsonimage2() { }
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        SqlConnection baglanti = new SqlConnection("Server=94.138.196.35;Database=asdasd;User Id=asdasd; Password=Emre1234!;");
      
        if ((Request.QueryString["takimlistesi"] == "true"))
        {

            baglanti.Open();
            SqlCommand cmd = new SqlCommand("takimlistesi", baglanti);

            cmd.CommandType = CommandType.StoredProcedure;
            jsonimage json;
            //Json datamızı oluşturacak classımız
            JavaScriptSerializer ser = new JavaScriptSerializer();

            // birden fazla data objemızı json'a çevirmek için objeleri liste halinde 
            // teker teker yaratıp listeye ekliyoruz.
            // json objemizi temsil edecek jsonimage tipi List'yi oluşturuyoruz

            List<jsonimage> im = new List<jsonimage>();
          
            SqlDataReader oku = cmd.ExecuteReader();
            while ((oku.Read()))
            {

                json = new jsonimage(oku["id"].ToString(), oku["takim"].ToString(), oku["takimresmi"].ToString());
                im.Add(json);
                

            }
            Response.Write("{'takimlistesi':" + ser.Serialize(im) + "}");
            oku.Close();
            Response.End();
            baglanti.Close();
        }

        if ((Request.QueryString["takimresim"] == "true"))
        {
            baglanti.Open();
           string kullaniciid = Request.QueryString["kullaniciid"];




            SqlCommand cmd = new SqlCommand("kullanicitakimresim", baglanti);

            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.AddWithValue("@kullaniciid", kullaniciid);

            jsonimage2 json;
            //Json datamızı oluşturacak classımız
            JavaScriptSerializer ser = new JavaScriptSerializer();

            // birden fazla data objemızı json'a çevirmek için objeleri liste halinde 
            // teker teker yaratıp listeye ekliyoruz.
            // json objemizi temsil edecek jsonimage tipi List'yi oluşturuyoruz

            List<jsonimage2> im = new List<jsonimage2>();

            SqlDataReader oku = cmd.ExecuteReader();

             while ((oku.Read()))
            {
                json = new jsonimage2(oku["takimresmi"].ToString(), oku["facebook_Begeni"].ToString(), oku["facebook_Paylas"].ToString(), oku["yildiz_Ver"].ToString(), oku["versiyon_Kontrol"].ToString());
                im.Add(json);
            }
             Response.Write("{'takimresmi':" + ser.Serialize(im) + "}");
            oku.Close();
            Response.End();
            baglanti.Close();
        }
       
    }
}