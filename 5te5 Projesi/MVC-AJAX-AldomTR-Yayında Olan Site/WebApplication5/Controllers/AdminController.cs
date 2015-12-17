using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Mvc;
using WebApplication5.Models;

namespace WebApplication5.Controllers
{
    public class AdminController : Controller
    {
        public ActionResult Giris()
        {
            if (!String.IsNullOrEmpty(Request["e"]))
            {
                int errorCode = Convert.ToInt32(Request["e"]);
                string error = "";
                switch (errorCode)
                {
                    default:
                        break;
                    case 1101:
                        error = "Kullanıcı Adı / Şifre Hatalı!";
                        break;
                    case 1102:
                        error = "Oturumunuz süre aşımına uğradı!";
                        break;
                }
                ViewBag.error = error;

            }
            return View();
        }

        public ActionResult Index()
        {
            if (!String.IsNullOrEmpty(Request["username"]) && !String.IsNullOrEmpty(Request["password"]))
            {
                //login
                string username = Request["username"];
                string password = Request["password"];

                SqlConnection con = new SqlConnection(General.ConnectionString);
                SqlCommand com = new SqlCommand("SELECT COUNT(*) FROM Users WHERE Username = @username AND Password = @Password", con);
                com.Parameters.AddWithValue("username", username);
                com.Parameters.AddWithValue("password", password);
                con.Open();
                SqlDataReader reader = com.ExecuteReader();
                reader.Read();
                int test = (int)reader[0];
                if (test == 1)
                {
                    SessionManager.Register(username);
                    return View();
                }
                else
                    return RedirectToAction("Giris", new { e = 1101 });
            }
            else
            {
                if (!SessionManager.isValid())
                {
                    return RedirectToAction("Giris", new { e = 1102 });
                }
                return View();
            }
        }

        public ActionResult Referanslar()
        {
            if (!SessionManager.isValid())
            {
                return RedirectToAction("Giris", new { e = 1102 });
            }

            return View();
        }
        public ActionResult Urunler()
        {
            if (!SessionManager.isValid())
            {
                return RedirectToAction("Giris", new { e = 1102 });
            }

            return View();
        }

        public ActionResult Diger()
        {
            if (!SessionManager.isValid())
            {
                return RedirectToAction("Giris", new { e = 1102 });
            }

            return View();
        }

        [HttpPost]
        public string ReferansEkle(string Parent, string Name, string Text)
        {
            if (!SessionManager.isValid())
            {
                return "ERROR: 1102";
            }

            SqlConnection con = new SqlConnection(General.ConnectionString);
            SqlCommand com = new SqlCommand("INSERT INTO Referans(Parent, Name, NameConverted, Text) VALUES (@Parent, @Name, @NameC, @Text)", con);
            com.Parameters.AddWithValue("Parent", General.ConvertToUrl(Parent));
            com.Parameters.AddWithValue("Name", Name);
            com.Parameters.AddWithValue("NameC", General.ConvertToUrl(Name));
            com.Parameters.AddWithValue("Text", Text);
            con.Open();
            com.ExecuteNonQuery();
            con.Close();
            return "OK";
        }
        [HttpPost]
        public string UrunEkle(string Parent, string Name, string Text)
        {
            if (!SessionManager.isValid())
            {
                return "ERROR: 1102";
            }

            SqlConnection con = new SqlConnection(General.ConnectionString);
            SqlCommand com = new SqlCommand("INSERT INTO Urunler(Parent, Name, NameConverted, Text) VALUES (@Parent, @Name, @NameC, @Text)", con);
            com.Parameters.AddWithValue("Parent", General.ConvertToUrl(Parent));
            com.Parameters.AddWithValue("Name", Name);
            com.Parameters.AddWithValue("NameC", General.ConvertToUrl(Name));
            com.Parameters.AddWithValue("Text", Text);
            con.Open();
            com.ExecuteNonQuery();
            con.Close();
            return "OK";
        }

