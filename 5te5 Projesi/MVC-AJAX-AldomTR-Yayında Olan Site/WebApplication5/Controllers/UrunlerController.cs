using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WebApplication5.Models;

namespace WebApplication5.Controllers
{
    public class UrunlerController : Controller
    {
        // GET: Urunler
        List<Link> sub1 = new List<Link>();
        List<Link> sub2 = new List<Link>();
        List<Link> sub3 = new List<Link>();
        List<Link> sub4 = new List<Link>();

        public ActionResult Index()
        {
            return RedirectToAction("Cepheler");
        }


       
       

          
        


        public ActionResult Cepheler(string id)
        {
            
            return ProcessUrun("Cepheler", id);
        }

        public ActionResult Kapi_ve_Pencere_Sistemleri(string id)
        {
          
            return ProcessUrun("Kapı ve Pencere Sistemleri", id);
        }

        public ActionResult Surme_Sistemleri(string id)
        {
          
            return ProcessUrun("Sürme Sistemleri", id);
        }

        public ActionResult Katlanir_Kapi_Sistemleri(string id)
        {
           
                return ProcessUrun("Katlanır Kapı Sistemleri", id);
           
           
        }
     
        private ActionResult ProcessUrun(string Name, string id)
        {

            ViewBag.ImgUrl = "~/images/main_image_1.jpg";
            ViewBag.Title = "Ürünler";
            ViewBag.PageTitle = Name;
            string parent = General.ConvertToUrl(Name);
            SqlConnection connection = new SqlConnection(General.ConnectionString);
            connection.Open();
            if (!String.IsNullOrEmpty(id))
            {
                SqlCommand cmd = new SqlCommand("SELECT * FROM Urunler WHERE Parent = @Parent AND NameConverted = @Name", connection);
                string converted = General.ConvertToUrl(id);
                cmd.Parameters.AddWithValue("Name", converted);
                cmd.Parameters.AddWithValue("Parent", parent);
                SqlDataReader reader = cmd.ExecuteReader();
                reader.Read();
                ViewBag.PageTitle = reader["Name"].ToString();
                ViewBag.PageText = reader["Text"].ToString();
                reader.Close();

                SqlCommand cmd2 = new SqlCommand("SELECT * FROM Images WHERE Related = @Parent AND RelatedKey = @Name", connection);
                cmd2.Parameters.AddWithValue("Name", converted);
                cmd2.Parameters.AddWithValue("Parent", parent);
                SqlDataReader reader2 = cmd2.ExecuteReader();
                if (reader2.HasRows)
                {
                    List<ImageInfo> images = new List<ImageInfo>();
                    while (reader2.Read())
                    {
                        images.Add(new ImageInfo() { url = "~/images/" + reader2["Name"], alt = reader2["Title"].ToString() });
                    }
                    ViewBag.RigthImages = images;
                }
                reader2.Close();
            }
            else
            {
                SqlConnection con = new SqlConnection(General.ConnectionString);
                SqlCommand com = new SqlCommand();
                com.Connection = con;

                com.CommandText = "SELECT * FROM KategoriYazi WHERE Action =@Action";
                com.Parameters.AddWithValue("Action", parent);
                con.Open();
                SqlDataReader reader = com.ExecuteReader();
                reader.Read();
                if (reader["SubID"].ToString() == "")
                {
                    ViewBag.Main = true;
                    ViewBag.PageTitle = reader["PageTitle"].ToString();
                    ViewBag.PageText = reader["PageText"].ToString();
                }
                else
                {
                    return Redirect(reader["SubID"].ToString());
                }


                reader.Close();
                con.Close();
            }
          
         

            SqlCommand cmd3 = new SqlCommand("SELECT Name, NameConverted,Parent FROM Urunler", connection);
            cmd3.Parameters.AddWithValue("Parent", parent);
            SqlDataReader reader3 = cmd3.ExecuteReader();
            List<Link> menu = new List<Link>();

            while (reader3.Read())
            {
                if (reader3["Parent"].ToString() == "Cepheler")
                {
                   
                    sub1.Add(new Link() { Caption = reader3["Name"].ToString(), Url = "~/Urunler/Cepheler/" + reader3["NameConverted"].ToString() });

                }
                if (reader3["Parent"].ToString() == "Kapi_ve_Pencere_Sistemleri")
                {
                    
                    sub2.Add(new Link() { Caption = reader3["Name"].ToString(), Url = "~/Urunler/Kapi_ve_Pencere_Sistemleri/" + reader3["NameConverted"].ToString() });

                }
                if (reader3["Parent"].ToString() == "Surme_Sistemleri")
                {
                   
                    sub3.Add(new Link() { Caption = reader3["Name"].ToString(), Url = "~/Urunler/Surme_Sistemleri/" + reader3["NameConverted"].ToString() });

                }
                if (reader3["Parent"].ToString() == "Katlanir_Kapi_Sistemleri")
                {
                   
                    sub4.Add(new Link() { Caption = reader3["Name"].ToString(), Url = "~/Urunler/Katlanir_Kapi_Sistemleri/" + reader3["NameConverted"].ToString() });

                }
            }
            menu.Add(new Link()
            {
                Caption = "Cepheler",
                Url = "~/Urunler/Cepheler",
                Submenu = sub1
            });
            menu.Add(new Link()
            {
                Caption = "Kapı ve_Pencere Sistemleri",
                Url = "~/Urunler/Kapi_ve_Pencere_Sistemleri",
                Submenu = sub2
            });
            menu.Add(new Link()
            {
                Caption = "Sürme Sistemleri",
                Url = "~/Urunler/Surme_Sistemleri",
                Submenu = sub3
            });
            menu.Add(new Link()
            {
                Caption = "Katlanır Kapı Sistemleri",
                Url = "~/Urunler/Katlanir_Kapi_Sistemleri",
                Submenu = sub4
            });


            ViewBag.MenuItems = menu;

            connection.Close();

            return View("UrunView");

        }

    }

}