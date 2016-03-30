using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using pickkado.Front.Db;
using pickkado.Front.Areas.Admin.Models;
using pickkado.Entities;
using System.Threading.Tasks;

namespace pickkado.Front.Areas.Admin.Controllers
{
    [AuthorizeCustom(Roles = "Admin")]
    public class MasterBrandController : Controller
    {
        PickkadoDBContext db = new PickkadoDBContext();
        //
        // GET: /Admin/MasterBrand/

        public ActionResult Index()
        {
            ViewBag.List = db.Brand.ToList();
            if (TempData["Success"] != null)
            {
                ViewBag.Success = TempData["Success"];
                TempData["Success"] = null;
            }
            if(TempData["Error"] !=null)
            {
                ViewBag.Error = TempData["Error"];
                TempData["Error"] = null;
                
            }
            return View();
        }
        [HttpPost]
        public async Task<ActionResult> New(MasterBrandViewModel model)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    var b = new Brand();
                    b.Id = b.GenerateId("BR");
                    b.Name = model.Name;
                    b.CreatedBy = "Admin";
                    b.CreatedDate = DateTime.Now;
                    b.UpdatedBy = "Admin";
                    b.UpdatedDate = DateTime.Now;
                    db.Brand.Add(b);
                    await db.SaveChangesAsync();
                    TempData["Success"] = " insert data";
                    //return Json(new {Id=b.Id,Name=b.Name,UpdatedBy=b.UpdatedBy,UpdatedDate=b.UpdatedDate.ToString() });
                }
                else
                {
                    TempData["Error"] = " when inserting data";
                }
            }
            catch (Exception ex)
            {
                TempData["Error"] = ex.Message;
                
            }
            return RedirectToAction("Index");
        }
        [HttpGet]
        public ActionResult Edit(string id)
        {
            if (db.Brand.Where(e => e.Id.Contains(id)).ToList().Count == 0)
            {
                return HttpNotFound();
            }
            else
            {
                var brand = db.Brand.Find(id);
                var viewmodel = new MasterBrandViewModel();
                viewmodel.Name = brand.Name;
                return View(viewmodel);
            }
        }
        [HttpPost]
        public ActionResult Edit(MasterBrandViewModel model, string id)
        {
            try
            {
                if (db.Brand.Where(e => e.Id.Contains(id)).ToList().Count == 0)
                {
                    return HttpNotFound();
                }
                else
                {
                    var brand = db.Brand.Find(id);
                    brand.Name = model.Name;
                    brand.UpdatedBy = "Admin";
                    brand.UpdatedDate = DateTime.Now;
                    db.SaveChangesAsync();
                    ViewBag.Success = " update data";
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
                if (db.Brand.Where(e => e.Id.Contains(id)).ToList().Count == 0)
                {
                    return HttpNotFound();
                }
                else
                {
                    var brand = db.Brand.Find(id);
                    db.Brand.Remove(brand);
                    db.SaveChangesAsync();
                    TempData["Success"] = " delete data";
                }

            }
            catch (Exception ex)
            {
                TempData["Error"] = ex.Message;

            }
            return RedirectToAction("Index");
        }
    }
}
