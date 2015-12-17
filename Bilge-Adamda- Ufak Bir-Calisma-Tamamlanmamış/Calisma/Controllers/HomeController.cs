using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Calisma_DTO;
using CalismaBLL;

namespace Calisma.Controllers
{
    public class HomeController : Controller
    {
        UserRepository repo;
        
        // GET: Home
        public ActionResult Index()
        {
            return View();
        }
        public ActionResult Create()
        {
            return View();
        }
         [HttpPost]
          public ActionResult Create(UserDTO post)
        {
            try
            {
                repo = new UserRepository();
                repo.Insert(post);

                // TODO: Add insert logic here

                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }
         [HttpPost]
         public ActionResult Index(Models.Credential credential)
         {
             repo = new UserRepository();
             UserDTO user = repo.Login(credential.Email);

             if (user == null)
             {
                 ViewBag.Message = "Kullanıcı adı veya şifreniz hatalı";
                 return View();
             }

             Session["User"] = user;

             return RedirectToAction("Index", "Category");
         }
    }
}