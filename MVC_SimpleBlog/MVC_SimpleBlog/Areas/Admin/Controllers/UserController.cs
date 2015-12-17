using MVC_SimpleBlog.BLL;
using MVC_SimpleBlog.DTO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace MVC_SimpleBlog.Areas.Admin.Controllers
{
    public class UserController : Controller
    {
        UserRepository repo;

        // GET: Admin/User
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult Login()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Login(Models.Credential credential)
        {
            repo = new UserRepository();
            UserDTO user = repo.Login(credential.Username, credential.Password);

            if (user == null)
            {
                ViewBag.Message = "Kullanıcı adı veya şifreniz hatalı";
                return View();
            }

            Session["User"] = user;

            return RedirectToAction("Index", "Home");
        }
    }
}