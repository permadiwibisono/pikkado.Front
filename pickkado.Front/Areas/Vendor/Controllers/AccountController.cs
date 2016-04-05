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

namespace pickkado.Front.Areas.Vendor.Controllers
{
    public class AccountController : Controller
    {
        //
        // GET: /Vendor/Account/

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
        public AccountController(ApplicationUserManager userManager, ApplicationSignInManager signInManager)
        {
            UserManager = userManager;
            SignInManager = signInManager;
        }
        public AccountController()
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

        [AuthorizeCustom(Roles = "Vendor")]
        public ActionResult Index()
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
            var a = Request.IsAuthenticated;
            var user = User.Identity.GetUserName();
            var get = UserManager.FindByName(user);
            var viewmodel = new ProfileViewModel();
            if (get != null)
            {
                viewmodel.Name = get.user.Store.Name;
                viewmodel.Address = get.user.Store.Address;
                viewmodel.Kelurahan = get.user.Store.Kelurahan;
                viewmodel.Kecamatan = get.user.Store.Kecamatan;
                viewmodel.Kota = get.user.Store.Kota;
                viewmodel.PhoneNumber = get.user.Store.PhoneNumber;
                viewmodel.WebAddress = get.user.Store.WebAddress;
                viewmodel.Email = get.user.Store.Email;
            }
            return View(viewmodel);
        }

        [AuthorizeCustom(Roles = "Vendor")]
        [HttpPost]
        public ActionResult Index(ProfileViewModel model)
        {
            if (ModelState.IsValid)
            {
                if (string.IsNullOrEmpty(model.CurrentPassword) && string.IsNullOrEmpty(model.CurrentPassword) && string.IsNullOrEmpty(model.CurrentPassword))
                {
                    var a = Request.IsAuthenticated;
                    var user = User.Identity.GetUserName();
                    var get = UserManager.FindByName(user);
                    var u = db.User.Find(get.UserId);
                    if (get != null)
                    {
                        var s = db.Store.Find(u.StoreId);
                        s.Name = model.Name;
                        s.Address = model.Address;
                        s.Kelurahan = model.Kelurahan;
                        s.Kecamatan = model.Kecamatan;
                        s.Kota = model.Kota;
                        s.PhoneNumber = model.PhoneNumber;
                        s.WebAddress = model.WebAddress;
                        db.SaveChanges();
                        ViewBag.Success = " update data";
                    }
                }
                else
                {
                    if (!string.IsNullOrEmpty(model.CurrentPassword) && !string.IsNullOrEmpty(model.CurrentPassword) && !string.IsNullOrEmpty(model.CurrentPassword))
                    {
                        var a = Request.IsAuthenticated;
                        var user = User.Identity.GetUserName();
                        var get = UserManager.FindByName(user);
                        var u = db.User.Find(get.UserId);
                        if (get != null)
                        {
                            var s = db.Store.Find(u.StoreId);
                            s.Name = model.Name;
                            s.Address = model.Address;
                            s.Kelurahan = model.Kelurahan;
                            s.Kecamatan = model.Kecamatan;
                            s.Kota = model.Kota;
                            s.PhoneNumber = model.PhoneNumber;
                            s.WebAddress = model.WebAddress;
                            var task = UserManager.ChangePasswordAsync(get.Id, model.CurrentPassword, model.NewPassword);
                            Task.WaitAll(task);
                            if (task.Result.Succeeded)
                            {
                                db.SaveChanges();
                                ViewBag.Success = " update data";
                            }
                            else
                            {
                                foreach (var er in task.Result.Errors)
                                {
                                    ModelState.AddModelError("", er);

                                }
                            }
                        }
                    }
                    else
                    {
                        if (string.IsNullOrEmpty(model.CurrentPassword))
                            ModelState.AddModelError("", "Fill your current password");
                        if (string.IsNullOrEmpty(model.NewPassword))
                            ModelState.AddModelError("", "Fill your new password");
                        if (string.IsNullOrEmpty(model.ConfirmPassword))
                            ModelState.AddModelError("", "Fill your confirm new password");
                    }
                }
            }
            string errorMessage = "";
            foreach (var error in ModelState.Values)
            {
                foreach (var e in error.Errors)
                {
                    errorMessage += e.ErrorMessage + "\n";
                }
            }
            if (!string.IsNullOrEmpty(errorMessage))
                ViewBag.Error = " update data:\n " + errorMessage;
            return View(model);
        }

        public ActionResult Login_Partial()
        {
            var a = Request.IsAuthenticated;
            var user = User.Identity.GetUserName();
            var get = UserManager.FindByName(user);
            string fName = get.user.Store.Name ?? "No Name";
            ViewBag.Name = fName;
            ViewBag.UserName = user;
            return View();
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult LogOut()
        {
            AuthenticationManager.SignOut();
            return RedirectToAction("Index", "Home");
        }

        private IAuthenticationManager AuthenticationManager
        {
            get
            {
                return HttpContext.GetOwinContext().Authentication;
            }
        }
    }
}
