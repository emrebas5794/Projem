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
    string eposta, kullaniciadi;
    int syc=0;
    int syc2=0;
    protected void Page_Load(object sender, EventArgs e)
    {
        eposta = Request.QueryString["eposta"];
        kullaniciadi = Request.QueryString["kullaniciadi"]; 
        SqlConnection baglanti = new SqlConnection("Server=94.138.196.30;Database=bestebesdb;User Id=bestebes; Password=database1234;");
        baglanti.Open();
        SqlCommand kontrol = new SqlCommand("kullaniciadiepostakontrol", baglanti);
        kontrol.CommandType = CommandType.StoredProcedure;

       
        SqlDataReader kontroloku = kontrol.ExecuteReader();

        while ((kontroloku.Read()))
        {


            if ((kontroloku["eposta"].ToString() == eposta))
            {
                while ((kontroloku.Read()))
                {
                    if (kontroloku["kullaniciadi"].ToString() == kullaniciadi)
                    { syc2 = 1;
                    break;
                       
                    }
                    else
                    { syc2 = 3;  }
                }

                break;
                
            }

            if ((kontroloku["kullaniciadi"].ToString() == kullaniciadi))
            {
                while ((kontroloku.Read()))
                {
                    if (kontroloku["eposta"].ToString() == eposta)
                    {syc2 = 1;
                    break;
                    }
                    else
                    {syc2 = 2; }
                }
               
                break;
            }
           
        }
        kontroloku.Close();
        baglanti.Close();
        if (syc2 == 3)
        {
            Response.Write("{'kontrol':[{'deger':eposta}]}");

        }
        else if (syc2 == 1)
        {
            Response.Write("{'kontrol':[{'deger':epostakullaniciadi}]}");
        }
        else if (syc2 == 2)
        {
            Response.Write("{'kontrol':[{'deger':kullaniciadi}]}");
        }
        else
        {
            Response.Write("{'kontrol':[{'deger':true}]}");
        }
       
       
    }
}