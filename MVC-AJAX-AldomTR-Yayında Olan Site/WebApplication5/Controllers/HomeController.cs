using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WebApplication5.Models;

namespace WebApplication5.Controllers
{
    public class HomeController : Controller
    {
        // GET: Home
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult Iletisim()
        {
            ViewBag.ImgUrl = "~/images/page_image_1.jpg";
            return View();
        }

        public ActionResult Aldom(string id)
        {
            ViewBag.ImgUrl = "~/images/page_image_2.jpg";
            ViewBag.Title = "Aldom";

            if (id == null)
            {
                return Redirect("~/Home/Aldom/Aldom_Markasi");
            }

            SqlConnection con = new SqlConnection(General.ConnectionString);
            SqlCommand com = new SqlCommand("SELECT PageTitle, PageText FROM Pages WHERE Controller = @cont AND Action = @act AND SubID = @id; SELECT Name, Title FROM Images WHERE Related = @act AND RelatedKey = @id;SELECT * FROM Pages WHERE Controller = @cont AND Action = @act", con);
            com.Parameters.AddWithValue("cont", "Home");
            com.Parameters.AddWithValue("act", "Aldom");
            com.Parameters.AddWithValue("id", id);
            con.Open();
            SqlDataReader rdr = com.ExecuteReader();
            rdr.Read();
            ViewBag.PageTitle = rdr["PageTitle"].ToString();
            ViewBag.PageText = rdr["PageText"].ToString();
            rdr.NextResult();
            List<ImageInfo> images = new List<ImageInfo>();
            while (rdr.Read())
            {
                images.Add(new ImageInfo() { url = "~/images/" + rdr["Name"].ToString(), alt = rdr["Title"].ToString() });
            }
            ViewBag.RigthImages = images;

            rdr.NextResult();
            List<Link> menu = new List<Link>();
            while (rdr.Read())
            {
                menu.Add(new Link() { Caption = rdr["PageTitle"].ToString(), Url = "~/Home/Aldom/" + rdr["SubID"].ToString() });
            }
            ViewBag.MenuItems = menu;
            rdr.Close();
            con.Close();



            return View("PageView");
        }

        public ActionResult Referanslar(string id)
        {
            ViewBag.ImgUrl = "~/images/page_image_3.jpg";
            ViewBag.Title = "Referanslar";

            if (id != null)
            {
                switch (id)
                {
                    default:
                        break;
                    case "Kamu_Binalari":
                        {
                            ViewBag.PageTitle = "Kamu Binaları";
                            ViewBag.PageText = String.Format("Aluminyum çözümleri, dizaynları ve  mimari sistemler konusunda lider olan SAPA bu ürünleri üretimini, dağıtımını Dünya'nın birçok ülkesinde gerçekleştirmektedir.  SAPA Group  Aldom markası ile de küresel market için geliştirmeler yapmakta, cephe, pencere, kapılar, sürme sistemler gibi bir çok segmente ürünler sunmaktadır. Aldom, 1 Eylül 2013 tarihinde  SAPA Group bünyesine katılmıştır.{0}Aldom'un 2013 yıllından itibaren katıldığı SAPA Group 23.500 çalışanı ile 40'tan daha fazla ülkede yer almakta ve merkez ofisi Oslo, Norveçte bulunmaktadır.{0}", Environment.NewLine + Environment.NewLine);
                        }
                        break;
                }
            }
            else
            {
                ViewBag.PageTitle = "Referanslar";
                ViewBag.PageText = String.Format("{0}", Environment.NewLine + Environment.NewLine);
            }

            List<Link> menu = new List<Link>();
            menu.Add(new Link() { Caption = "Kamu Binaları", Url = "#" });
            menu.Add(new Link() { Caption = "Konutlar", Url = "#" });
            menu.Add(new Link() { Caption = "Ticari Binalar", Url = "#" });
            menu.Add(new Link() { Caption = "Endüstriyel Binalar", Url = "#" });
            ViewBag.MenuItems = menu;

            return View("PageView");
        }
        
