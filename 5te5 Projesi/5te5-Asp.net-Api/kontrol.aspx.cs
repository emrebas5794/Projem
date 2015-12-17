using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;

public partial class kontrol : System.Web.UI.Page
{
    string eposta, kullaniciadi,androidid;
    int syc=0;
    int syc2=0;
    protected void Page_Load(object sender, EventArgs e)
    {
        eposta = Request.QueryString["eposta"];
        kullaniciadi = Request.QueryString["kullaniciadi"];
        androidid = Request.QueryString["androidid"];

        SqlConnection baglanti = new SqlConnection("Server=94.138.196.35;Database=asdasd;User Id=asdasd; Password=Emre1234!;");
        baglanti.Open();
        SqlCommand kontrol = new SqlCommand("uyekontrol", baglanti);
        kontrol.CommandType = CommandType.StoredProcedure;
        kontrol.Parameters.AddWithValue("@kullaniciadi", kullaniciadi);
        kontrol.Parameters.AddWithValue("@eposta", eposta);
        kontrol.Parameters.AddWithValue("@androidid", androidid);
       
        SqlDataReader kontroloku = kontrol.ExecuteReader();

        while ((kontroloku.Read()))
        {
            if ((Convert.ToInt32(kontroloku["karektersayi"]) > 11))
            {
                Response.Write("{'kontrol':[{'deger':kullaniciadi}]}");
            }
            else
            {

                if ((kontroloku["eposta"].ToString() == "1") && (kontroloku["kullaniciadi"].ToString() == "1") && (kontroloku["androidid"].ToString() == "1"))
                {
                    Response.Write("{'kontrol':[{'deger':kullaniciadiepostaandroidid}]}");
                }
                else if ((kontroloku["eposta"].ToString() == "0") && (kontroloku["kullaniciadi"].ToString() == "1") && (kontroloku["androidid"].ToString() == "1"))
                {
                    Response.Write("{'kontrol':[{'deger':kullaniciadiandroidid}]}");

                }
                else if ((kontroloku["eposta"].ToString() == "1") && (kontroloku["kullaniciadi"].ToString() == "0") && (kontroloku["androidid"].ToString() == "1"))
                {
                    Response.Write("{'kontrol':[{'deger':epostaandroidid}]}");
                }
                else if ((kontroloku["eposta"].ToString() == "1") && (kontroloku["kullaniciadi"].ToString() == "1") && (kontroloku["androidid"].ToString() == "0"))
                {
                    Response.Write("{'kontrol':[{'deger':kullaniciadieposta}]}");
                }
                else if ((kontroloku["eposta"].ToString() == "0") && (kontroloku["kullaniciadi"].ToString() == "0") && (kontroloku["androidid"].ToString() == "1"))
                {
                    Response.Write("{'kontrol':[{'deger':androidid}]}");
                }
                else if ((kontroloku["eposta"].ToString() == "0") && (kontroloku["kullaniciadi"].ToString() == "1") && (kontroloku["androidid"].ToString() == "0"))
                {
                    Response.Write("{'kontrol':[{'deger':kullaniciadi}]}");
                }
                else if ((kontroloku["eposta"].ToString() == "1") && (kontroloku["kullaniciadi"].ToString() == "0") && (kontroloku["androidid"].ToString() == "0"))
                {
                    Response.Write("{'kontrol':[{'deger':eposta}]}");
                }
                else
                {
                    Response.Write("{'kontrol':[{'deger':true}]}");
                }

            }
        }
        kontroloku.Close();
        baglanti.Close();
      
       
       
    }
}