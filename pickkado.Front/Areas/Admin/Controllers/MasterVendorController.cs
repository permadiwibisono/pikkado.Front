using pickkado.Entities;
using pickkado.Front.Areas.Admin.Models;
using pickkado.Front.Db;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;


using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.Owin;
using Microsoft.Owin.Security;
using pickkado.Front.Models;
using System.Threading.Tasks;
using System.IO;

namespace pickkado.Front.Areas.Admin.Controllers
{
    [AuthorizeCustom(Roles = "Admin")]
    public class MasterVendorController : Controller
    {
        public MasterVendorController()
        {
        }

        public MasterVendorController(ApplicationUserManager userManager, ApplicationSignInManager signInManager)
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

        pickkado.Front.Db.PickkadoDBContext db = new pickkado.Front.Db.PickkadoDBContext();
        //
        // GET: /Admin/MasterVendor/

        public ActionResult Index()
        {
            ViewBag.List = db.Store.ToList();
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
                var viewmodel = new MasterVendorViewModel();

                if (string.IsNullOrEmpty(id))
                {
                    return View(viewmodel);
                }
                else if (db.Store.Where(e => e.Id.Contains(id)).ToList().Count != 0)
                {
                    var store = db.Store.Find(id);
                    viewmodel.Name = store.Name;
                    viewmodel.Address = store.Address;
                    viewmodel.Kelurahan = store.Kelurahan;
                    viewmodel.Kecamatan = store.Kecamatan;
                    viewmodel.Kota = store.Kota;
                    viewmodel.PhoneNumber = store.PhoneNumber;
                    viewmodel.WebAddress = store.WebAddress;
                    viewmodel.Email = store.Email;
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
        public async Task<ActionResult> Edit(MasterVendorViewModel model, string id)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    if (string.IsNullOrEmpty(id))
                    {
                        var store = new Store();
                        store.Name = model.Name;
                        store.Address = model.Address;
                        store.Kelurahan = model.Kelurahan;
                        store.Kecamatan = model.Kecamatan;
                        store.Kota = model.Kota;
                        store.PhoneNumber = model.PhoneNumber;
                        store.WebAddress = model.WebAddress;
                        store.CreatedBy = "Admin";
                        store.CreatedDate = DateTime.Now;
                        store.UpdatedBy = "Admin";
                        store.UpdatedDate = DateTime.Now;
                        store.Email = model.Email;
                        store.Id = store.GenerateId("ST");

                        //db.Store.Add(store);
                        //db.SaveChanges();
                        string password = 'P'+RandomString(4)+';';
                        var user = new ApplicationUser
                        {
                            UserName = model.Email,
                            Email = model.Email,
                            PhoneNumber = model.PhoneNumber,
                            //UserId=store.Id
                        };
                        var result = await UserManager.CreateAsync(user, password);
                        if (result.Succeeded)
                        {

                            db.Store.Add(store);
                            db.SaveChanges();
                            var code = await UserManager.GenerateEmailConfirmationTokenAsync(user.Id);
                            UserManager.AddToRoles(user.Id, "Vendor");
                            var callbackUrl = Url.Action("ConfirmEmail", "Account", new { userId = user.Id, code = code }, protocol: Request.Url.Scheme);
                            string body;
                            //Read template file from the App_Data folder
                            using (var sr = new StreamReader(Server.MapPath("\\App_Data\\Templates\\") + "confirmemailvendor.txt"))
                            {
                                body = sr.ReadToEnd();
                            }
                            var pathLogo = Server.MapPath("\\Images\\") + "brand.png";
                            var byteLogo = System.IO.File.ReadAllBytes(pathLogo);
                            string messageBody = string.Format(body, "data:image/png;base64," + System.Convert.ToBase64String(byteLogo), store.Name, callbackUrl, store.Email, password);

                            await UserManager.SendEmailAsync(user.Id, "Confirm your account", messageBody);

                            ViewBag.Link = callbackUrl;
                            TempData["Success"] = " insert data";
                            return RedirectToAction("edit", new { id = store.Id });
                        }
                        else
                        {
                            TempData["Error"] = " insert data";
                            return View(model);
                        }
                    }
                    else if (db.Store.Where(e => e.Id.Contains(id)).ToList().Count != 0)
                    {
                        var store = db.Store.Find(id);
                        store.Name = model.Name;
                        store.Address = model.Address;
                        store.Kelurahan = model.Kelurahan;
                        store.Kecamatan = model.Kecamatan;
                        store.Kota = model.Kota;
                        store.PhoneNumber = model.PhoneNumber;
                        store.WebAddress = model.WebAddress;
                        store.Email = model.Email;
                        store.UpdatedBy = "Admin";
                        store.UpdatedDate = DateTime.Now;

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
        public string RandomString(int length)
        {
            string chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789".ToLower();
            var random = new Random();
            return new string(Enumerable.Repeat(chars, length)
              .Select(s => s[random.Next(s.Length)]).ToArray());
        }
        [HttpPost]
        public ActionResult Delete(string id)
        {
            try
            {

                if (db.Store.Where(e => e.Id.Contains(id)).ToList().Count == 0)
                {
                    return HttpNotFound();
                }
                else
                {
                    var store = db.Store.Find(id);
                    db.Store.Remove(store);
                    db.SaveChanges();
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
