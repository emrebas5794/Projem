using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace MVC_SimpleBlog.Areas.Admin.Controllers
{
    public class HomeController : Controller
    {
        // GET: Admin/Home
        public ActionResult Index()
        {
             //Pseudocode
             //EĞER Login olmuş kullanıcı varsa?
             //Index view'ı döndür
             //DEĞİLSE
             //Login ekranını döndür

            if (Session["User"] == null)
            {
                return RedirectToAction("Login", "User");
            }



            #region Veri Saklayan obje ve koleksiyonlar
            //// Application State
            //System.Web.HttpContext.Current.Application["Tsubasa"] = "Ozora";

            //HttpContext.Application["Tsubasa"] = "Ozora";

            //// Session State
            //Session["Username"] = "Tsubasa";

            //if (Session["Username"] != null)
            //{
            //    string userName = (string)Session["Username"];

            //}

            //// ViewData - ViewState
            //ViewData["Tsubasa"] = "Ozora";
            //string tsubasa = (string)ViewData["Tsubasa"];

            //ViewBag.Tsubasa = "Ozora";

            //string tsubasa2 = (string)ViewBag.Tsubasa;


            //TempData["Tsubasa"] = "Ozora";

            //List<string> nameList = new List<string>();
            //nameList.Add("Tsubasa");

            //ArrayList otherNameList = new ArrayList();
            //otherNameList.Add("Tsubasa");
            //otherNameList.Add(5);

            //otherNameList.RemoveAt(2); 
            #endregion

            return View();
        }
    }
}