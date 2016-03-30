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
    public class MasterAccountBankController : Controller
    {
        PickkadoDBContext db = new PickkadoDBContext();
        //
        // GET: /Admin/MasterAccountBank/

        public ActionResult Index()
        {
            ViewBag.List = db.NoRekeningPickkado.OrderBy(e=>e.Visible).ToList();
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
                else if (db.NoRekeningPickkado.Where(e => e.Id.Contains(id)).ToList().Count != 0)
                {
                    var pack = db.NoRekeningPickkado.Find(id);
                    var viewmodel = new MasterAccountBankViewModel();
                    viewmodel.AtasNama = pack.AtasNama;
                    viewmodel.Bank = pack.Bank;
                    viewmodel.CabangBank = pack.CabangBank;
                    viewmodel.NoRekening = pack.NomorRekening;
                    viewmodel.Visible = pack.Visible;

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
        public ActionResult Edit(MasterAccountBankViewModel model, string id)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    
                    if (string.IsNullOrEmpty(id))
                    {
                        var norek = new NoRekeningPickkado();
                        norek.AtasNama = model.AtasNama;
                        norek.Bank = model.Bank;
                        norek.CabangBank = model.CabangBank;
                        norek.NomorRekening = model.NoRekening;
                        norek.CreatedBy = "Admin";
                        norek.CreatedDate = DateTime.Now;
                        norek.UpdatedBy = "Admin";
                        norek.UpdatedDate = DateTime.Now;
                        norek.Id = norek.GenerateId("REK");
                        norek.Visible = true;
                        db.NoRekeningPickkado.Add(norek);
                        db.SaveChangesAsync();
                        ViewBag.Success = " update data";
                        return RedirectToAction("Edit", new { id = norek.Id });
                    }
                    else if (db.NoRekeningPickkado.Where(e => e.Id.Contains(id)).ToList().Count != 0)
                    {
                        var norek = db.NoRekeningPickkado.Find(id);
                        norek.AtasNama = model.AtasNama;
                        norek.Bank = model.Bank;
                        norek.CabangBank = model.CabangBank;
                        norek.NomorRekening = model.NoRekening;
                        norek.UpdatedBy = "Admin";
                        norek.UpdatedDate = DateTime.Now;
                        norek.Visible = true;
                        db.SaveChangesAsync();
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

                if (db.NoRekeningPickkado.Where(e => e.Id.Contains(id)).ToList().Count == 0)
                {
                    return HttpNotFound();
                }
                else
                {
                    var norek = db.NoRekeningPickkado.Find(id);
                    db.NoRekeningPickkado.Remove(norek);
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
