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
    public class MasterGiftCardController : Controller
    {
        PickkadoDBContext db = new PickkadoDBContext();
        //
        // GET: Admin/MasterPackage/

        public ActionResult Index()
        {
            ViewBag.List = db.GiftCard.ToList();
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

                if (string.IsNullOrEmpty(id))
                {
                    return View();
                }
                else if (db.GiftCard.Where(e => e.Id.Contains(id)).ToList().Count != 0)
                {
                    var giftCard = db.GiftCard.Find(id);
                    var viewmodel = new MasterGiftCardViewModel();
                    viewmodel.Name = giftCard.Name;
                    viewmodel.image = giftCard.Image;
                    viewmodel.Quantity = giftCard.Quantity;
                    viewmodel.Visible = giftCard.Visible;
                    viewmodel.Price = giftCard.Price;

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
        public ActionResult Edit(MasterGiftCardViewModel model, string id)
        {
            try
            {
                if (ModelState.IsValid)
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
                        var giftCard = new GiftCard();
                        giftCard.Name = model.Name;
                        giftCard.Image = model.image;
                        giftCard.Quantity = model.Quantity;
                        giftCard.CreatedBy = "Admin";
                        giftCard.CreatedDate = DateTime.Now;
                        giftCard.UpdatedBy = "Admin";
                        giftCard.UpdatedDate = DateTime.Now;
                        giftCard.Id = giftCard.GenerateId("GC");
                        giftCard.Image = model.image;
                        giftCard.Visible = true;
                        giftCard.Price = model.Price;
                        db.GiftCard.Add(giftCard);
                        db.SaveChanges();
                        TempData["Success"] = " insert data";
                        return RedirectToAction("Edit", new { id = giftCard.Id });
                    }
                    else if (db.GiftCard.Where(e => e.Id.Contains(id)).ToList().Count != 0)
                    {
                        var giftCard = db.GiftCard.Find(id);
                        giftCard.Name = model.Name;
                        //giftCard.image = viewmodel.Image;
                        giftCard.Quantity = model.Quantity;
                        giftCard.UpdatedBy = "Admin";
                        giftCard.UpdatedDate = DateTime.Now;
                        if (model.image != null)
                            giftCard.Image = model.image;
                        giftCard.Visible = model.Visible;
                        model.image = giftCard.Image;
                        giftCard.Price = model.Price;
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

                if (db.GiftCard.Where(e => e.Id.Contains(id)).ToList().Count == 0)
                {
                    return HttpNotFound();
                }
                else
                {
                    var pack = db.GiftCard.Find(id);
                    db.GiftCard.Remove(pack);
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
