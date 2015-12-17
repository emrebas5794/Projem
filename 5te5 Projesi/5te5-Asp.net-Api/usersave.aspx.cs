using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Web.Script.Serialization;

public partial class usersave : System.Web.UI.Page
{
    class jsonimage
    {
        public string deger { get; set; }
        public string uyeid { get; set; }


        public jsonimage(string deger, string uyeid)
        {
            this.deger = deger;
            this.uyeid = uyeid;

        }
        public jsonimage() { }
    }


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

    string eposta, takimi, ad, soyad, kullaniciadi, sifre, androidid, sifrele, hasie;
    protected void Page_Load(object sender, EventArgs e)
    {
       

        if ((Request.QueryString["uyekaydet"] == "true"))
        {
            eposta = Request.QueryString["eposta"];
            takimi = Request.QueryString["takimi"];
            ad = Request.QueryString["ad"];
            soyad = Request.QueryString["soyad"];
            kullaniciadi = Request.QueryString["kullaniciadi"];
            sifre = Request.QueryString["sifre"];
            androidid = Request.QueryString["androidid"];
            
	


            bool kontrolsonuc = yasaklikelimekontrol(kullaniciadi + " " + sifre + " " + eposta + takimi + " " + ad + " " + soyad);
            if (kontrolsonuc)
            {

                SqlConnection baglanti = new SqlConnection("Server=94.138.196.35;Database=asdasd;User Id=asdasd; Password=Emre1234!;");
                baglanti.Open();


               
                    
               

                SqlCommand cmd = new SqlCommand("uyekaydet", baglanti);

                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@eposta", eposta);
                cmd.Parameters.AddWithValue("@takimi", takimi);
                cmd.Parameters.AddWithValue("@ad", ad);
                cmd.Parameters.AddWithValue("@soyad", soyad);
                cmd.Parameters.AddWithValue("@kullaniciadi", kullaniciadi);
                cmd.Parameters.AddWithValue("@sifre", sifre);
                cmd.Parameters.AddWithValue("@androidid", androidid);

                jsonimage json;
                JavaScriptSerializer ser = new JavaScriptSerializer();
                List<jsonimage> im = new List<jsonimage>();

                SqlDataReader oku = cmd.ExecuteReader();
                while ((oku.Read()))
                {

                    oku["uyeid"].ToString();
                    json = new jsonimage("true", oku["uyeid"].ToString());
                    im.Add(json);
                }
                Response.Write("{'uye':" + ser.Serialize(im) + "}");
                oku.Close();


                

                Response.End();
                baglanti.Close();

            }
            else
            {
                Response.Write("{'uye':[{'deger':kotu}]}");
            }
        }
    }
}