using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Web.Script.Serialization;

public partial class sorruyolla : System.Web.UI.Page
{
    class jsonimage
    {
        public string deger { get; set; }
      


        public jsonimage(string deger)
        {
            this.deger = deger;
           

        }
        public jsonimage() { }
    }
    string kullanicisorusu, kullaniciid, tokenid, tokenidsyc;
    protected void Page_Load(object sender, EventArgs e)
    {
     
        if ((Request.QueryString["kullanicisorukaydet"] == "true"))
        {
            kullanicisorusu = Request.QueryString["kullanicisorusu"];
            kullaniciid = Request.QueryString["kullaniciid"];
            tokenid = Request.QueryString["tokenid"];

            SqlConnection baglanti = new SqlConnection("Server=94.138.196.35;Database=asdasd;User Id=asdasd; Password=Emre1234!;");
                 baglanti.Open();

                

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
                     SqlCommand cmd = new SqlCommand("kullanicisoruekle", baglanti);

                     cmd.CommandType = CommandType.StoredProcedure;

                     cmd.Parameters.AddWithValue("@soru", kullanicisorusu);
                     cmd.Parameters.AddWithValue("@kullaniciid", kullaniciid);
                     jsonimage json;
                     JavaScriptSerializer ser = new JavaScriptSerializer();
                     List<jsonimage> im = new List<jsonimage>();

                     SqlDataReader oku = cmd.ExecuteReader();

                     while ((oku.Read()))
                     {

                         oku["deger"].ToString();
                         json = new jsonimage("true");
                         im.Add(json);
                     }
                     Response.Write("{'kullanicisorusu':" + ser.Serialize(im) + "}");
                     oku.Close();
                 }



                 Response.End();
                 baglanti.Close();

             }
             
        }

    }