        [HttpPost]
        public string KategoriYaziEkle(string Action, string PageTitle, string PageText,string SubID)
        {
            if (!SessionManager.isValid())
            {
                return "ERROR: 1102";
            }


            SqlConnection con = new SqlConnection(General.ConnectionString);
            SqlCommand com = new SqlCommand();
            com.Connection = con;

            com.CommandText = "SELECT count(*) FROM KategoriYazi WHERE Action = @Action";
            com.Parameters.AddWithValue("Action", General.ConvertToUrl(Action));
            con.Open();
            SqlDataReader reader = com.ExecuteReader();
            reader.Read();
            int kontrol = (int)reader[0];
            reader.Close();
            if (kontrol==1)
            {
                
                com.CommandText = "update KategoriYazi set  SubID=@SubIDg,PageTitle=@PageTitleg,PageText=@PageTextg where Action=@Actiong ";
                com.Parameters.AddWithValue("Actiong", General.ConvertToUrl(Action));
                com.Parameters.AddWithValue("SubIDg", SubID);
                com.Parameters.AddWithValue("PageTitleg", PageTitle);
                com.Parameters.AddWithValue("PageTextg", PageText);
                com.ExecuteNonQuery();
            }
            else
            {
                com.CommandText = "INSERT INTO KategoriYazi(Controller,Action,SubID, PageTitle, PageText) VALUES (@Controller,@Actionk,@SubIDk, @PageTitlek, @PageTextk)";
                com.Parameters.AddWithValue("Controller", "Urunler");
                com.Parameters.AddWithValue("Actionk", General.ConvertToUrl(Action));
                com.Parameters.AddWithValue("SubIDk", SubID);
                com.Parameters.AddWithValue("PageTitlek", PageTitle);
                com.Parameters.AddWithValue("PageTextk", PageText);
                com.ExecuteNonQuery();
            }
          
            con.Close();

            return "OK";
        }
        [HttpPost]
        public string KategoriBilgiAl()
        {
            if (!SessionManager.isValid())
            {
                return "ERROR: 1102";
            }

            string response = "";
            SqlConnection con = new SqlConnection(General.ConnectionString);
            SqlCommand com = new SqlCommand();
            com.Connection = con;

          
                JArray ja = new JArray();
                com.CommandText = "SELECT PageTitle,PageText,SubID FROM KategoriYazi WHERE Action = @Action";
                com.Parameters.AddWithValue("Action", General.ConvertToUrl(Request["Action"]));
                con.Open();
                SqlDataReader reader = com.ExecuteReader();
                while (reader.Read())
                {
                    JObject jo = new JObject();
                    for (int i = 0; i < reader.VisibleFieldCount; i++)
                    {
                        jo.Add(reader.GetName(i), reader[i].ToString());
                    }
                    ja.Add(jo);
                }
                reader.Close();
                con.Close();
                response = JsonConvert.SerializeObject(ja);
                    

            return response;
        }
        [HttpPost]
        public string DigerEkle(string Parent, string Name, string Text)
        {
            if (!SessionManager.isValid())
            {
                return "ERROR: 1102";
            }

            SqlConnection con = new SqlConnection(General.ConnectionString);
            SqlCommand com = new SqlCommand("INSERT INTO Pages(Controller, Action, SubID, PageTitle,PageText) VALUES (@Home,@Parent, @NameC, @Name, @Text)", con);
            com.Parameters.AddWithValue("Home", "Home");
            com.Parameters.AddWithValue("Parent", General.ConvertToUrl(Parent));
            com.Parameters.AddWithValue("NameC", General.ConvertToUrl(Name));
            com.Parameters.AddWithValue("Name", Name);
            com.Parameters.AddWithValue("Text", Text);
            con.Open();
            com.ExecuteNonQuery();
            con.Close();
            return "OK";
        }

