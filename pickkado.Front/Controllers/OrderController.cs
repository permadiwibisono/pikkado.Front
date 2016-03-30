using pickkado.Front.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace pickkado.Front.Controllers
{
    public class OrderController : Controller
    {
        //
        // GET: /Order/PreviewOrder
        [HttpGet]
        public ActionResult PreviewOrder()
        {
            if (Session["Transaction"] != null)
            {
                var tran = (TransactionModel)Session["Transaction"];
                return View(tran.orderInfo);
            }
            else
                return RedirectToAction("index", "home");
        }
        //
        // GET: /Order/
        [HttpGet]
        public ActionResult Index()
        {
            if (Session["Transaction"] != null)
            {
                var tran = (TransactionModel)Session["Transaction"];
                return View(tran.orderInfo);
            }
            return View();
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Index(OrderViewModel model)
        {
            if (ModelState.IsValid)
            {
                if (model.image != null && model.image.ContentLength > 0)
                {
                    if (model.image.ContentType == "image/png" || model.image.ContentType == "image/jpeg" || model.image.ContentType == "image/gif")
                    {
                        if (model.image.ContentLength < 2048000)
                        {
                            using (var reader = new System.IO.BinaryReader(model.image.InputStream))
                            {
                                model.imageByte = reader.ReadBytes(model.image.ContentLength);
                            }
                        }
                        else
                        {
                            ModelState.AddModelError("", "Max size of image is 2MB");
                            return View(model);
                        }
                    }
                    else
                    {
                        ModelState.AddModelError("", "Only .png, .jpg and .gif extension allowed"); 
                        return View(model);
                    }
                }
                TransactionModel tran = new TransactionModel();
                tran.TransactionType = TransactionType.Order;
                if (Session["Transaction"] != null)
                {
                    tran = (TransactionModel)Session["Transaction"];
                }
                tran.orderInfo = model;
                Session["Transaction"] = tran;
                return RedirectToAction("previeworder");
            }
            return View(model);
        }
        //
        // GET: /Order/Details/5

        public ActionResult Details(int id)
        {
            return View();
        }

        //
        // GET: /Order/Create

        public ActionResult Create()
        {
            return View();
        }

        //
        // POST: /Order/Create

        [HttpPost]
        public ActionResult Create(FormCollection collection)
        {
            try
            {
                // TODO: Add insert logic here

                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }

        //
        // GET: /Order/Edit/5

        public ActionResult Edit(int id)
        {
            return View();
        }

        //
        // POST: /Order/Edit/5

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

        //
        // GET: /Order/Delete/5

        public ActionResult Delete(int id)
        {
            return View();
        }

        //
        // POST: /Order/Delete/5

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
