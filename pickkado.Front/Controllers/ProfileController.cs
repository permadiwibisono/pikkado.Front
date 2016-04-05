using pickkado.Entities;
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

namespace pickkado.Front.Controllers
{
    public class ProfileController : Controller
    {
        public ProfileController()
        {
        }

        public ProfileController(ApplicationUserManager userManager, ApplicationSignInManager signInManager)
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

        private Db.PickkadoDBContext db = new Db.PickkadoDBContext();
        //
        // GET: /Profile/PaymentConfirm

        public async Task<ActionResult> Index(string menu)
        {
            if (string.IsNullOrEmpty(menu))
            {
                menu = "unconfirmedpurchase";
            }
            ViewBag.Menu = menu;
            //ViewBag.TransactionList = db.Transaction.ToList();
            var userLogin = await UserManager.FindByNameAsync(User.Identity.GetUserName());
            List<Transaction> transactionList = db.Transaction.Where(e => !e.IsGroup && e.UserId == userLogin.UserId).ToList();
            foreach (var item in db.TransactionMemberGroup.ToList())
            {
                if (item.transaction.IsGroup && item.Email == userLogin.Email)
                {
                    if (item.transaction.Status == TransactionStatus.UnconfirmPayment)
                    {
                        var paymentCheckList = item.transaction.TransactionPayments.Where(e => e.UserId == userLogin.UserId).OrderByDescending(e=>e.UpdatedDate).ToList();
                        if (paymentCheckList.Count > 0)
                        {
                            if (paymentCheckList.Where(e => string.IsNullOrEmpty(e.StatusPembayaran)).Count() > 0)
                                item.transaction.Status = TransactionStatus.PaymentChecking;
                            else if (paymentCheckList.Where(e => e.StatusPembayaran == TransactionPaymentStatus.UnderPayment || e.StatusPembayaran == TransactionPaymentStatus.Valid).Sum(e => e.TotalDiBayar) == item.Price)
                            {
                                item.transaction.Status = TransactionStatus.WaitingForYourFriendPayment;
                            }
                            else
                            {
                                var status = paymentCheckList[0].StatusPembayaran;
                                switch (status)
                                {
                                    case TransactionPaymentStatus.NotValid: item.transaction.Status = TransactionStatus.NotValid; break;
                                    case TransactionPaymentStatus.UnderPayment: item.transaction.Status = TransactionStatus.UnderPayment; break;
                                    default: item.transaction.Status = TransactionStatus.UnderPayment; break;
                                }
                            }
                        }
                    }
                    transactionList.Add(item.transaction);
                }
            }
            //TempData["TransactionList"] = db.Transaction.ToList();
            TempData["TransactionList"] = transactionList;
            TempData["NotificationList"] = db.Notification.ToList();

            //var userLogin = await UserManager.FindByNameAsync(User.Identity.Name);

            List<PatunganInvitationViewModel> ListPatunganInvitation = new List<PatunganInvitationViewModel>();
            //var transInvitation = db.Transaction.Where(a => a.Status == TransactionStatus.InvitationGroup).ToList();
            var transInvitation = transactionList.Where(e => e.Status == TransactionStatus.InvitationGroup).ToList();
            for (int i = 0; i < transInvitation.Count; i++)
            {
                PatunganInvitationViewModel patunganInvitation = new PatunganInvitationViewModel();
                patunganInvitation.TransId = transInvitation[i].Id;
                patunganInvitation.TransStatus = transInvitation[i].Status;
                var u = db.User.Find(transInvitation[i].UserId);
                patunganInvitation.UserImage = u.Image;
                patunganInvitation.UserName = u.FirstName + ' ' + u.LastName;
                patunganInvitation.TransDate = transInvitation[i].TransDate;
                patunganInvitation.PatunganTitle = "";
                patunganInvitation.ProductName = transInvitation[i].ProductName;
                patunganInvitation.ProductImage = transInvitation[i].ProductImage;
                patunganInvitation.PatunganDescription = "";
                patunganInvitation.BatasWaktuPelunasan = transInvitation[i].TanggalKirim.Subtract(new TimeSpan(Rules.PaymentDueDateHMin, 0, 0, 0));
                patunganInvitation.TotalPembayaran = transInvitation[i].GetTotalPrice();

                //if (transInvitation[i].TransactionMemberGroups.Where(b => b.UserId == userLogin.UserId).ToList().Count > 0)
                if (transInvitation[i].TransactionMemberGroups.Where(b => b.Email == userLogin.Email).ToList().Count > 0)
                {
                    //var member = db.TransactionMemberGroup.ToList();
                    var member = transInvitation[i].TransactionMemberGroups.ToList();
                    for (int j = 0; j < member.Count; j++)
                    {
                        var userMember = db.User.Find(member[j].UserId);
                        patunganInvitation.Status.Add(new PatunganInvitationStatusViewModel {
                            TransactionMemberGroupsId = member[j].Id, 
                            UserId = member[j].UserId, 
                            Name = member[j].Name, 
                            Email=member[j].Email,
                            Status = member[j].IsResponse ? member[j].IsAccept ? "Joined" : "Rejected" : "Waiting",
                            Price = member[j].Price });
                    }
                    ListPatunganInvitation.Add(patunganInvitation);
                }
            }

           // var TransactionGiftcardMessages = db.TransactionGiftcardMessage.Where(a => a.UserId == userLogin.UserId && string.IsNullOrEmpty(a.Message)).ToList();
            var TransactionGiftcardMessages = db.TransactionGiftcardMessage.Where(a => a.Email == userLogin.Email && string.IsNullOrEmpty(a.Message)).ToList();
            List<InvitationGiftCardViewModel> ListGiftCardInvitation = new List<InvitationGiftCardViewModel>();
            for (int i = 0; i < TransactionGiftcardMessages.Count; i++)
            {
                InvitationGiftCardViewModel InvitationGiftCard = new InvitationGiftCardViewModel();
                var trans = db.Transaction.Find(TransactionGiftcardMessages[i].TransactionId);
                var user = db.User.Find(trans.UserId);
                InvitationGiftCard.UserImage = user.Image;
                InvitationGiftCard.UserName = user.FirstName + ' ' + user.LastName;
                InvitationGiftCard.TransDate = trans.TransDate;
                InvitationGiftCard.TransactionGiftcardMessage = TransactionGiftcardMessages[i];
                ListGiftCardInvitation.Add(InvitationGiftCard);
            }

            TempData["UserLogin"] = db.User.Find(userLogin.UserId);
            TempData["PatunganInvitationList"] = ListPatunganInvitation;
            TempData["GiftCardInvitationList"] = ListGiftCardInvitation;
            TempData["ChangePasswordModel"] = new pickkado.Front.Models.AccountBindingModel.ChangePasswordBindingModel();
            return View();
        }

