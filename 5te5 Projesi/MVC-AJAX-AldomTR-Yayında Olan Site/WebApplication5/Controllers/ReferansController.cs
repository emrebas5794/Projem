using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WebApplication5.Models;

namespace WebApplication5.Controllers
{
    public class ReferansController : Controller
    {
        // GET: Referans
        public ActionResult Index()
        {
            return RedirectToAction("Kamu_Binalari");
        }

        public ActionResult Kamu_Binalari(string id)
        {
            return ProcessReferans("Kamu Binaları", id);
        }

        public ActionResult Konutlar(string id)
        {
            return ProcessReferans("Konutlar", id);
        }
        public ActionResult Ticari_Binalar(string id)
        {
            return ProcessReferans("Ticari Binalar", id);
        }
        public ActionResult Endustriyel_Binalar(string id)
        {
            return ProcessReferans("Endüstriyel Binalar", id);
        }

        private ActionResult ProcessReferans(string Name, string id)
        {
            ViewBag.ImgUrl = "~/images/main_image_1.jpg";
            ViewBag.Title = "Referanslar";
            ViewBag.PageTitle = Name;
            string parent = General.ConvertToUrl(Name);
            SqlConnection connection = new SqlConnection(General.ConnectionString);
            connection.Open();
            if (!String.IsNullOrEmpty(id))
            {
                SqlCommand cmd = new SqlCommand("SELECT * FROM Referans WHERE Parent = @Parent AND NameConverted = @Name", connection);
                string converted = General.ConvertToUrl(id);
                cmd.Parameters.AddWithValue("Name", converted);
                cmd.Parameters.AddWithValue("Parent", parent);
                SqlDataReader reader = cmd.ExecuteReader();
                reader.Read();
                ViewBag.PageTitle2 = reader["Name"].ToString();
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
                    ViewBag.PageImages = images;
                }
                reader2.Close();
            }
            else
            {
                ViewBag.Main = true;
                SqlCommand cmd4 = new SqlCommand("SELECT A.*, B.RTitle from (SELECT * FROM Images WHERE id IN (SELECT MIN(id) FROM Images WHERE Related = @Parent GROUP BY RelatedKey)) AS A LEFT JOIN (SELECT Name AS RTitle, NameConverted FROM Referans) AS B ON A.RelatedKey = B.NameConverted", connection);
                cmd4.Parameters.AddWithValue("Parent", parent);
                SqlDataReader reader4 = cmd4.ExecuteReader();
                List<ImageInfo> images = new List<ImageInfo>();
                while (reader4.Read())
                {
                    images.Add(new ImageInfo() { url = "~/images/" + reader4["Name"].ToString(), alt = reader4["RTitle"].ToString(), href = String.Format("~/Referans/{0}/{1}", reader4["Related"].ToString(), reader4["RelatedKey"].ToString()) });
                }
                ViewBag.Images = images;
                reader4.Close();
            }

            SqlCommand cmd3 = new SqlCommand("SELECT Name, NameConverted FROM Referans WHERE Parent = @Parent", connection);
            cmd3.Parameters.AddWithValue("Parent", parent);
            SqlDataReader reader3 = cmd3.ExecuteReader();
            List<Link> menu = new List<Link>();
            while (reader3.Read())
            {
                menu.Add(new Link() { Caption = reader3["Name"].ToString(), Url = "~/Referans/Kamu_Binalari/" + reader3["NameConverted"].ToString() });
            }
            ViewBag.MenuItems = menu;

            connection.Close();

            return View("ReferansView");
        }
    }
}

