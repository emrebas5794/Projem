using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using NZLOtomotiv.Models;

namespace NZLOtomotiv.Controllers
{
    [AuthenticationAttribute]
    public class NZLOtoController : Controller
    {
        // GET: NZLOto
        public ActionResult Giris()
        {
            if (Globals.ManageSession())
                return Redirect("~/NZLOto/Main");
            return View();
        }
        public ActionResult Main()
        {
            if (!Globals.ManageSession())
                return Redirect("~");
            return View();
        }

        public ActionResult Yazdir(string AracData)
        {
            if (!Globals.ManageSession())
                return Redirect("~");

            if (string.IsNullOrEmpty(AracData))
            {
                return Redirect("~/NZLOto/Main");
            }
           
            ViewBag.Data = AracData;
            return View();
           
        }

        public ActionResult SenetYazdir(string SenetData)
        {
            if (!Globals.ManageSession())
                return Redirect("~");

            if (string.IsNullOrEmpty(SenetData))
            {
                return Redirect("~/NZLOto/Main");
            }

            ViewBag.Data = SenetData;
            return View();

        }

        [HttpPost]
        public string Login(string username, string password)
        {
            return Models.Authentication.Login(username, password);
        }

        [HttpPost]
        public bool Register(string username, string password, string email)
        {
            return Models.Authentication.Register(username, password, email);
        }
    }
}