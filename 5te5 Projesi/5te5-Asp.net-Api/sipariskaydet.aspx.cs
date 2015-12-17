using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class sipariskaydet : System.Web.UI.Page
{
    class jsonimage
    {
        public string deger { get; set; }
        public string id { get; set; }


        public jsonimage(string deger, string id)
        {
            this.deger = deger;
            this.id = id;

        }
        public jsonimage() { }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        string ad, soyad, adres, adet,litre,marka;
      

        if ((Request.QueryString["sipariskaydet"] == "true"))
        {
            char[] ayrac = { '-' };
            ad = Request.QueryString["ad"];
            soyad = Request.QueryString["soyad"];
            adres = Request.QueryString["adres"];
            adet = Request.QueryString["adet"];
            litre = Request.QueryString["litre"];
            marka = Request.QueryString["marka"];

            ad = ad.Replace("-", " ");
            soyad = soyad.Replace("-", " ");
            adres = adres.Replace("-", " ");
            adet = adet.Replace("-", " ");
            string[] litredizi = litre.Split(ayrac);
            marka = marka.Replace("-", " ");



            SqlConnection baglanti = new SqlConnection("Server=94.138.196.35;Database=asdasd;User Id=asdasd; Password=Emre1234!;");
            baglanti.Open();




            SqlCommand cmd = new SqlCommand("sipariskaydet", baglanti);

            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.AddWithValue("@ad", ad);
            cmd.Parameters.AddWithValue("@soyad", soyad);
            cmd.Parameters.AddWithValue("@adres", adres);
            cmd.Parameters.AddWithValue("@adet", adet);
            cmd.Parameters.AddWithValue("@litre", litredizi[0]);
            cmd.Parameters.AddWithValue("@marka", marka);

            jsonimage json;
            JavaScriptSerializer ser = new JavaScriptSerializer();
            List<jsonimage> im = new List<jsonimage>();

            SqlDataReader oku = cmd.ExecuteReader();
            while ((oku.Read()))
            {

                oku["id"].ToString();
                json = new jsonimage("true", oku["id"].ToString());
                im.Add(json);
            }
            Response.Write("{'kayit':" + ser.Serialize(im) + "}");
            oku.Close();




            Response.End();
            baglanti.Close();
           
        }
    }
}