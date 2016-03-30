using pickkado.Entities;
using pickkado.Front.Areas.Admin.Models;
using pickkado.Front.Db;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace pickkado.Front.Areas.Admin.Controllers
{
    [AuthorizeCustom(Roles = "Admin")]
    public class MasterProductController : Controller
    {
        PickkadoDBContext db = new PickkadoDBContext();
        //
        // GET: /Admin/MasterProduct/

        public ActionResult Index()
        {
            //ViewBag.List = db.Product.ToList();
            if (TempData["Success"] != null)
            {
                ViewBag.Success = TempData["Success"];
                TempData["Success"] = null;
            }
            if (TempData["Error"] != null)
            {
                ViewBag.Error = TempData["Error"];
                TempData["Error"] = null;
            }
            return View();
        }

        [HttpGet]
        public ActionResult Edit(string id = "")
        {
            if (TempData["Success"] != null)
            {
                ViewBag.Success = TempData["Success"];
                TempData["Success"] = null;
            }
            if (TempData["Error"] != null)
            {
                ViewBag.Error = TempData["Error"];
                TempData["Error"] = null;
            }

            try
            {
                /*var viewmodel = new MasterProductViewModel();

                if (string.IsNullOrEmpty(id))
                {
                    return View(viewmodel);
                }
                else if (db.Product.Where(e => e.Id.Contains(id)).ToList().Count != 0)
                {
                    var product = db.Product.Find(id);
                    //viewmodel.Brand = product.BrandId;
                    viewmodel.Name = product.Name;
                    viewmodel.Weight = product.Weight;
                    viewmodel.Description = product.Description;
                    viewmodel.Gender = product.Gender;
                    viewmodel.Price = product.Price;
                    //viewmodel.Category = product.Categories;

                    return View(viewmodel);
                }
                else
                {
                    return HttpNotFound();
                }*/
            }
            catch (Exception ex)
            {
                TempData["Error"] = ex.Message;
            }
            return View();
        }
        [HttpPost]
        public ActionResult Edit(MasterProductViewModel model, string id)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    /*if (string.IsNullOrEmpty(id))
                    {
                        var product = new Product();
                        //product.BrandId = model.Brand;
                        product.Name = model.Name;
                        product.Weight = model.Weight;
                        product.Description = model.Description;
                        product.Gender = model.Gender;
                        product.Price = model.Price;
                        //product.Categories = model.Category;
                        product.CreatedBy = "Admin";
                        product.CreatedDate = DateTime.Now;
                        product.UpdatedBy = "Admin";
                        product.UpdatedDate = DateTime.Now;
                        product.Id = product.GenerateId("PD");

                        db.Product.Add(product);
                        db.SaveChanges();
                        TempData["Success"] = " insert data";
                        return RedirectToAction("edit", new { id = product.Id });
                    }
                    else if (db.Product.Where(e => e.Id.Contains(id)).ToList().Count != 0)
                    {
                        var product = db.Product.Find(id);
                        //product.BrandId = model.Brand;
                        product.Name = model.Name;
                        product.Weight = model.Weight;
                        product.Description = model.Description;
                        product.Gender = model.Gender;
                        product.Price = model.Price;
                        //product.Categories = model.Category;
                        product.UpdatedBy = "Admin";
                        product.UpdatedDate = DateTime.Now;

                        db.SaveChanges();
                        ViewBag.Success = " update data";
                        return View(model);
                    }
                    else
                    {
                        return HttpNotFound();
                    }*/
                }
                    
            }
            catch (Exception ex)
            {
                ViewBag.Error = ex.Message;
            }
            return View(model);
        }

        [HttpPost]
        public ActionResult Delete(string id)
        {
            try
            {

                /*if (db.Product.Where(e => e.Id.Contains(id)).ToList().Count == 0)
                {
                    return HttpNotFound();
                }
                else
                {
                    var product = db.Product.Find(id);
                    db.Product.Remove(product);
                    db.SaveChanges();
                    TempData["Success"] = " delete data";
                    return RedirectToAction("Index");
                }*/
            }
            catch (Exception ex)
            {
                TempData["Error"] = ex.Message;

            }
            return RedirectToAction("index");
        }

    }
}
