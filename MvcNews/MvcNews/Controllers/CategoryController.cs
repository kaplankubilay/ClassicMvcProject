using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using MvcNews.Models;

namespace MvcNews.Controllers
{
    public class CategoryController : Controller
    {
        private NewsDbEntities _db = new NewsDbEntities();

        // GET: Category
        public ActionResult Index()
        {
            List<SelectCategoryObject> listCategory = _db.sp_SelectCategories().ToList();
            return View(listCategory);
        }

        // GET: Category/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: Category/Create
        [HttpPost]
        public ActionResult Create(FormCollection collection)
        {
            try
            {
                _db.sp_InsertCategories(collection["CategoryName"]);
                return RedirectToAction("Index");
            }
            catch(Exception)
            {
                Console.WriteLine("Category-Create-Post is take error.");
                return View();
            }
        }

        // GET: Category/Delete
        public ActionResult Delete(int cid)
        {
            ViewBag.error = "";
            SelectCategoryObject selectCategoryObject = _db.sp_SelectCategoryById(cid).First();
            if (selectCategoryObject==null)
            {
                return HttpNotFound();
            }
            return View(selectCategoryObject);
        }

        // POST: Category/Delete
        [HttpPost]
        public ActionResult Delete(int cid, FormCollection collection)
        {
            try
            {
               var listNews = _db.sp_SelectNews().Where(p => p.CId == cid).FirstOrDefault();
                if (listNews!=null)
                {
                    SelectCategoryObject selectCategoryObject = _db.sp_SelectCategoryById(cid).First();

                    ViewBag.error = "Kategoriye ait içerik mevcut silinemez!.";
                    return View(selectCategoryObject);

                }
                _db.sp_DeleteCategories(cid);
                return RedirectToAction("Index");
            }
            catch(Exception)
            {
                ViewBag.error = "";
                Console.WriteLine("Category-Delete-Post is take error.");
                return View();
            }
        }
    }
}
