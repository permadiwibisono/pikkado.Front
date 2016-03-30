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
    public class MasterVoucherController : Controller
    {
        //
        // GET: /Admin/MasterVoucher/

        PickkadoDBContext db = new PickkadoDBContext();
        public ActionResult Index()
        {
            ViewBag.List = db.VoucherMaster.ToList();
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
            try
            {

                if (string.IsNullOrEmpty(id))
                {
                    return View();
                }
                else if (db.VoucherMaster.Where(e => e.Id.Contains(id)).ToList().Count != 0)
                {
                    var v = db.VoucherMaster.Find(id);
                    var viewmodel = new MasterVoucherViewModel();
                    viewmodel.VoucherId = v.Id;
                    viewmodel.Name = v.Name;
                    viewmodel.VoucherType = v.VoucherType;
                    viewmodel.VoucherDiscount = v.VoucherDiscount;
                    viewmodel.Quantity = v.Quantity;
                    viewmodel.IsLimitQty = v.isLimitQty;
                    viewmodel.FromDate = v.FromDate;
                    viewmodel.ToDate = v.ToDate;
                    viewmodel.MinTransaction = v.MinTransaction;

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
        public ActionResult Edit(MasterVoucherViewModel model, string id)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    if (string.IsNullOrEmpty(id))
                    {
                        var v = new VoucherMaster();
                        v.Name = model.Name;
                        v.Quantity = model.Quantity;
                        v.CreatedBy = "Admin";
                        v.CreatedDate = DateTime.Now;
                        v.UpdatedBy = "Admin";
                        v.UpdatedDate = DateTime.Now;
                        v.Id = model.VoucherId;
                        v.VoucherType = model.VoucherType;
                        v.VoucherDiscount = model.VoucherDiscount;
                        v.isLimitQty = model.IsLimitQty;
                        v.FromDate = model.FromDate;
                        v.ToDate = model.ToDate;
                        v.MinTransaction = model.MinTransaction;
                        db.VoucherMaster.Add(v);
                        db.SaveChanges();
                        ViewBag.Success = " insert data";
                        return RedirectToAction("edit", new { id = v.Id });
                    }
                    else if (db.VoucherMaster.Where(e => e.Id.Contains(id)).ToList().Count != 0)
                    {
                        var v = db.VoucherMaster.Find(id);
                        v.Name = model.Name;
                        v.Quantity = model.Quantity;
                        v.UpdatedBy = "Admin";
                        v.UpdatedDate = DateTime.Now;
                        v.VoucherType = model.VoucherType;
                        v.VoucherDiscount = model.VoucherDiscount;
                        v.isLimitQty = model.IsLimitQty;
                        v.FromDate = model.FromDate;
                        v.ToDate = model.ToDate;
                        v.MinTransaction = model.MinTransaction;
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

                if (db.VoucherMaster.Where(e => e.Id.Contains(id)).ToList().Count == 0)
                {
                    return HttpNotFound();
                }
                else
                {
                    var v = db.VoucherMaster.Find(id);
                    db.VoucherMaster.Remove(v);
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