        public ActionResult Yesil_Aluminyum(string id)
        {
            ViewBag.ImgUrl = "~/images/page_image_5.jpg";
            ViewBag.Title = "Yeşil Alüminyum";

            if (id == null)
            {
                return Redirect("~/Home/Yesil_Aluminyum/Aluminyum_Yasam_Dongusu");
            }

            SqlConnection con = new SqlConnection(General.ConnectionString);
            SqlCommand com = new SqlCommand("SELECT PageTitle, PageText FROM Pages WHERE Controller = @cont AND Action = @act AND SubID = @id; SELECT Name, Title FROM Images WHERE Related = @act AND RelatedKey = @id;SELECT * FROM Pages WHERE Controller = @cont AND Action = @act", con);
            com.Parameters.AddWithValue("cont", "Home");
            com.Parameters.AddWithValue("act", "Yesil_Aluminyum");
            com.Parameters.AddWithValue("id", id);
            con.Open();
            SqlDataReader rdr = com.ExecuteReader();
            rdr.Read();
            ViewBag.PageTitle = rdr["PageTitle"].ToString();
            ViewBag.PageText = rdr["PageText"].ToString();
            rdr.NextResult();
          
            List<ImageInfo> images = new List<ImageInfo>();
            while (rdr.Read())
            {
                images.Add(new ImageInfo() { url = "~/images/" + rdr["Name"].ToString(), alt = rdr["Title"].ToString() });
               
            }
            ViewBag.RigthImages = images;

            rdr.NextResult();
            List<Link> menu = new List<Link>();
             while (rdr.Read())
            {
                menu.Add(new Link() { Caption = rdr["PageTitle"].ToString(), Url = "~/Home/Yesil_Aluminyum/" + rdr["SubID"].ToString() });
            }
            ViewBag.MenuItems = menu;
            rdr.Close();
            con.Close();
          
            return View("PageView");
        }

        public ActionResult Distributor(string id)
        {
            ViewBag.ImgUrl = "~/images/page_image_2.jpg";
            ViewBag.Title = "Distribütörler";

            if (id == null)
            {
                return Redirect("~/Home/Distributor/Optimal_Aluminyum");
            }

            SqlConnection con = new SqlConnection(General.ConnectionString);
            SqlCommand com = new SqlCommand("SELECT PageTitle, PageText FROM Pages WHERE Controller = @cont AND Action = @act AND SubID = @id; SELECT Name, Title FROM Images WHERE Related = @act AND RelatedKey = @id;SELECT * FROM Pages WHERE Controller = @cont AND Action = @act", con);
            com.Parameters.AddWithValue("cont", "Home");
            com.Parameters.AddWithValue("act", "Distributor");
            com.Parameters.AddWithValue("id", id);
            con.Open();
            SqlDataReader rdr = com.ExecuteReader();
            rdr.Read();
            ViewBag.PageTitle = rdr["PageTitle"].ToString();
            ViewBag.PageText = rdr["PageText"].ToString();
            rdr.NextResult();
            List<ImageInfo> images = new List<ImageInfo>();
            while (rdr.Read())
            {
                images.Add(new ImageInfo() { url = "~/images/" + rdr["Name"].ToString(), alt = rdr["Title"].ToString() });
            }
            ViewBag.RigthImages = images;

            rdr.NextResult();
            List<Link> menu = new List<Link>();
            while (rdr.Read())
            {
                menu.Add(new Link() { Caption = rdr["PageTitle"].ToString(), Url = "~/Home/Distributor/" + rdr["SubID"].ToString() });
            }
            ViewBag.MenuItems = menu;
            rdr.Close();
            con.Close();

          

            return View("PageView");
        }

        public ActionResult SayfaKategorileriGetir()
        {
            SqlConnection con = new SqlConnection(General.ConnectionString);
            SqlCommand com = new SqlCommand("SELECT * FROM Pages", con);
            con.Open();
            SqlDataReader rdr = com.ExecuteReader();
            while (rdr.Read())
            {
               
            }

            

            return View("PageView");
        }
    }
}