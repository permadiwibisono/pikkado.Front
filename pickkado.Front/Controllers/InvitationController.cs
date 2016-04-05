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
        //
        // GET: /Invitation/Patungan

        //public ActionResult Patungan(string Id, string Email)
        //{
        //    PatunganInvitationViewModel patunganInvitation = new PatunganInvitationViewModel();
        //    var transInvitation = db.Transaction.Find(Id);

        //    patunganInvitation.TransId = transInvitation.Id;
        //    patunganInvitation.TransStatus = transInvitation.Status;
        //    var u = db.User.Find(transInvitation.UserId);
        //    patunganInvitation.UserImage = u.Image;
        //    patunganInvitation.UserName = u.FirstName + ' ' + u.LastName;
        //    patunganInvitation.TransDate = transInvitation.TransDate;
        //    patunganInvitation.PatunganTitle = transInvitation.GroupTitle;
        //    patunganInvitation.ProductName = transInvitation.ProductName;
        //    patunganInvitation.ProductImage = transInvitation.ProductImage;
        //    patunganInvitation.PatunganDescription = transInvitation.GroupDescription;
        //    patunganInvitation.BatasWaktuPelunasan = transInvitation.TanggalKirim.Subtract(new TimeSpan(Rules.PaymentDueDateHMin, 0, 0, 0));
        //    patunganInvitation.TotalPembayaran = transInvitation.GetTotalPrice();

        //    var transactionMemberGroupByEmail = transInvitation.TransactionMemberGroups.Where(b => b.Email == Email).ToList();
        //    if (transactionMemberGroupByEmail.Count > 0)
        //    {
        //        patunganInvitation.ToUserName = transactionMemberGroupByEmail[0].Name;
        //        var transactionMemberGroup = transInvitation.TransactionMemberGroups.ToList();
        //        for (int j = 0; j < transactionMemberGroup.Count; j++)
        //        {
        //            //var userMember = db.User.Find(member[j].UserId);
        //            string Name = transactionMemberGroup[j].Name;
        //            if (transactionMemberGroup[j].Email == Email)
        //                Name = "You";
        //            patunganInvitation.Status.Add(new PatunganInvitationStatusViewModel { TransactionMemberGroupsId = transactionMemberGroup[j].Id, UserId = "", Name = Name, Status = transactionMemberGroup[j].IsResponse ? transactionMemberGroup[j].IsAccept ? "Joined" : "Rejected" : "Waiting", Price = transactionMemberGroup[j].Price });
        //        }
        //    }

        //    return View(patunganInvitation);
        //}
        public ActionResult Patungan(string code="")
        {
            try
            {
                Guid codeGuid;
                if (Guid.TryParse(code, out codeGuid))
                {
                    var get = db.TransactionMemberGroup.Where(a => a.ShareCode == codeGuid).ToList();
                    if (get.Count > 0)
                    {
                        var transactionMemberGroup = get[0];
                        var transaction = transactionMemberGroup.transaction;
                        var transactionMemberGroups = transaction.TransactionMemberGroups.ToList();
                        if (!transactionMemberGroup.IsResponse)
                        {
                            if (DateTime.Now <= transactionMemberGroup.BatasWaktu)
                            {
                                if (Request.IsAuthenticated)
                                {
                                    var userName = User.Identity.GetUserName();
                                    if (userName != transactionMemberGroup.Email)
                                        return RedirectToAction("index", "home");
                                    else
                                    {
                                        var model = new InputPatunganViewModel()
                                        {
                                            Id = transactionMemberGroup.Id,
                                        };
                                        return View(model);
                                    }
                                }
                                else
                                {
                                    InputPatunganViewModel model = new InputPatunganViewModel();
                                    model.Id = transactionMemberGroup.Id;
                                    model.TransId = transaction.Id;
                                    model.TransStatus = transaction.Status;
                                    var u = db.User.Find(transaction.UserId);
                                    model.UserImage = u.Image;
                                    model.UserName = u.FirstName + ' ' + u.LastName;
                                    model.TransDate = transaction.TransDate;
                                    model.PatunganTitle = transaction.GroupTitle;
                                    model.ProductName = transaction.ProductName;
                                    model.ProductImage = transaction.ProductImage;
                                    model.PatunganDescription = transaction.GroupDescription;
                                    model.BatasWaktuPelunasan = transaction.TanggalKirim.Subtract(new TimeSpan(Rules.PaymentDueDateHMin, 0, 0, 0));
                                    model.TotalPembayaran = transaction.GetTotalPrice();

                                    model.ToUserName = transactionMemberGroup.Name;
                                    model.EmailLogin = transactionMemberGroup.Email;
                                    model.EmailRegister = transactionMemberGroup.Email;
                                    model.Firstname = transactionMemberGroup.Name;
                                    for (int j = 0; j < transactionMemberGroups.Count; j++)
                                    {
                                        string Name = transactionMemberGroups[j].Name;
                                        if (transactionMemberGroups[j].Email == transactionMemberGroup.Email)
                                            Name = "You";
                                        model.Status.Add(new PatunganInvitationStatusViewModel 
                                        { 
                                            TransactionMemberGroupsId = transactionMemberGroups[j].Id, 
                                            UserId = "", 
                                            Name = Name, 
                                            Status = transactionMemberGroups[j].IsResponse ? 
                                                transactionMemberGroups[j].IsAccept ? 
                                                "Joined" :
                                                "Rejected" : 
                                                "Waiting", 
                                            Price = transactionMemberGroups[j].Price 
                                        });
                                    }

                                    return View(model);
                                }
                            }
                            else
                            {
                                ViewBag.errorMessage = "Undangan patungan kamu telah kadarluasa, kamu tidak dapat melakukan respon.";
                                return View("Error");
                            }
                        }
                        else
                        {
                            ViewBag.errorMessage = "Kamu telah merespon undangan patungan.";
                            return View("Error");
                        }
                    }
                    else
                    {
                        ViewBag.errorMessage = "Code tidak ditemukan.";
                        return View("Error");    
                    }
                }
                else
                {
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

        //
        // POST: /Invitation/Patungan

        //[HttpPost]
        //public ActionResult Patungan(string tmgId, bool isAccept)
        //{
        //    string message = "";
        //    try
        //    {
        //        var tmg = db.TransactionMemberGroup.Find(tmgId);
        //        tmg.IsAccept = isAccept;
        //        tmg.IsResponse = true;

        //        var trans = tmg.transaction;

        //        var tmgList = trans.TransactionMemberGroups;

        //        string status = "Rejected";
        //        var tmgResponsed = tmgList.Where(a => a.IsResponse).ToList();
        //        if (tmg.IsAccept)
        //        {
        //            status = "Joined";

        //            if (tmgResponsed.Count == tmgList.Count)
        //            {
        //                if (tmgResponsed.Where(a => a.IsAccept).ToList().Count == tmgList.Count)
        //                {
        //                    trans.Status = TransactionStatus.UnconfirmPayment;
        //                    message = "Terima kasih telah join, sekarang kamu dan teman-teman kamu bisa melakukan pembayaran pada profile tab Payment Confirmation.";
        //                }
        //                else
        //                {
        //                    trans.Status = TransactionStatus.InvitationGroupPending;
        //                    message = "Terima kasih telah join, sekarang kamu tinggal menunggu konfirmasi kelanjutan dari pemilik transaksi. Kamu bisa melihat kembali detail undangan ini pada menu profile";
        //                }
        //            }
        //            else
        //            {
        //                message = "Terima kasih telah join, sekarang kamu tinggal menunggu teman yang lain untuk merespon. Kamu bisa melihat kembali detail undangan ini pada menu profile";
        //            }
        //        }
        //        else
        //        {
        //            if (tmgList.Where(a => a.IsResponse).ToList().Count == tmgList.Count)
        //            {
        //                trans.Status = TransactionStatus.InvitationGroupPending;
        //            }
        //            message = "Terima kasih telah reject invitation.";
        //            tmg.Price = 0;
        //        }
        //        var memberChanceAccept = tmgList.Where(a => (a.IsResponse && a.IsAccept) || !a.IsResponse).ToList();
        //        var totalPricePerPerson = trans.GetTotalPrice() / memberChanceAccept.Count;
        //        for (int i = 0; i < memberChanceAccept.Count; i++)
        //        {
        //            memberChanceAccept[i].Price = (float)Math.Ceiling(totalPricePerPerson);
        //        }


        //        db.SaveChanges();


        //        return Json(new { IsError = false, Message = message, Status = status, TotalPricePerPerson = totalPricePerPerson });
        //    }
        //    catch (Exception ex)
        //    {
        //        message = ex.Message;
        //    }

        //    return Json(new { IsError = true, Message = message });
        //}

        // POST: /Invitation/Login
        [HttpPost]
        public async Task<ActionResult> Patungan(InputPatunganViewModel model, string code = "", bool isAccept = false)
        {
            //return View();
            try
            {
                var transactionMemberGroup = db.TransactionMemberGroup.Find(model.Id);
                var transaction = transactionMemberGroup.transaction;
                var transactionMemberGroups = transaction.TransactionMemberGroups.ToList();

                model.Id = transactionMemberGroup.Id;
                model.TransId = transaction.Id;
                model.TransStatus = transaction.Status;
                var u = db.User.Find(transaction.UserId);
                model.UserImage = u.Image;
                model.UserName = u.FirstName + ' ' + u.LastName;
                model.TransDate = transaction.TransDate;
                model.PatunganTitle = transaction.GroupTitle;
                model.ProductName = transaction.ProductName;
                model.ProductImage = transaction.ProductImage;
                model.PatunganDescription = transaction.GroupDescription;
                model.BatasWaktuPelunasan = transaction.TanggalKirim.Subtract(new TimeSpan(Rules.PaymentDueDateHMin, 0, 0, 0));
                model.TotalPembayaran = transaction.GetTotalPrice();

                model.ToUserName = transactionMemberGroup.Name;
                for (int j = 0; j < transactionMemberGroups.Count; j++)
                {
                    string Name = transactionMemberGroups[j].Name;
                    if (transactionMemberGroups[j].Email == transactionMemberGroup.Email)
                        Name = "You";
                    model.Status.Add(new PatunganInvitationStatusViewModel
                    {
                        TransactionMemberGroupsId = transactionMemberGroups[j].Id,
                        UserId = "",
                        Name = Name,
                        Status = transactionMemberGroups[j].IsResponse ?
                            transactionMemberGroups[j].IsAccept ?
                            "Joined" :
                            "Rejected" :
                            "Waiting",
                        Price = transactionMemberGroups[j].Price
                    });
                }

                if (ModelState.IsValid)
                {
                    if (Request.IsAuthenticated)
                    {
                        //var transactionMemberGroup = db.TransactionMemberGroup.Find(model.Id);
                        if (transactionMemberGroup == null)
                        {
                            return HttpNotFound();
                        }

                        var userName = User.Identity.GetUserName();
                        if (userName != transactionMemberGroup.Email)
                        {
                            return View("Error");
                        }
                        else
                        {
                            var user = await UserManager.FindByEmailAsync(userName);
                            transactionMemberGroup.IsAccept = isAccept;
                            transactionMemberGroup.IsResponse = true;
                            transactionMemberGroup.UpdatedBy = user.UserId;
                            transactionMemberGroup.UserId = user.UserId;
                            transactionMemberGroup.UpdatedDate = DateTime.Now;
                            

                            string message = "";
                            var tmgResponsed = transactionMemberGroups.Where(a => a.IsResponse).ToList();
                            var memberChanceAccept = transactionMemberGroups.Where(a => (a.IsResponse && a.IsAccept) || !a.IsResponse).ToList();
                            var totalPricePerPerson = transaction.GetTotalPrice() / memberChanceAccept.Count;
                            if (transactionMemberGroup.IsAccept)
                            {
                                if (tmgResponsed.Count == transactionMemberGroups.Count)
                                {
                                    if (tmgResponsed.Where(a => a.IsAccept).ToList().Count == transactionMemberGroups.Count)
                                    {
                                        transaction.Status = TransactionStatus.UnconfirmPayment;
                                        message = "Terima kasih telah join, sekarang kamu dan teman-teman kamu bisa melakukan pembayaran sejumlah " + totalPricePerPerson.ToRupiah() + " pada menu profile tab Payment Confirmation.";
                                    }
                                    else
                                    {
                                        transaction.Status = TransactionStatus.InvitationGroupPending;
                                        message = "Terima kasih telah join, sekarang kamu tinggal menunggu konfirmasi kelanjutan dari pemilik transaksi. Kamu bisa melihat kembali detail undangan ini pada menu profile";
                                    }
                                }
                                else
                                {
                                    message = "Terima kasih telah join, sekarang kamu tinggal menunggu teman yang lain untuk merespon. Kamu bisa melihat kembali detail undangan ini pada menu profile";
                                }
                            }
                            else
                            {
                                if (transactionMemberGroups.Where(a => a.IsResponse).ToList().Count == transactionMemberGroups.Count)
                                {
                                    transaction.Status = TransactionStatus.InvitationGroupPending;
                                }
                                message = "Terima kasih telah reject invitation.";
                                transactionMemberGroup.Price = 0;
                                
                                for (int i = 0; i < memberChanceAccept.Count; i++)
                                {
                                    memberChanceAccept[i].Price = (float)Math.Ceiling(totalPricePerPerson);
                                }
                            }

                            await db.SaveChangesAsync();
                            ViewBag.successMessage = message;
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
                                                //var transactionMemberGroup = db.TransactionMemberGroup.Find(model.Id);
                                                if (transactionMemberGroup == null)
                                                    return HttpNotFound();
                                                else
                                                {
                                                    transactionMemberGroup.IsAccept = isAccept;
                                                    transactionMemberGroup.IsResponse = true;
                                                    transactionMemberGroup.UpdatedBy = user.UserId;
                                                    transactionMemberGroup.UserId = user.UserId;
                                                    transactionMemberGroup.UpdatedDate = DateTime.Now;

                                                    string message = "";
                                                    var tmgResponsed = transactionMemberGroups.Where(a => a.IsResponse).ToList();
                                                    var memberChanceAccept = transactionMemberGroups.Where(a => (a.IsResponse && a.IsAccept) || !a.IsResponse).ToList();
                                                    var totalPricePerPerson = transaction.GetTotalPrice() / memberChanceAccept.Count;
                                                    if (transactionMemberGroup.IsAccept)
                                                    {
                                                        if (tmgResponsed.Count == transactionMemberGroups.Count)
                                                        {
                                                            if (tmgResponsed.Where(a => a.IsAccept).ToList().Count == transactionMemberGroups.Count)
                                                            {
                                                                transaction.Status = TransactionStatus.UnconfirmPayment;
                                                                message = "Terima kasih telah join, sekarang kamu dan teman-teman kamu bisa melakukan pembayaran sejumlah " + totalPricePerPerson.ToRupiah() + " pada menu profile tab Payment Confirmation.";
                                                            }
                                                            else
                                                            {
                                                                transaction.Status = TransactionStatus.InvitationGroupPending;
                                                                message = "Terima kasih telah join, sekarang kamu tinggal menunggu konfirmasi kelanjutan dari pemilik transaksi. Kamu bisa melihat kembali detail undangan ini pada menu profile";
                                                            }
                                                        }
                                                        else
                                                        {
                                                            message = "Terima kasih telah join, sekarang kamu tinggal menunggu teman yang lain untuk merespon. Kamu bisa melihat kembali detail undangan ini pada menu profile";
                                                        }
                                                    }
                                                    else
                                                    {
                                                        if (transactionMemberGroups.Where(a => a.IsResponse).ToList().Count == transactionMemberGroups.Count)
                                                        {
                                                            transaction.Status = TransactionStatus.InvitationGroupPending;
                                                        }
                                                        message = "Terima kasih telah reject invitation.";
                                                        transactionMemberGroup.Price = 0;
                                                        
                                                        for (int i = 0; i < memberChanceAccept.Count; i++)
                                                        {
                                                            memberChanceAccept[i].Price = (float)Math.Ceiling(totalPricePerPerson);
                                                        }
                                                    }

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
                            else
                            {

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
                                    //var transactionMemberGroup = db.TransactionMemberGroup.Find(model.Id);
                                    if (transactionMemberGroup == null)
                                        return HttpNotFound();
                                    else
                                    {
                                        transactionMemberGroup.IsAccept = isAccept;
                                        transactionMemberGroup.IsResponse = true;
                                        transactionMemberGroup.UpdatedBy = user.UserId;
                                        transactionMemberGroup.UserId = userDb.Id;
                                        transactionMemberGroup.UpdatedDate = DateTime.Now;

                                        string message = "";
                                        var tmgResponsed = transactionMemberGroups.Where(a => a.IsResponse).ToList();
                                        if (transactionMemberGroup.IsAccept)
                                        {
                                            if (tmgResponsed.Count == transactionMemberGroups.Count)
                                            {
                                                if (tmgResponsed.Where(a => a.IsAccept).ToList().Count == transactionMemberGroups.Count)
                                                {
                                                    transaction.Status = TransactionStatus.UnconfirmPayment;
                                                    message = "Terima kasih telah join, sekarang kamu dan teman-teman kamu bisa melakukan pembayaran pada profile tab Payment Confirmation.";
                                                }
                                                else
                                                {
                                                    transaction.Status = TransactionStatus.InvitationGroupPending;
                                                    message = "Terima kasih telah join, sekarang kamu tinggal menunggu konfirmasi kelanjutan dari pemilik transaksi. Kamu bisa melihat kembali detail undangan ini pada menu profile";
                                                }
                                            }
                                            else
                                            {
                                                message = "Terima kasih telah join, sekarang kamu tinggal menunggu teman yang lain untuk merespon. Kamu bisa melihat kembali detail undangan ini pada menu profile";
                                            }
                                        }
                                        else
                                        {
                                            if (transactionMemberGroups.Where(a => a.IsResponse).ToList().Count == transactionMemberGroups.Count)
                                            {
                                                transaction.Status = TransactionStatus.InvitationGroupPending;
                                            }
                                            message = "Terima kasih telah reject invitation.";
                                            transactionMemberGroup.Price = 0;
                                            var memberChanceAccept = transactionMemberGroups.Where(a => (a.IsResponse && a.IsAccept) || !a.IsResponse).ToList();
                                            var totalPricePerPerson = transaction.GetTotalPrice() / memberChanceAccept.Count;
                                            for (int i = 0; i < memberChanceAccept.Count; i++)
                                            {
                                                memberChanceAccept[i].Price = (float)Math.Ceiling(totalPricePerPerson);
                                            }
                                        }

                                        await db.SaveChangesAsync();
                                        ViewBag.successMessage = message;
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


        [HttpPost]
        [AllowAnonymous]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> Login(LoginViewModel model)
        {
            string message = "";

            if (!ModelState.IsValid)
            {
                //return Json(new { HtmlString = RenderPartialViewToString("login", model) });
                message = "Invalid Login Attempt";
                return Json(new { IsError = true, Message = message });
            }

            //// This doen't count login failures towards lockout only two factor authentication
            //// To enable password failures to trigger lockout, change to shouldLockout: true
            //// Require the user to have a confirmed email before they can log on.
            //var user = await UserManager.FindByNameAsync(model.Email);
            //if (user != null)
            //{
            //    if (!await UserManager.IsEmailConfirmedAsync(user.Id))
            //    {
            //        ModelState.AddModelError("", "You must have a confirmed email to log on.");
            //        //ViewBag.errorMessage = "You must have a confirmed email to log on.";
            //        return Json(new { HtmlString = RenderPartialViewToString("login", model) });
            //    }
            //}
            //returnUrl = returnUrl.Contains("ConfirmEmail") ? "" : returnUrl;
            var result = await SignInManager.PasswordSignInAsync(model.Email, model.Password, false, shouldLockout: false);
            switch (result)
            {
                case SignInStatus.Success:
                    //return json(new { redirectto = (string.isnullorempty(returnurl) ? url.action("index", "home") : returnurl) });
                    var tmg = db.TransactionMemberGroup.Where(a => a.Email == model.Email).ToList();
                    string tmgId = "";
                    if (tmg.Count > 0)
                        tmgId = tmg[0].Id;
                    return Json(new { IsError = false, Message = message, TmgId = tmgId });
                case SignInStatus.LockedOut:
                    //return view("lockout");
                    message = "LockedOut";
                    return Json(new { IsError = true, Message = message });
                case SignInStatus.RequiresVerification:
                    //return redirecttoaction("sendcode", new { returnurl = returnurl });
                    message = "Requires Verification";
                    return Json(new { IsError = true, Message = message });
                case SignInStatus.Failure:
                default:
                    //ModelState.AddModelError("", "invalid login attempt.");
                    //return json(new { htmlstring = renderpartialviewtostring("login", model) });
                    message = "Invalid Login Attempt";
                    return Json(new { IsError = true, Message = message });
            }
        }

        //
        // POST: /Invitation/Register
        [HttpPost]
        [AllowAnonymous]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> Register(RegisterViewModel model)
        {
            string message = "";
            if (ModelState.IsValid)
            {
                var userDb = new Entities.User();
                userDb.Id = userDb.GenerateId("U");
                userDb.LastName = model.LastName;
                userDb.FirstName = model.FirstName;
                userDb.Email = model.Email;
                userDb.PhoneNumber = model.Phone;
                userDb.BirthDate = DateTime.Now;
                userDb.CreatedBy = model.Email;
                userDb.CreatedDate = DateTime.Now;
                userDb.UpdatedBy = model.Email;
                userDb.UpdatedDate = DateTime.Now;
                userDb.Gender = 0;
                userDb.VirtualMoney = 0;
                db.User.Add(userDb);
                var tmg = db.TransactionMemberGroup.ToList().Where(a => a.Email == model.Email).ToList();
                if (tmg.Count > 0)
                    tmg[0].UserId = userDb.Id;
                db.SaveChanges();
                var user = new ApplicationUser
                {
                    UserName = model.Email,
                    Email = model.Email,
                    PhoneNumber = model.Phone,
                    UserId = userDb.Id
                };
                var result = await UserManager.CreateAsync(user, model.Password);
                if (result.Succeeded)
                {

                    var code = await UserManager.GenerateEmailConfirmationTokenAsync(user.Id);
                    UserManager.AddToRoles(user.Id, "User");
                    var callbackUrl = Url.Action("ConfirmEmail", "Account", new { userId = user.Id, code = code }, protocol: Request.Url.Scheme);
                    string body;
                    //Read template file from the App_Data folder
                    using (var sr = new StreamReader(Server.MapPath("\\App_Data\\Templates\\") + "confirmemail.txt"))
                    {
                        body = sr.ReadToEnd();
                    }
                    //var pathLogo = Server.MapPath("\\Images\\") + "brand.png";
                    //var byteLogo=System.IO.File.ReadAllBytes(pathLogo);
                    string messageBody = string.Format(body, userDb.FirstName, callbackUrl, userDb.Email, model.Password);
                    //string messageBody="";
                    //var c=new ConfirmEmailTemplateViewModel{
                    //    Name=userDb.FirstName,
                    //    CallbackUrl=callbackUrl,
                    //    Email=userDb.Email,
                    //    Password=model.Password
                    //};
                    //messageBody = string.Format(DownloadHTMLContent("templateemail", "confirmemail", null), userDb.FirstName, callbackUrl, userDb.Email, model.Password); 
                    //await UserManager.SendEmailAsync(user.Id, "Confirm your account", "Hi "+userDb.FirstName+" "+userDb.LastName+",</br></br>"+"Please confirm your account by clicking this link: <a href=\"" + callbackUrl + "\">link</a>");
                    await UserManager.SendEmailAsync(user.Id, "Confirm your account", messageBody);

                    ViewBag.Link = callbackUrl;

                    return Json(new { IsError = false, Message = message, TmgId = tmg[0].Id });
                }
                for (int i = 0; i < result.Errors.ToList().Count; i++)
                {
                    message += result.Errors.ToList()[i];
                }

                return Json(new { IsError = true, Message = message });
            }

            return Json(new { IsError = false, Message = message });
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
