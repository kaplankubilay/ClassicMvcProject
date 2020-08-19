using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using MvcNews.Models;

namespace MvcNews.Controllers
{
    public class NewsController : Controller
    {
        //Create DB instance
        private NewsDbEntities _db = new NewsDbEntities();

        // GET: News
        public ActionResult Index()
        {
            List <SelectNewsObject> listNews= _db.sp_SelectNews().ToList();
            return View(listNews);
        }


        //POST:/News/Index
        [HttpPost]
        public ActionResult Index(int categoryName)
        {
            List<SelectNewsObject> listNews = new List<SelectNewsObject>();
            try
            {
                listNews = _db.sp_SelectNews().Where(p => p.CId == categoryName).ToList();
                if (listNews == null)
                {
                    return View(listNews);
                }
            }
            catch (Exception)
            {                
                Console.WriteLine("News-SearcText-Post is take error.");
            }
            return View(listNews);
        }

        // GET: News/Create
        public ActionResult Create()
        {
            ViewBag.Categories = _db.sp_SelectCategories().ToList();
            return View();
        }

        //POST: News/Create
        [HttpPost]
        public ActionResult Create(FormCollection collection)
        {
            try
            {
                if (collection["cId"]==null)
                {
                    return RedirectToAction("Index");
                }
                var cId = Convert.ToInt32(collection["cId"]);   
                _db.sp_InsertNews(cId, collection["NewsTitle"], collection["NewsContent"]);
                return RedirectToAction("Index");
            }
            catch(Exception)
            {
                Console.WriteLine("News-Create-Post is take error.");
                ViewBag.Categories = _db.sp_SelectCategories().ToList();
                return View();
            }
        }

        // GET: News/Edit
        public ActionResult Edit(int id)
        {
            SelectNewsObject selectNewsObject = _db.sp_SelectNewsById(id).First();
            if (selectNewsObject == null)
            {
                return HttpNotFound();
            }
            return View(selectNewsObject);
        }

        // POST: News/Edit
        [HttpPost]
        public ActionResult Edit(int id, FormCollection collection)
        {
            try
            {
                SelectNewsObject selectNewsObject = _db.sp_SelectNewsById(id).First();
                if (ModelState.IsValid)
                {
                    var cid = selectNewsObject.CId;
                    _db.sp_UpdateNews(id, cid, collection["NewsTitle"], collection["NewsContent"]);
                }
                return RedirectToAction("Index");
            }
            catch(Exception)
            {
                Console.WriteLine("News-Edit-Post is take error.");
                return View();
            }
        }

        // GET: News/Delete
        public ActionResult Delete(int id)
        {
            SelectNewsObject selectNewsObject = _db.sp_SelectNewsById(id).First();
            if (selectNewsObject == null)
            {
                return HttpNotFound();
            }
            return View(selectNewsObject);
        }

        // POST: News/Delete
        [HttpPost]
        public ActionResult Delete(int id, FormCollection collection)
        {
            try
            {
                _db.sp_DeleteNews(id);
                return RedirectToAction("Index");
            }
            catch(Exception)
            {
                Console.WriteLine("News-Delete-Post is take error.");
                return View();
            }
        }
    }
}
