using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;
using System.Web.Script.Serialization;

public partial class xml : System.Web.UI.Page
{
    class jsonimage
    {
        public string baslik { get; set; }
        public string link { get; set; }
        public string icerik { get; set; }



        public jsonimage(string baslik, string link, string icerik)
        {
            this.baslik = baslik;
            this.link = link;
            this.icerik = icerik;
            

        }
        public jsonimage() { }
    }
    protected void Page_Load(object sender, EventArgs e)
    {
       
           

            XmlDocument dokuman = new XmlDocument();
            dokuman.Load("http://www.ligtv.com.tr/rss/takim/fenerbahce");

            XmlElement rootEleman = dokuman.DocumentElement;

            XmlNodeList liste = rootEleman.GetElementsByTagName("item");


            jsonimage json;
            //Json datamızı oluşturacak classımız
            JavaScriptSerializer ser = new JavaScriptSerializer();

            // birden fazla data objemızı json'a çevirmek için objeleri liste halinde 
            // teker teker yaratıp listeye ekliyoruz.
            // json objemizi temsil edecek jsonimage tipi List'yi oluşturuyoruz

            List<jsonimage> im = new List<jsonimage>();

            foreach (XmlNode item in liste)
            {
               

                XmlElement currency = (XmlElement)item;
                string isim = currency.GetElementsByTagName("title").Item(0).InnerText;



                string alisFiyati = currency.GetElementsByTagName("link").Item(0).InnerText;




                string satisFiyati = currency.GetElementsByTagName("description").Item(0).InnerText;




             

             
                

                json = new jsonimage(isim,alisFiyati,satisFiyati);
                im.Add(json);
            }
            Response.Write(ser.Serialize(im));
    }
}