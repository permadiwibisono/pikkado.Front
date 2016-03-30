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
    public class MasterPackageController : Controller
    {
        PickkadoDBContext db = new PickkadoDBContext();
        //
        // GET: Admin/MasterPackage/

        public ActionResult Index()
        {
            ViewBag.List = db.Package.ToList();
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
        public ActionResult Edit(string id="")
        {
            try
            {

                if (string.IsNullOrEmpty(id))
                {
                    return View();
                }
                else if (db.Package.Where(e => e.Id.Contains(id)).ToList().Count != 0)
                {
                    var pack = db.Package.Find(id);
                    var viewmodel = new MasterPackageViewModel();
                    viewmodel.Name = pack.Name;
                    viewmodel.image = pack.Image;
                    viewmodel.Quantity = pack.Quantity;
                    viewmodel.Visible = pack.Visible;
                    viewmodel.Price = pack.Price;
                    
                    return View(viewmodel);
                }
                else
                {
                    return HttpNotFound();
                }
            }
            catch (Exception ex)
            {
                TempData["Error"] = ex.Message;

            }
            return View();
        }
        [HttpPost]
        public ActionResult Edit(MasterPackageViewModel model, string id)
        {
            try
            {
                if(ModelState.IsValid)
                {
                    if (model.imagepost != null)
                    {
                        if (model.imagepost.ContentType == "image/png" || model.imagepost.ContentType == "image/jpeg" || model.imagepost.ContentType == "image/gif")
                        {
                            if (model.imagepost.ContentLength < 2048000)
                            {
                                using (var reader = new System.IO.BinaryReader(model.imagepost.InputStream))
                                {
                                    model.image = reader.ReadBytes(model.imagepost.ContentLength);
                                }
                            }
                            else 
                            {
                                ModelState.AddModelError("imagesize", "Max size of image is 2MB");
                                return View(model);
                            }
                        }
                    }
                    if (string.IsNullOrEmpty(id))
                    {
                        var pack = new Package();
                        pack.Name = model.Name;
                        //pack.image = viewmodel.Image;
                        pack.Quantity = model.Quantity;
                        pack.CreatedBy = "Admin";
                        pack.CreatedDate = DateTime.Now;
                        pack.UpdatedBy = "Admin";
                        pack.UpdatedDate = DateTime.Now;
                        pack.Id = pack.GenerateId("PK");
                        pack.Image = model.image;
                        pack.Visible = true;
                        pack.Price = model.Price;
                        db.Package.Add(pack);
                        db.SaveChanges();
                        ViewBag.Success = " update data";
                        return RedirectToAction("Edit", new { id = pack.Id });
                    }
                    else if (db.Package.Where(e => e.Id.Contains(id)).ToList().Count != 0)
                    {
                        var pack = db.Package.Find(id);
                        pack.Name = model.Name;
                        //pack.image = viewmodel.Image;
                        pack.Quantity = model.Quantity;
                        pack.UpdatedBy = "Admin";
                        pack.UpdatedDate = DateTime.Now;
                        if(model.image!=null)
                            pack.Image = model.image;
                        pack.Visible = model.Visible;
                        model.image = pack.Image;
                        pack.Price = model.Price;
                        db.SaveChanges();
                        ViewBag.Success = " update data";
                        return View(model);
                    }
                    else
                    {
                        return HttpNotFound();
                    }
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

                if (db.Package.Where(e => e.Id.Contains(id)).ToList().Count == 0)
                {
                    return HttpNotFound();
                }
                else
                {
                    var pack = db.Package.Find(id);
                    db.Package.Remove(pack);
                    db.SaveChangesAsync();
                    TempData["Success"] = " delete data";
                    return RedirectToAction("Index");
                }
            }
            catch (Exception ex)
            {
                TempData["Error"] = ex.Message;

            }
            return RedirectToAction("index");
        }
    }
}
