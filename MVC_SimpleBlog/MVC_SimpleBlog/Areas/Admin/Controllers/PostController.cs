using MVC_SimpleBlog.BLL;
using MVC_SimpleBlog.DTO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace MVC_SimpleBlog.Areas.Admin.Controllers
{
    public class PostController : Controller
    {
        PostRepository repo;

        // GET: Admin/Post
        public ActionResult Index()
        {
            repo = new PostRepository();

            List<PostDTO> postList = repo.GetAll();

            return View(postList);
        }

        // GET: Admin/Post/Details/5
        public ActionResult Details(int id)
        {
            return View();
        }

        // GET: Admin/Post/Create
        public ActionResult Create()
        {
            List<CategoryDTO> categoryList = new List<CategoryDTO>();
            categoryList.Add(new CategoryDTO { Id = 1, Name = "Spor" });
            categoryList.Add(new CategoryDTO { Id = 2, Name = "Siyaset" });
            categoryList.Add(new CategoryDTO { Id = 3, Name = "Magazin" });

            SelectList categorySelectList = new SelectList(categoryList, "Id", "Name");

            ViewBag.Categories = categorySelectList;

            return View();
        }

        // POST: Admin/Post/Create
        [HttpPost]
        public ActionResult Create(PostDTO post)
        {
            try
            {
                repo = new PostRepository();

                repo.Insert(post);

                // TODO: Add insert logic here

                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }

        // GET: Admin/Post/Edit/5
        public ActionResult Edit(int id)
        {
            return View();
        }

        // POST: Admin/Post/Edit/5
        [HttpPost]
        public ActionResult Edit(int id, FormCollection collection)
        {
            try
            {
                // TODO: Add update logic here

                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }

        // GET: Admin/Post/Delete/5
        public ActionResult Delete(int id)
        {
            return View();
        }

        // POST: Admin/Post/Delete/5
        [HttpPost]
        public ActionResult Delete(int id, FormCollection collection)
        {
            try
            {
                // TODO: Add delete logic here

                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }
    }
}