        [HttpPost]
        public string ReferansBilgiAl()
        {
            if (!SessionManager.isValid())
            {
                return "ERROR: 1102";
            }

            string response = "";
            SqlConnection con = new SqlConnection(General.ConnectionString);
            SqlCommand com = new SqlCommand();
            com.Connection = con;

            if (String.IsNullOrEmpty(Request["id"]))
            {
                JArray ja = new JArray();
                com.CommandText = "SELECT id, Name FROM Referans WHERE Parent = @Parent";
                com.Parameters.AddWithValue("Parent", General.ConvertToUrl(Request["Parent"]));
                con.Open();
                SqlDataReader reader = com.ExecuteReader();
                while (reader.Read())
                {
                    JObject jo = new JObject();
                    for (int i = 0; i < reader.VisibleFieldCount; i++)
                    {
                        jo.Add(reader.GetName(i), reader[i].ToString());
                    }
                    ja.Add(jo);
                }
                reader.Close();
                con.Close();
                response = JsonConvert.SerializeObject(ja);
            }
            else
            {
                JObject jo = new JObject();
                com.CommandText = "SELECT * FROM Referans WHERE id = @id";
                com.Parameters.AddWithValue("id", Request["id"]);
                con.Open();
                SqlDataReader reader = com.ExecuteReader();
                reader.Read();
                for (int i = 0; i < reader.VisibleFieldCount; i++)
                {
                    jo.Add(reader.GetName(i), reader[i].ToString());
                }
                reader.Close();

                SqlCommand com2 = new SqlCommand("SELECT Name FROM Images WHERE RelatedKey = @Key", con);
                com2.Parameters.AddWithValue("Key", jo["NameConverted"].ToString());
                SqlDataReader reader2 = com2.ExecuteReader();
                JArray ja = new JArray();
                while (reader2.Read())
                {
                    ja.Add(reader2["Name"].ToString());
                }
                reader2.Close();
                jo.Add("Images", ja);
                con.Close();
                response = JsonConvert.SerializeObject(jo);
            }

            return response;
        }

        [HttpPost]
        public string UrunBilgiAl()
        {
            if (!SessionManager.isValid())
            {
                return "ERROR: 1102";
            }

            string response = "";
            SqlConnection con = new SqlConnection(General.ConnectionString);
            SqlCommand com = new SqlCommand();
            com.Connection = con;

            if (String.IsNullOrEmpty(Request["id"]))
            {
                JArray ja = new JArray();
                com.CommandText = "SELECT id, Name FROM Urunler WHERE Parent = @Parent";
                com.Parameters.AddWithValue("Parent", General.ConvertToUrl(Request["Parent"]));
                con.Open();
                SqlDataReader reader = com.ExecuteReader();
                while (reader.Read())
                {
                    JObject jo = new JObject();
                    for (int i = 0; i < reader.VisibleFieldCount; i++)
                    {
                        jo.Add(reader.GetName(i), reader[i].ToString());
                    }
                    ja.Add(jo);
                }
                reader.Close();
                con.Close();
                response = JsonConvert.SerializeObject(ja);
            }
            else
            {
                JObject jo = new JObject();
                com.CommandText = "SELECT * FROM Urunler WHERE id = @id";
                com.Parameters.AddWithValue("id", Request["id"]);
                con.Open();
                SqlDataReader reader = com.ExecuteReader();
                reader.Read();
                for (int i = 0; i < reader.VisibleFieldCount; i++)
                {
                    jo.Add(reader.GetName(i), reader[i].ToString());
                }
                reader.Close();

                SqlCommand com2 = new SqlCommand("SELECT Name FROM Images WHERE RelatedKey = @Key", con);
                com2.Parameters.AddWithValue("Key", jo["NameConverted"].ToString());
                SqlDataReader reader2 = com2.ExecuteReader();
                JArray ja = new JArray();
                while (reader2.Read())
                {
                    ja.Add(reader2["Name"].ToString());
                }
                reader2.Close();
                jo.Add("Images", ja);
                con.Close();
                response = JsonConvert.SerializeObject(jo);
            }

            return response;
        }

