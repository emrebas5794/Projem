using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;
using System.Data.SqlClient;
using System.Data;
public partial class login : System.Web.UI.Page
{
    class jsonimage
    {
        public string deger { get; set; }
        public string uyeid { get; set; }
        public string eposta { get; set; }
        public string takimi { get; set; }
        public string ad { get; set; }
        public string soyad { get; set; }
        public string kullaniciadi { get; set; }
        public string sifre { get; set; }
        public string tokenid { get; set; }

        public jsonimage(string deger, string uyeid, string eposta, string takimi, string ad, string soyad, string kullaniciadi, string sifre, string tokenid)
        {
            this.deger = deger;
            this.uyeid = uyeid;
            this.eposta = eposta;
            this.takimi = takimi;
            this.ad = ad;
            this.soyad = soyad;
            this.kullaniciadi = kullaniciadi;
            this.sifre = sifre;
            this.tokenid = tokenid;
           
        }
        public jsonimage() { }
    }

    public bool yasaklikelimekontrol(string kullaniciVerileri)
    {
        string[] strList = kullaniciVerileri.Split(' ');
        string[] yasakliKelimeler ={"where","select","from","delete","drop","alter table",
                                      "insert into","uptade","set","join","script",
                                      "boby","alert","insert","table","or","'or'1'='1","1' or '1'='1","1'or'1'='1" 
                                  
                                  };
        for (int i = 0; i <strList.Length; i++)
        {
            for (int j = 0; j < yasakliKelimeler.Length; j++)
            {

                if (strList[i]==yasakliKelimeler[j])
                {
                    return false;
                }
            }

        }
        return true;

    
    }
    string uyeid2, eposta2, takimi2, ad2, soyad2, kullaniciadi2, sifre2,tokenid;
    protected void Page_Load(object sender, EventArgs e)
    {
        string kullaniciadi, sifre;

        kullaniciadi = Request.QueryString["kullaniciadi"].ToString();
        sifre = Request.QueryString["sifre"].ToString();

        bool kontrolsonuc = yasaklikelimekontrol(kullaniciadi + " " + sifre);
        if (kontrolsonuc)
        {

        if ((Request.QueryString["login"] == "true"))
        {


            SqlConnection baglanti = new SqlConnection("Server=94.138.196.35;Database=asdasd;User Id=asdasd; Password=Emre1234!;");
                baglanti.Open();




                SqlCommand cmd = new SqlCommand("login", baglanti);
               
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@kullaniciadi", kullaniciadi);
                cmd.Parameters.AddWithValue("@sifre", sifre);


                jsonimage json;
                //Json datamızı oluşturacak classımız
                JavaScriptSerializer ser = new JavaScriptSerializer();

                // birden fazla data objemızı json'a çevirmek için objeleri liste halinde 
                // teker teker yaratıp listeye ekliyoruz.
                // json objemizi temsil edecek jsonimage tipi List'yi oluşturuyoruz

                List<jsonimage> im = new List<jsonimage>();
                int syc = 0;
            SqlDataReader oku = cmd.ExecuteReader();
                while ((oku.Read()))
                {
                  
                  uyeid2=oku["id"].ToString();
                    eposta2=oku["eposta"].ToString();
                    takimi2= oku["takimi"].ToString();
                    ad2=oku["ad"].ToString();
                    soyad2=oku["soyad"].ToString();
                    kullaniciadi2=oku["kullaniciadi"].ToString();
                    sifre2=oku["sifre"].ToString();
                   
                    syc++;

                }

                oku.Close();
                

                if (syc==1)
                {
                    SqlCommand cmd2 = new SqlCommand("tokenguncelle", baglanti);

                    cmd2.CommandType = CommandType.StoredProcedure;

                    cmd2.Parameters.AddWithValue("@kullaniciid", uyeid2);
                    Random rnd=new Random();
                    SqlDataReader oku2 = cmd2.ExecuteReader();
                    while ((oku2.Read()))
                {
                    tokenid=rnd.Next(10000,99999)+oku2["tokenid"].ToString()+rnd.Next(10000,99999);
                    
                }
                    oku2.Close();
                    json = new jsonimage("true", uyeid2, eposta2, takimi2, ad2, soyad2, kullaniciadi2, sifre2, tokenid);
                    im.Add(json);
                    Response.Write("{'login':" + ser.Serialize(im) + "}");
                }
                else
                {
                    Response.Write("{'login':[{'deger':'false'}]}");
                }
               
                //browser'a cevabın bittiğini söylüyoruz
               
                Response.End();
                baglanti.Close();

            }
           


        }
        else
        {
            Response.Write("{'login':[{'deger':'false'}]}");
        }



    }
}