using CafeBlog.BLL;
using CafeBlog.DTO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace CafeBlog.Areas.Admin.Controllers
{
    public class CategoryController : Controller
    {
        CategoryRepository repo;

        // GET: Admin/Category
        public ActionResult Index()
        {
            repo = new CategoryRepository();

            List<CategoryDTO> categoryList = repo.GetAll();

            return View(categoryList);
        }

        // GET: Admin/Category/Details/5
        public ActionResult Details(int id)
        {
            return View();
        }

        // GET: Admin/Category/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: Admin/Category/Create
        [HttpPost]
        public ActionResult Create(CategoryDTO category)
        {
            try
            {
                repo = new CategoryRepository();

                repo.Insert(category);

                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }

        // GET: Admin/Category/Edit/5
        public ActionResult Edit(int id)
        {
            repo = new CategoryRepository();

            CategoryDTO category = repo.GetById(id);

            return View(category);
        }

        // POST: Admin/Category/Edit/5
        [HttpPost]
        public ActionResult Edit(CategoryDTO category)
        {
            try
            {
                repo = new CategoryRepository();

                repo.Update(category);

                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }

        // GET: Admin/Category/Delete/5
        public ActionResult Delete(int id)
        {
            repo = new CategoryRepository();

            CategoryDTO category = repo.GetById(id);

            return View(category);
        }


        // POST: Admin/Category/Delete/5
        [HttpPost]
        [ActionName("Delete")]
        public ActionResult DeleteConfirmed(int id)
        {
            try
            {
                repo = new CategoryRepository();

                repo.Delete(id);

                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }

        //// POST: Admin/Category/Delete/5
        //[HttpPost]
        //public ActionResult Delete(CategoryDTO category)
        //{
        //    try
        //    {
        //        repo = new CategoryRepository();

        //        repo.Delete(category.Id);

        //        return RedirectToAction("Index");
        //    }
        //    catch
        //    {
        //        return View();
        //    }
        //}
    }
}
