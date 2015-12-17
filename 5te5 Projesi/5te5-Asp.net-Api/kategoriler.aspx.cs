using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class kategoriler : System.Web.UI.Page
{
    class KategoriGoster
    {

        public string id { get; set; }
        public string Kategori_Adi { get; set; }



        public KategoriGoster(string id, string Kategori_Adi)
        {
            this.id = id;
            this.Kategori_Adi = Kategori_Adi;
           
        }
        public KategoriGoster() { }



    }
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["kategorigoster"] == "true")
        {
            SqlConnection baglanti = new SqlConnection("Server=94.138.196.35;Database=asdasd;User Id=asdasd; Password=Emre1234!;");
            baglanti.Open();
            SqlCommand cmd = new SqlCommand("Kategori_Goster", baglanti);

            cmd.CommandType = CommandType.StoredProcedure;

            KategoriGoster json;
            //Json datamızı oluşturacak classımız
            JavaScriptSerializer ser = new JavaScriptSerializer();

            // birden fazla data objemızı json'a çevirmek için objeleri liste halinde 
            // teker teker yaratıp listeye ekliyoruz.
            // json objemizi temsil edecek jsonimage tipi List'yi oluşturuyoruz

            List<KategoriGoster> im = new List<KategoriGoster>();
            SqlDataReader oku = cmd.ExecuteReader();


            while ((oku.Read()))
            {

                json = new KategoriGoster(oku["id"].ToString(), oku["Kategori_Adi"].ToString());
                im.Add(json);


            }
            Response.Write("{'kategoriler':" + ser.Serialize(im) + "}");
            //browser'a cevabın bittiğini söylüyoruz
            Response.End();
            baglanti.Close();

        }
    }
}