        [HttpPost]
        [AllowAnonymous]
        public ActionResult Index(string transId, string status)
        {
            var transaction = db.Transaction.Where(a => a.Id == transId).ToList();
            if(status=="true")
                transaction[0].Status = TransactionStatus.CompletedUser;
            else
                transaction[0].Status = status;

            db.SaveChanges();

            //ViewBag.TransactionList = db.Transaction.ToList();
            TempData["TransactionList"] = db.Transaction.ToList();
            TempData["NotificationList"] = db.Notification.ToList();
            string returnUrl = Request.UrlReferrer.AbsoluteUri;

            //return View();
            //return PartialView();
            return Redirect(@returnUrl);
        }

        [HttpPost]
        public async Task<ActionResult> Invitation(string tmgId, bool isAccept)
        {
            string message = "";
            try
            {
                var userLogin = await UserManager.FindByNameAsync(User.Identity.Name);
                var tmg = db.TransactionMemberGroup.Find(tmgId);
                if (tmg.UserId==userLogin.UserId||tmg.Email == userLogin.Email)
                {
                    tmg.IsAccept = isAccept;
                    tmg.IsResponse = true;
                    tmg.UserId = userLogin.UserId;
                    var trans = db.Transaction.Find(tmg.TransactionId);

                    var tmgList = trans.TransactionMemberGroups;

                    string status = "Rejected";
                    var tmgResponsed = tmgList.Where(a => a.IsResponse).ToList();
                    if (tmg.IsAccept)
                    {
                        status = "Joined";

                        if (tmgResponsed.Count == tmgList.Count)
                        {
                            if (tmgResponsed.Where(a => a.IsAccept).ToList().Count == tmgList.Count)
                            {
                                trans.Status = TransactionStatus.UnconfirmPayment;
                                message = "Terima kasih telah join, sekarang kamu dan teman-teman kamu bisa melakukan pembayaran di tab Payment Confirmation.";
                            }
                            else
                            {
                                trans.Status = TransactionStatus.InvitationGroupPending;
                                message = "Terima kasih telah join, sekarang kamu tinggal menunggu konfirmasi kelanjutan dari pemilik transaksi.";
                            }
                        }
                        else
                        {
                            message = "Terima kasih telah join, sekarang kamu tinggal menunggu teman yang lain untuk merespon.";
                        }
                    }
                    else
                    {
                        if (tmgList.Where(a => a.IsResponse).ToList().Count == tmgList.Count)
                        {
                            trans.Status = TransactionStatus.InvitationGroupPending;
                        }
                        message = "Terima kasih telah reject invitation.";
                        tmg.Price = 0;
                    }
                    var memberChanceAccept = tmgList.Where(a => (a.IsResponse && a.IsAccept) || !a.IsResponse).ToList();
                    var totalPricePerPerson = trans.GetTotalPrice() / memberChanceAccept.Count;
                    for (int i = 0; i < memberChanceAccept.Count; i++)
                    {
                        memberChanceAccept[i].Price = (float)Math.Ceiling(totalPricePerPerson);
                    }


                    db.SaveChanges();


                    return Json(new { IsError = false, Message = message, Status = status, TotalPricePerPerson = totalPricePerPerson });
                }
                else
                    message = "Sorry, Unauthorized System!";
            }
            catch (Exception ex)
            {
                message = ex.Message;
            }
            //return View();
            //return Redirect(@"profile?menu=unconfirmedpurchase");
            //return RedirectToAction("index", "profile");
            return Json(new { IsError = true, Message = message });
        }

