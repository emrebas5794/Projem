using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;
using System.Data.SqlClient;
using System.Data;

public partial class soru3 : System.Web.UI.Page
{

    class jsonimage
    {

        public string soruid { get; set; }
        public string soru { get; set; }
        public string cevapa { get; set; }
        public string cevapb { get; set; }
        public string cevapc { get; set; }
        public string cevapd { get; set; }
        public string dogrucevap { get; set; }

        public jsonimage(string soruid, string soru, string cevapa, string cevapb, string cevapc, string cevapd, string dogrucevap)
        {
            this.soruid = soruid;
            this.soru = soru;
            this.cevapa = cevapa;
            this.cevapb = cevapb;
            this.cevapc = cevapc;
            this.cevapd = cevapd;
            this.dogrucevap = dogrucevap;
        }
        public jsonimage() { }
    }
    protected void Page_Load(object sender, EventArgs e)
    {

        string kullaniciid;
        //json istegi olup olmadığını kontrol et
        if (Request.QueryString["GuncelSorular"] == "true")
        {
            kullaniciid = Request.QueryString["kullaniciid"];
            SqlConnection baglanti = new SqlConnection("Server=94.138.196.35;Database=asdasd;User Id=asdasd; Password=Emre1234!;");
            baglanti.Open();
            int sayi = 3;

            SqlCommand cmd = new SqlCommand("GuncelSoruGetir", baglanti);

            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.AddWithValue("@derece", sayi);
            cmd.Parameters.AddWithValue("@kullaniciid", kullaniciid);

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

                json = new jsonimage(oku["id"].ToString(), oku["soru"].ToString(), oku["cevapa"].ToString(), oku["cevapb"].ToString(), oku["cevapc"].ToString(), oku["cevapd"].ToString(), oku["dogrucevap"].ToString());
                im.Add(json);


            }




            // browser'a içerik bilgisini yolluyoruz
            // Response.ContentType = "application/JSON";
            // browsera json datamızı elde edip yolluyoruz
            Response.Write("{'sorular':" + ser.Serialize(im) + "}");
            //browser'a cevabın bittiğini söylüyoruz
            Response.End();
            baglanti.Close();
        }





        //json istegi olup olmadığını kontrol et
        if (Request.QueryString["sorular"] == "true")
        {
            SqlConnection baglanti = new SqlConnection("Server=94.138.196.35;Database=asdasd;User Id=asdasd; Password=Emre1234!;");
            baglanti.Open();
            int sayi = 3;

            SqlCommand cmd = new SqlCommand("sorugetir", baglanti);

            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.AddWithValue("@soruid", sayi);

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

                json = new jsonimage(oku["id"].ToString(), oku["soru"].ToString(), oku["cevapa"].ToString(), oku["cevapb"].ToString(), oku["cevapc"].ToString(), oku["cevapd"].ToString(), oku["dogrucevap"].ToString());
                im.Add(json);


            }




            // browser'a içerik bilgisini yolluyoruz
            // Response.ContentType = "application/JSON";
            // browsera json datamızı elde edip yolluyoruz
            Response.Write("{'sorular':" + ser.Serialize(im) + "}");
            //browser'a cevabın bittiğini söylüyoruz
            Response.End();
            baglanti.Close();
        }

    }
}