        [HttpPost]
        public string DigerBilgiAl()
        {
            if (!SessionManager.isValid())
            {
                return "ERROR: 1102";
            }

            string response = "";
            SqlConnection con = new SqlConnection(General.ConnectionString);
            SqlCommand com = new SqlCommand();
            com.Connection = con;

            if (String.IsNullOrEmpty(Request["id"]))
            {
                JArray ja = new JArray();
                com.CommandText = "SELECT id, PageTitle FROM Pages WHERE Action = @Parent";
                com.Parameters.AddWithValue("Parent", General.ConvertToUrl(Request["Parent"]));
                con.Open();
                SqlDataReader reader = com.ExecuteReader();
                while (reader.Read())
                {
                    JObject jo = new JObject();
                    for (int i = 0; i < reader.VisibleFieldCount; i++)
                    {
                        jo.Add(reader.GetName(i), reader[i].ToString());
                    }
                    ja.Add(jo);
                }
                reader.Close();
                con.Close();
                response = JsonConvert.SerializeObject(ja);
            }
            else
            {
                JObject jo = new JObject();
                com.CommandText = "SELECT * FROM Pages WHERE id = @id";
                com.Parameters.AddWithValue("id", Request["id"]);
                con.Open();
                SqlDataReader reader = com.ExecuteReader();
                reader.Read();
                for (int i = 0; i < reader.VisibleFieldCount; i++)
                {
                    jo.Add(reader.GetName(i), reader[i].ToString());
                }
                reader.Close();

                SqlCommand com2 = new SqlCommand("SELECT Name FROM Images WHERE RelatedKey = @Key", con);
                com2.Parameters.AddWithValue("Key", jo["SubID"].ToString());
                SqlDataReader reader2 = com2.ExecuteReader();
                JArray ja = new JArray();
                while (reader2.Read())
                {
                    ja.Add(reader2["Name"].ToString());
                }
                reader2.Close();
                jo.Add("Images", ja);
                con.Close();
                response = JsonConvert.SerializeObject(jo);
            }

            return response;
        }

        [HttpPost]
        public string ReferansDuzenle(string Parent, string id, string Name, string Text, string SilResim)
        {
            JArray silresimler = JsonConvert.DeserializeObject<JArray>(SilResim);
            Parent = General.ConvertToUrl(Parent);
            foreach (JToken imageName in silresimler)
            {
                System.IO.File.Delete(Server.MapPath("~/images/" + imageName.ToString()));
            }

            Regex rename = new Regex(@"(.*)\.([^\.]*)");
            List<string> eklenenresimler = new List<string>();
            for (int j = 0; j < Request.Files.Count; j++)
            {
                HttpPostedFileBase image = Request.Files[j];
                string filefullname = image.FileName;
                Match match = rename.Match(filefullname);
                string filename = match.Groups[1].ToString();
                string ext = match.Groups[2].ToString();
                for (int i = 1; System.IO.File.Exists(Server.MapPath("~/images/" + filefullname)); i++)
                {
                    filefullname = filename + "_" + i.ToString() + "." + ext;
                }
                image.SaveAs(Server.MapPath("~/images/" + filefullname));
                eklenenresimler.Add(filefullname);
            }
            SqlConnection con = new SqlConnection(General.ConnectionString);
            SqlCommand com = new SqlCommand();
            com.Connection = con;
            com.CommandText = "UPDATE Referans SET Name = @Name, NameConverted = @NameConverted, Text = @Text WHERE id = @id;";
            com.Parameters.AddWithValue("id", id);
            com.Parameters.AddWithValue("Name", Name);
            com.Parameters.AddWithValue("NameConverted", General.ConvertToUrl(Name));
            com.Parameters.AddWithValue("Text", Text);

            if (silresimler.Count > 0)
            {
                com.CommandText += "DELETE FROM Images WHERE";
                for (int i = 0; i < silresimler.Count; i++)
                {
                    if (i > 0)
                        com.CommandText += " OR ";
                    com.CommandText += " Name = @Name" + i.ToString();
                    com.Parameters.AddWithValue("Name" + i.ToString(), silresimler[i].ToString());
                }
                com.CommandText += ";";
            }

            if (eklenenresimler.Count > 0)
            {
                com.CommandText += "INSERT INTO Images (Related, RelatedKey, Name) VALUES";
                for (int i = 0; i < eklenenresimler.Count; i++)
                {
                    if (i > 0)
                        com.CommandText += ",";
                    com.CommandText += "(@Parent, @NameConverted, @ImageName" + i.ToString() + ")";
                    com.Parameters.AddWithValue("ImageName" + i.ToString(), eklenenresimler[i].ToString());
                }
                com.Parameters.AddWithValue("Parent", Parent);
            }

            con.Open();
            com.ExecuteNonQuery();
            con.Close();
            return "OK";
        }
        [HttpPost]
        public string UrunDuzenle(string Parent, string id, string Name, string Text, string SilResim)
        {
            JArray silresimler = JsonConvert.DeserializeObject<JArray>(SilResim);
            Parent = General.ConvertToUrl(Parent);
            foreach (JToken imageName in silresimler)
            {
                System.IO.File.Delete(Server.MapPath("~/images/" + imageName.ToString()));
            }

            Regex rename = new Regex(@"(.*)\.([^\.]*)");
            List<string> eklenenresimler = new List<string>();
            for (int j = 0; j < Request.Files.Count; j++)
            {
                HttpPostedFileBase image = Request.Files[j];
                string filefullname = image.FileName;
                Match match = rename.Match(filefullname);
                string filename = match.Groups[1].ToString();
                string ext = match.Groups[2].ToString();
                for (int i = 1; System.IO.File.Exists(Server.MapPath("~/images/" + filefullname)); i++)
                {
                    filefullname = filename + "_" + i.ToString() + "." + ext;
                }
                image.SaveAs(Server.MapPath("~/images/" + filefullname));
                eklenenresimler.Add(filefullname);
            }
            SqlConnection con = new SqlConnection(General.ConnectionString);
            SqlCommand com = new SqlCommand();
            com.Connection = con;
            com.CommandText = "UPDATE Urunler SET Name = @Name, NameConverted = @NameConverted, Text = @Text WHERE id = @id;";
            com.Parameters.AddWithValue("id", id);
            com.Parameters.AddWithValue("Name", Name);
            com.Parameters.AddWithValue("NameConverted", General.ConvertToUrl(Name));
            com.Parameters.AddWithValue("Text", Text);

            if (silresimler.Count > 0)
            {
                com.CommandText += "DELETE FROM Images WHERE";
                for (int i = 0; i < silresimler.Count; i++)
                {
                    if (i > 0)
                        com.CommandText += " OR ";
                    com.CommandText += " Name = @Name" + i.ToString();
                    com.Parameters.AddWithValue("Name" + i.ToString(), silresimler[i].ToString());
                }
                com.CommandText += ";";
            }

            if (eklenenresimler.Count > 0)
            {
                com.CommandText += "INSERT INTO Images (Related, RelatedKey, Name) VALUES";
                for (int i = 0; i < eklenenresimler.Count; i++)
                {
                    if (i > 0)
                        com.CommandText += ",";
                    com.CommandText += "(@Parent, @NameConverted, @ImageName" + i.ToString() + ")";
                    com.Parameters.AddWithValue("ImageName" + i.ToString(), eklenenresimler[i].ToString());
                }
                com.Parameters.AddWithValue("Parent", Parent);
            }

            con.Open();
            com.ExecuteNonQuery();
            con.Close();
            return "OK";
        }