        [HttpPost]
        public async Task<ActionResult> InvitationContinue(string transId, bool isContinue)
        {
            string message = "";
            try
            {
                var userLogin = await UserManager.FindByNameAsync(User.Identity.Name);
                var trans = db.Transaction.Find(transId);

                if (isContinue)
                {
                    trans.Status = TransactionStatus.UnconfirmPayment;
                    message = "Terima kasih, sekarang kamu dan teman-teman kamu bisa melakukan pembayaran di tab Payment Confirmation.";
                }
                else
                {
                    trans.Status = TransactionStatus.Cancel;
                    message = "Terima kasih, sekarang transaksi ini akan masuk ke history purchase kamu";
                }
                db.SaveChanges();
                return Json(new { IsError = false, Message = message });
            }
            catch (Exception ex)
            {
                message = ex.Message;
            }
            //return View();
            //return Redirect(@"profile?menu=unconfirmedpurchase");
            //return RedirectToAction("index", "profile");
            return Json(new { IsError = true, Message = message });
        }

        [HttpPost]
        public async Task<ActionResult> InvitationGiftCard(string tgmId, string giftcardmessage)
        {
            var userLogin = await UserManager.FindByNameAsync(User.Identity.Name);
            string message = "";
            bool isError = false;
            try
            {
                
                var tgm = db.TransactionGiftcardMessage.Find(tgmId);
                if (tgm.UserId != userLogin.UserId && tgm.Email != userLogin.Email)
                {
                    message = "Sorry, unauthorized system!";
                    isError = true;
                    return Json(new { IsError = isError, Message = message });                    
                }
                if (string.IsNullOrEmpty(giftcardmessage))
                {
                    message = "Mohon untuk menuliskan ucapan terlebih dahulu";
                    isError = true;
                }
                else
                {
                    tgm.UserId = userLogin.UserId;
                    tgm.Message = giftcardmessage;
                    db.SaveChanges();
                    message = "Terima kasih sudah menuliskan ucapan";
                }

                return Json(new { IsError = isError, Message = message });
            }
            catch (Exception ex)
            {
                message = ex.Message;
            }

            return View();
        }

