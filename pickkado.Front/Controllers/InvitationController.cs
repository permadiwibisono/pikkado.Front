using pickkado.Front.Db;
using pickkado.Front.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.Owin;
using Microsoft.Owin.Security;
using System.Threading.Tasks;
using System.IO;

namespace pickkado.Front.Controllers
{
    public class InvitationController : Controller
    {
        #region properties
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
        public InvitationController()
        {
        }

        public InvitationController(ApplicationUserManager userManager, ApplicationSignInManager signInManager)
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
        #endregion
        //
        // GET: /Invitation/

        public ActionResult Index()
        {
            return View();
        }
        public ActionResult Giftcard(string code="")
        {
            try {
                Guid codeGuid;
                if (Guid.TryParse(code, out codeGuid))
                {
                    var get = db.TransactionGiftcardMessage.Where(e => e.ShareCode == codeGuid).ToList();
                    if (get.Count > 0)
                    {
                        var a = get[0];
                        if (string.IsNullOrEmpty(a.Message))
                        {
                            if (DateTime.Now <= a.BatasWaktu)
                            {
                                if (Request.IsAuthenticated)
                                {
                                    var userName = User.Identity.GetUserName();
                                    if (userName != a.Email)
                                        return RedirectToAction("index", "home");
                                    else
                                    {
                                        var model = new InputGiftcardMessageViewModel()
                                        {
                                            Id = a.Id,
                                        };
                                        return View(model);
                                    }
                                }
                                else
                                {
                                    var model = new InputGiftcardMessageViewModel()
                                    {
                                        Id = a.Id,
                                        EmailLogin = a.Email,
                                        EmailRegister = a.Email,
                                        Firstname = a.Name
                                    };
                                    return View(model);

                                }
                            }
                            else
                            {
                                ViewBag.errorMessage = "Undangan giftcard kamu telah kadarluasa, tidak disubmit.";
                                return View("Error");
                            }
                        }
                        else
                        {
                            ViewBag.errorMessage = "Ucapan giftcard kamu telah disubmit.";
                            return View("Error");

                        }
                    }
                    else
                    {
                        ViewBag.errorMessage = "Code tidak ditemukan.";
                        return View("Error");

                    }
                }
                else {
                    ViewBag.errorMessage = "Code tidak ditemukan.";
                    return View("Error");
                }
                
            
            }
            catch (Exception ex)
            {
                ViewBag.errorMessage = ex.Message;
                return PartialView("Error");            
            }
        }
        [HttpPost]
        public async Task<ActionResult> Giftcard(InputGiftcardMessageViewModel model, string code = "")
        {
            try
            {
                if (ModelState.IsValid)
                {
                    if (Request.IsAuthenticated)
                    {
                        var a = db.TransactionGiftcardMessage.Find(model.Id);
                        if (a == null)
                        {
                            return HttpNotFound();
                        }
                        
                        var userName = User.Identity.GetUserName();
                        if (userName != a.Email)
                        {
                            return View("Error");
                        }
                        else
                        {
                            var user= await UserManager.FindByEmailAsync(userName);
                            a.Message = model.Message;
                            a.UpdatedBy = user.UserId;
                            a.UpdatedDate = DateTime.Now;
                            a.UserId = user.UserId;
                            await db.SaveChangesAsync();
                            ViewBag.successMessage = "Kartu ucapan kamu telah disubmit.";
                            return View("Success");
                        }
                    }
                    else
                    {
                        if (string.IsNullOrEmpty(model.PasswordLogin) && string.IsNullOrEmpty(model.PasswordRegister))
                        {
                            ModelState.AddModelError("", "Kamu perlu login atau daftar jika kamu belum mempunyai akun pickkado.");
                        }
                        else
                        {
                            if (!string.IsNullOrEmpty(model.PasswordLogin))
                            {
                                var user = await UserManager.FindByEmailAsync(model.EmailLogin);
                                if (user == null)
                                    ModelState.AddModelError("", "Email tersebut belum terdaftar di pickkado.");
                                else
                                {

                                    var result = await SignInManager.PasswordSignInAsync(model.EmailLogin, model.PasswordLogin, false, shouldLockout: false);
                                    switch (result)
                                    {
                                        case SignInStatus.Success:
                                            {
                                                var get = db.TransactionGiftcardMessage.Find(model.Id);
                                                if (get == null)
                                                    return HttpNotFound();
                                                else
                                                {
                                                    get.Message = model.Message;
                                                    get.UpdatedBy = user.UserId;
                                                    get.UpdatedDate = DateTime.Now;
                                                    await db.SaveChangesAsync();
                                                }
                                            } break;
                                        case SignInStatus.Failure:
                                        default:
                                            ModelState.AddModelError("", "Invalid login attempt.");
                                            return View(model);
                                    }
                                }
                            }
                            else {

                                var userDb = new Entities.User();
                                userDb.Id = userDb.GenerateId("U");
                                userDb.LastName = model.Lastname;
                                userDb.FirstName = model.Firstname;
                                userDb.Email = model.EmailRegister;
                                userDb.BirthDate = DateTime.Now;
                                userDb.CreatedBy = model.EmailRegister;
                                userDb.CreatedDate = DateTime.Now;
                                userDb.UpdatedBy = model.EmailRegister;
                                userDb.UpdatedDate = DateTime.Now;
                                userDb.Gender = 0;
                                userDb.VirtualMoney = 0;
                                db.User.Add(userDb);
                                db.SaveChanges();
                                var user = new ApplicationUser
                                {
                                    UserName = model.EmailRegister,
                                    Email = model.EmailRegister,
                                    UserId = userDb.Id
                                };
                                var result = await UserManager.CreateAsync(user, model.PasswordRegister);
                                if (result.Succeeded)
                                {

                                    var emailToken = await UserManager.GenerateEmailConfirmationTokenAsync(user.Id);
                                    UserManager.AddToRoles(user.Id, "User");
                                    var callbackUrl = Url.Action("ConfirmEmail", "Account", new { userId = user.Id, code = emailToken }, protocol: Request.Url.Scheme);
                                    string body;
                                    //Read template file from the App_Data folder
                                    using (var sr = new StreamReader(Server.MapPath("\\App_Data\\Templates\\") + "confirmemail.txt"))
                                    {
                                        body = sr.ReadToEnd();
                                    }
                                    string messageBody = string.Format(body, userDb.FirstName, callbackUrl, userDb.Email, model.PasswordRegister);
                                    await UserManager.SendEmailAsync(user.Id, "Confirm your account", messageBody);
                                    var get = db.TransactionGiftcardMessage.Find(model.Id);
                                    if (get == null)
                                        return HttpNotFound();
                                    else
                                    {
                                        get.Message = model.Message;
                                        get.UpdatedBy = user.UserId;
                                        get.UserId = userDb.Id;
                                        get.UpdatedDate = DateTime.Now;
                                        await db.SaveChangesAsync();
                                        ViewBag.successMessage = "Kartu ucapan kamu telah disubmit.";
                                        return View("Success");
                                    }

                                }
                                else
                                {
                                    db.User.Remove(userDb);
                                    AddErrors(result);
                                    await db.SaveChangesAsync();
                                }
                            }
                        }
                    }
                }
                return View(model);
            
            }
            catch (Exception ex)
            {
                ViewBag.errorMessage = ex.Message;
                return View("Error");
            }
        }

        public ActionResult Error()
        {
            return View();
        }
        public ActionResult Success()
        {
            return View();
        }

        #region Helpers

        private void AddErrors(IdentityResult result)
        {
            foreach (var error in result.Errors)
            {
                ModelState.AddModelError("", error);

            }
        }

        #endregion
    }
}