        [HttpPost]
        public string DigerDuzenle(string Parent, string id, string Name, string Text, string SilResim)
        {
            JArray silresimler = JsonConvert.DeserializeObject<JArray>(SilResim);
            Parent = General.ConvertToUrl(Parent);
            foreach (JToken imageName in silresimler)
            {
                System.IO.File.Delete(Server.MapPath("~/images/" + imageName.ToString()));
            }

            Regex rename = new Regex(@"(.*)\.([^\.]*)");
            List<string> eklenenresimler = new List<string>();
            for (int j = 0; j < Request.Files.Count; j++)
            {
                HttpPostedFileBase image = Request.Files[j];
                string filefullname = image.FileName;
                Match match = rename.Match(filefullname);
                string filename = match.Groups[1].ToString();
                string ext = match.Groups[2].ToString();
                for (int i = 1; System.IO.File.Exists(Server.MapPath("~/images/" + filefullname)); i++)
                {
                    filefullname = filename + "_" + i.ToString() + "." + ext;
                }
                image.SaveAs(Server.MapPath("~/images/" + filefullname));
                eklenenresimler.Add(filefullname);
            }
            SqlConnection con = new SqlConnection(General.ConnectionString);
            SqlCommand com = new SqlCommand();
            com.Connection = con;
            com.CommandText = "UPDATE Pages SET PageTitle = @Name, SubID = @NameConverted, PageText = @Text WHERE id = @id;";
            com.Parameters.AddWithValue("id", id);
            com.Parameters.AddWithValue("NameConverted", General.ConvertToUrl(Name));
            com.Parameters.AddWithValue("Name", Name);          
            com.Parameters.AddWithValue("Text", Text);

            if (silresimler.Count > 0)
            {
                com.CommandText += "DELETE FROM Images WHERE";
                for (int i = 0; i < silresimler.Count; i++)
                {
                    if (i > 0)
                        com.CommandText += " OR ";
                    com.CommandText += " Name = @Name" + i.ToString();
                    com.Parameters.AddWithValue("Name" + i.ToString(), silresimler[i].ToString());
                }
                com.CommandText += ";";
            }

            if (eklenenresimler.Count > 0)
            {
                com.CommandText += "INSERT INTO Images (Related, RelatedKey, Name) VALUES";
                for (int i = 0; i < eklenenresimler.Count; i++)
                {
                    if (i > 0)
                        com.CommandText += ",";
                    com.CommandText += "(@Parent, @NameConverted, @ImageName" + i.ToString() + ")";
                    com.Parameters.AddWithValue("ImageName" + i.ToString(), eklenenresimler[i].ToString());
                }
                com.Parameters.AddWithValue("Parent", Parent);
            }

            con.Open();
            com.ExecuteNonQuery();
            con.Close();
            return "OK";
        }
        public string ReferansSil(string id, string SilResim)
        {
            JArray silresimler = JsonConvert.DeserializeObject<JArray>(SilResim);
            foreach (JToken imageName in silresimler)
            {
                System.IO.File.Delete(Server.MapPath("~/images/" + imageName.ToString()));
            }

            SqlConnection con = new SqlConnection(General.ConnectionString);
            SqlCommand com = new SqlCommand();
            com.Connection = con;
            com.CommandText = "DELETE FROM Referans WHERE id = @id;";
            com.Parameters.AddWithValue("id", id);

            if (silresimler.Count > 0)
            {
                com.CommandText += "DELETE FROM Images WHERE";
                for (int i = 0; i < silresimler.Count; i++)
                {
                    if (i > 0)
                        com.CommandText += " OR ";
                    com.CommandText += " Name = @Name" + i.ToString();
                    com.Parameters.AddWithValue("Name" + i.ToString(), silresimler[i].ToString());
                }
                com.CommandText += ";";
            }

            con.Open();
            com.ExecuteNonQuery();
            con.Close();
            return "OK";
        }
        public string UrunSil(string id, string SilResim)
        {
            JArray silresimler = JsonConvert.DeserializeObject<JArray>(SilResim);
            foreach (JToken imageName in silresimler)
            {
                System.IO.File.Delete(Server.MapPath("~/images/" + imageName.ToString()));
            }

            SqlConnection con = new SqlConnection(General.ConnectionString);
            SqlCommand com = new SqlCommand();
            com.Connection = con;
            com.CommandText = "DELETE FROM Urunler WHERE id = @id;";
            com.Parameters.AddWithValue("id", id);

            if (silresimler.Count > 0)
            {
                com.CommandText += "DELETE FROM Images WHERE";
                for (int i = 0; i < silresimler.Count; i++)
                {
                    if (i > 0)
                        com.CommandText += " OR ";
                    com.CommandText += " Name = @Name" + i.ToString();
                    com.Parameters.AddWithValue("Name" + i.ToString(), silresimler[i].ToString());
                }
                com.CommandText += ";";
            }

            con.Open();
            com.ExecuteNonQuery();
            con.Close();
            return "OK";
        }

        public string DigerSil(string id, string SilResim)
        {
            JArray silresimler = JsonConvert.DeserializeObject<JArray>(SilResim);
            foreach (JToken imageName in silresimler)
            {
                System.IO.File.Delete(Server.MapPath("~/images/" + imageName.ToString()));
            }

            SqlConnection con = new SqlConnection(General.ConnectionString);
            SqlCommand com = new SqlCommand();
            com.Connection = con;
            com.CommandText = "DELETE FROM Pages WHERE id = @id;";
            com.Parameters.AddWithValue("id", id);

            if (silresimler.Count > 0)
            {
                com.CommandText += "DELETE FROM Images WHERE";
                for (int i = 0; i < silresimler.Count; i++)
                {
                    if (i > 0)
                        com.CommandText += " OR ";
                    com.CommandText += " Name = @Name" + i.ToString();
                    com.Parameters.AddWithValue("Name" + i.ToString(), silresimler[i].ToString());
                }
                com.CommandText += ";";
            }

            con.Open();
            com.ExecuteNonQuery();
            con.Close();
            return "OK";
        }
    }
}