        public ActionResult Setting()
        {
            return View();
        }

        [HttpPost]
        //public async Task<ActionResult> ChangePassword(pickkado.Front.Models.AccountBindingModel.ChangePasswordBindingModel model)
        public async Task<ActionResult> ChangePassword(pickkado.Front.Models.AccountBindingModel.ChangePasswordBindingModel modelKu)
        {
            //return View();
            string message = "Success";
            try
            {
                if (!ModelState.IsValid)
                {
                    //return BadRequest(ModelState);
                    message = "Error";
                    return Json(new { IsError = true, Message = message });
                    //return View();
                    //return RedirectToAction("index", "profile");
                    //return RedirectToAction("index?menu=setting", "profile");
                }
                string userId = User.Identity.GetUserId();
                IdentityResult result = await UserManager.ChangePasswordAsync(userId, modelKu.OldPassword, modelKu.NewPassword);

                if (!result.Succeeded)
                {
                    //return GetErrorResult(result);
                    
                    return Json(new { IsError = true, Message = result.Errors });
                    //return View();
                    //return RedirectToAction("index", "profile");
                    //return RedirectToAction("index?menu=setting", "profile");
                }
                //return View();
                return Json(new { IsError = false, Message = message });
                //return RedirectToAction("index", "profile");
                //return RedirectToAction("index?menu=setting", "profile");
            }
            catch (Exception ex)
            {
                //return View();
                return Json(new { IsError = true, Message = ex.Message });
                //return RedirectToAction("index", "profile");
                //return RedirectToAction("index?menu=setting", "profile");
            }
            
            
        }

        [HttpPost]
        public ActionResult ChangeUserDetail(User user)
        { 
            string message = "Success";
            try
            {
                if (!ModelState.IsValid)
                {
                    message = "Error";
                    return Json(new { IsError = true, Message = message });
                }
                var u = db.User.Find(user.Id);
                u.BirthPlace = user.BirthPlace;
                u.BirthDate = user.BirthDate;
                u.Gender = user.Gender;
                u.PhoneNumber = user.PhoneNumber;
                //if (image != null && image.ContentLength > 0)
                //{
                //    if (image.ContentType == "image/png" || image.ContentType == "image/jpeg" || image.ContentType == "image/gif")
                //    {
                //        if (image.ContentLength < 2048000)
                //        {
                //            using (var reader = new System.IO.BinaryReader(image.InputStream))
                //            {
                //                u.Image = reader.ReadBytes(image.ContentLength);
                //            }
                //        }
                //        else
                //        {
                //            message = "Max size of image is 2MB";
                //            return Json(new { IsError = true, Message = message });
                //        }
                //    }
                //    else
                //    {
                //        message = "Only .png, .jpg and .gif extension allowed";
                //        return Json(new { IsError = true, Message = message });
                //    }
                //}
                u.UpdatedBy = user.Email;
                u.UpdatedDate = DateTime.Now;

                db.SaveChanges();
                return Json(new { IsError = false, Message = message });
            }
            catch (Exception ex)
            {
                return Json(new { IsError = true, Message = ex.Message });
            }


        }
    }
}
