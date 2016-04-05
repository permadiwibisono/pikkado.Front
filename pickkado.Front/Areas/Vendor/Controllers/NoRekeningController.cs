using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.Owin;
using Microsoft.Owin.Security;
using pickkado.Front.Models;
using pickkado.Front.Areas.Vendor.Models;
using pickkado.Front.Db;
using System.Threading.Tasks;
using pickkado.Entities;
namespace pickkado.Front.Areas.Vendor.Controllers
{
    [AuthorizeCustom(Roles = "Vendor")]
    public class NoRekeningController : Controller
    {
        //
        // GET: /Vendor/NoRekening/
        #region
        private PickkadoDBContext _db;
        public PickkadoDBContext db
        {
            get
            {
                return _db ?? HttpContext.GetOwinContext().Get<PickkadoDBContext>();
            }
            private set
            {
                _db = value;
            }
        }
        public NoRekeningController(ApplicationUserManager userManager, ApplicationSignInManager signInManager)
        {
            UserManager = userManager;
            SignInManager = signInManager;
        }
        public NoRekeningController()
        {

        }
        private ApplicationUserManager _userManager;
        public ApplicationUserManager UserManager
        {
            get
            {
                return _userManager ?? HttpContext.GetOwinContext().GetUserManager<ApplicationUserManager>();
            }
            private set
            {
                _userManager = value;
            }
        }

        private ApplicationSignInManager _signInManager;
        public ApplicationSignInManager SignInManager
        {
            get
            {

                return _signInManager ?? HttpContext.GetOwinContext().Get<ApplicationSignInManager>();
            }
            private set { _signInManager = value; }
        }

        #endregion
        public ActionResult Index()
        {
            var user=UserManager.FindByName(User.Identity.GetUserName());
            ViewBag.List = db.NoRekening.Where(e => e.UserId==user.UserId).ToList();
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
                var user = UserManager.FindByName(User.Identity.GetUserName());
                if (string.IsNullOrEmpty(id))
                {
                    return View();
                }
                else if (db.NoRekening.Where(e => e.Id == id && e.UserId == user.UserId).SingleOrDefault()!=null)
                {
                    var pack = db.NoRekening.Where(e => e.Id == id && e.UserId == user.UserId).SingleOrDefault();
                    var viewmodel = new NoRekeningViewModel();
                    viewmodel.AtasNama = pack.AtasNama;
                    viewmodel.Bank = pack.Bank;
                    viewmodel.CabangBank = pack.CabangBank;
                    viewmodel.NoRekening = pack.NomorRekening;

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
        public async Task<ActionResult> Edit(NoRekeningViewModel model, string id)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    
                    var user = UserManager.FindByName(User.Identity.GetUserName());
                    if (string.IsNullOrEmpty(id))
                    {
                        var norek = new NoRekening();
                        norek.AtasNama = model.AtasNama;
                        norek.Bank = model.Bank;
                        norek.CabangBank = model.CabangBank;
                        norek.NomorRekening = model.NoRekening;
                        norek.CreatedBy = user.UserId;
                        norek.CreatedDate = DateTime.Now;
                        norek.UpdatedBy = user.UserId;
                        norek.UpdatedDate = DateTime.Now;
                        norek.Id = norek.GenerateId("REK");
                        norek.UserId = user.UserId;
                        //norek.Visible = true;
                        db.NoRekening.Add(norek);
                        await db.SaveChangesAsync();
                        ViewBag.Success = " update data";
                        return RedirectToAction("Edit", new { id = norek.Id });
                    }
                    else if (db.NoRekening.Where(e => e.Id == id && e.UserId == user.UserId).SingleOrDefault()!=null)
                    {
                        var norek = db.NoRekening.Where(e=>e.Id==id && e.UserId==user.UserId).SingleOrDefault();
                        norek.AtasNama = model.AtasNama;
                        norek.Bank = model.Bank;
                        norek.CabangBank = model.CabangBank;
                        norek.NomorRekening = model.NoRekening;
                        norek.UpdatedBy = user.UserId;
                        norek.UpdatedDate = DateTime.Now;
                        await db.SaveChangesAsync();
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
        public async Task<ActionResult> Delete(string id)
        {
            try
            {
                var user = UserManager.FindByName(User.Identity.GetUserName());
                if (db.NoRekening.Where(e => e.Id == id && e.UserId == user.UserId).SingleOrDefault()==null)
                {
                    return HttpNotFound();
                }
                else
                {
                    var norek = db.NoRekening.Where(e => e.Id == id && e.UserId == user.UserId).SingleOrDefault();
                    db.NoRekening.Remove(norek);
                    await db.SaveChangesAsync();
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
