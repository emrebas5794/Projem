using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Mail;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net;
using System.Data.SqlClient;
using System.Data;
using System.Web.Script.Serialization;

public partial class mailat : System.Web.UI.Page
{


    class jsonimage
    {
        public Boolean  deger { get; set; }


        public jsonimage(Boolean deger)
        {
            this.deger = deger;
            
        }
        public jsonimage() { }
    }

    string email,eposta,ad,soyad,kullaniciadi,sifre;
    protected void Page_Load(object sender, EventArgs e)
    {
        email = Request.QueryString["email"].ToString();
        SqlConnection baglanti = new SqlConnection("Server=94.138.196.35;Database=asdasd;User Id=asdasd; Password=Emre1234!;");
        baglanti.Open();

        SqlCommand cmd = new SqlCommand("MailBilgiGetir", baglanti);

        cmd.CommandType = CommandType.StoredProcedure;

        cmd.Parameters.AddWithValue("@eposta", email);
        int syc = 0;
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

          eposta=  oku["eposta"].ToString();
           
            ad =oku["ad"].ToString();
            soyad= oku["soyad"].ToString();
           kullaniciadi= oku["kullaniciadi"].ToString();
            sifre= oku["sifre"].ToString();
            syc++;

        }
      
        if (syc==1)
        {
            MailMessage Mesaj = new MailMessage();
            Mesaj.From = new MailAddress("emre@otelservisi.com","5TE5");
            Mesaj.To.Add(email);
            Mesaj.Subject = "5TE5 Kullanıcı Bilgileri";
            Mesaj.IsBodyHtml = true;
            Mesaj.Body = "<body><b>5te5 Kulllanıcı Bilgileriniz</b> <br/>Kullanıcı ADI :" + kullaniciadi + "<br/>  <br/>Şifre :" + sifre + "<br/>  <br/>Adı :" + ad + "<br/>  <br/>Soyad :" + soyad + "<br/>  <br/>E-postanız :" + eposta + "<br/></body>";
            SmtpClient smtp = new SmtpClient("webmail.otelservisi.com", 25);
            System.Net.NetworkCredential SMTPUserInfo = new System.Net.NetworkCredential("emre@otelservisi.com", "Emre1994#");
            smtp.UseDefaultCredentials = true;
            smtp.EnableSsl = false;
            smtp.Credentials = SMTPUserInfo;
            smtp.Send(Mesaj);
            json = new jsonimage(true);
            im.Add(json);
            
            
        }
        else
        {
            json = new jsonimage(false);
            im.Add(json);
           
        }
        Response.Write("{'email':" + ser.Serialize(im) + "}");
        oku.Close();
        Response.End();
        baglanti.Close();

    
        


              
          

    }
}