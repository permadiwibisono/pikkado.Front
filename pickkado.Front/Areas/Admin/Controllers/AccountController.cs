using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;

using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.Owin;
using Microsoft.Owin.Security;
using pickkado.Front.Models;
using pickkado.Front.Areas.Admin.Models;
using pickkado.Front.Db;
namespace pickkado.Front.Areas.Admin.Controllers
{
    public class AccountController : Controller
    {
        //
        // GET: /Admin/Account/
        public AccountController()
        {
        }

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

        [AuthorizeCustom(Roles = "Admin")]
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
                viewmodel.FirstName = get.user.FirstName;
                viewmodel.Lastname = get.user.LastName;
                viewmodel.Birthdate = get.user.BirthDate;
                viewmodel.Birthplace = get.user.BirthPlace;
                viewmodel.PhoneNumber = get.user.PhoneNumber;
                viewmodel.Gender = get.user.Gender;
            }
            return View(viewmodel);
        }

        [AuthorizeCustom(Roles="Admin")]
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
                        u.FirstName = model.FirstName;
                        u.LastName = model.Lastname;
                        u.BirthDate = model.Birthdate;
                        u.BirthPlace = model.Birthplace;
                        u.PhoneNumber = model.PhoneNumber;
                        u.Gender = model.Gender;
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
                            u.FirstName = model.FirstName;
                            u.LastName = model.Lastname;
                            u.BirthDate = model.Birthdate;
                            u.BirthPlace = model.Birthplace;
                            u.PhoneNumber = model.PhoneNumber;
                            u.Gender = model.Gender;
                            var task=UserManager.ChangePasswordAsync(get.Id, model.CurrentPassword, model.NewPassword);
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
            if(!string.IsNullOrEmpty(errorMessage))
                ViewBag.Error = " update data:\n " + errorMessage;
            return View(model);
        }
        [AllowAnonymous]
        public async Task<ActionResult> ConfirmEmail(string userId, string code)
        {
            if (userId == null || code == null)
            {
                return View("Error");
            }
            var result = await UserManager.ConfirmEmailAsync(userId, code);
            return View(result.Succeeded ? "ConfirmEmail" : "Error");
        }
        public ActionResult Login_Partial()
        {
            var a = Request.IsAuthenticated;
            var user = User.Identity.GetUserName();
            var get= UserManager.FindByName(user);
            string fName = get.user.FirstName ?? "No Name";
            string lName = get.user.LastName ?? "";
            ViewBag.Name =  fName+ " " + lName;
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
