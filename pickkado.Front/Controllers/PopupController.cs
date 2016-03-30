using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using pickkado.Front.Models;
using System.IO;
using System.ComponentModel.DataAnnotations;
using System.Collections;
using pickkado.Entities;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.Owin;
using Microsoft.Owin.Security;
using System.Threading.Tasks;
using pickkado.Front.Db;

namespace pickkado.Front.Controllers
{
    public class PopupController : Controller
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
        public PopupController()
        {
        }

        public PopupController(ApplicationUserManager userManager, ApplicationSignInManager signInManager)
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
        // GET: /Popup/

        public ActionResult Index()
        {
            return View();
        }

        //
        // GET: /Popup/PaymentConfirm
        [AuthorizeCustom(Roles="User")]
        [HttpGet]
        public async Task<ActionResult> PaymentConfirm(string transId)
        {
            var user = await UserManager.FindByNameAsync(User.Identity.Name);
            PaymentConfirmViewModel model = new PaymentConfirmViewModel();
            var transaction = db.Transaction.Find(transId);
            double totalHargaTransaksi = 0;
            double totalHargaPernahDibayar=0;
            double totalTagihan=0;
            if (transaction.IsGroup)
            {
                var transactionPaymentList = transaction.TransactionPayments.Where(e => e.UserId == user.UserId).ToList();
                var transactionMemberList = transaction.TransactionMemberGroups.Where(e => e.UserId == user.UserId).ToList();
                if (transactionMemberList.Count == 0)
                {
                    return RedirectToAction("unauthorized", "error");

                }
                else 
                {
                    totalHargaTransaksi = transactionMemberList[0].Price;
                    totalHargaPernahDibayar = transactionPaymentList.Count > 0 ? transactionPaymentList
                    .Where(a => a.StatusPembayaran == TransactionPaymentStatus.Valid || a.StatusPembayaran == TransactionPaymentStatus.UnderPayment)
                    .Sum(a => a.TotalDiBayar) : 0;
                    totalTagihan = totalHargaTransaksi - totalHargaPernahDibayar;
                }
            }
            else
            {
                var transactionPaymentList = transaction.TransactionPayments.ToList();

                if (transaction.UserId != user.UserId)
                {
                    return RedirectToAction("unauthorized", "error");
                }

                 totalHargaTransaksi = transaction.GetTotalPrice();

                 totalHargaPernahDibayar = transactionPaymentList.Count > 0 ? transactionPaymentList
                    .Where(a=>a.StatusPembayaran==TransactionPaymentStatus.Valid||a.StatusPembayaran==TransactionPaymentStatus.UnderPayment)
                    .Sum(a => a.TotalDiBayar) : 0;
                 totalTagihan = totalHargaTransaksi - totalHargaPernahDibayar;

                
            }
            model.IsUnderpayment = true;
            model.TransactionId = transId;
            model.TotalTagihan = totalTagihan;
            var RekeningUser = db.NoRekening.Where(a => a.UserId == user.UserId).ToList(); // nanti diganti dari userlogin.userid
            model._dariRekening = new List<DariRekening>();
            model._dariRekening.Add(new DariRekening { Id = "-1", Name = "Dari Rekening*" });
            for (int i = 0; i < RekeningUser.Count; i++)
            {
                model._dariRekening.Add(new DariRekening { Id = RekeningUser[i].Id, Name = RekeningUser[i].AtasNama + " - " + RekeningUser[i].NomorRekening + " - " + RekeningUser[i].Bank + " - " + RekeningUser[i].CabangBank });
            }
            model._dariRekening.Add(new DariRekening { Id = "0", Name = "Rekening Baru" }); 
            return View(model);
        }

        //
        // POST: /Popup/PaymentConfirm
        [HttpPost]
        [AuthorizeCustom(Roles="User")]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> PaymentConfirm(PaymentConfirmViewModel model, string returnUrl )
        {
            bool isValid = true;
            var user = await UserManager.FindByNameAsync(User.Identity.Name);
            var transaction=db.Transaction.Find(model.TransactionId);
            //var transactionPaymentList = transaction.TransactionPayments.ToList();

            if (transaction.IsGroup)
            {
                var transactionMemberList = transaction.TransactionMemberGroups.Where(e => e.UserId == user.UserId).ToList();
                if (transactionMemberList.Count == 0)
                {
                    return Json(new { Alert = "Unauthorized System!" });
                }
            }
            else
            {
                if (transaction.UserId != user.UserId)
                {
                    return Json(new { Alert = "Unauthorized System!" });
                }
            }
            if (model.DariRekeningId == "-1")
            {
                ModelState.AddModelError("DariRekening", "Field DariRekening Required");
                isValid = false;
            }
            if (model.DariRekeningId == "0")
            {
                if (string.IsNullOrEmpty(model.NamaBank) || string.IsNullOrEmpty(model.NamaPemilikRekening)
                    || string.IsNullOrEmpty(model.NomorRekening) || string.IsNullOrEmpty(model.CabangRekening))
                {
                    ModelState.AddModelError("RekeningBaru", "All Field Rekening Baru Required");
                    isValid = false;
                }
            }
            if (model.RekeningTujuanId == "-1")
            {
                ModelState.AddModelError("RekeningTujuan", "Field RekeningTujuan Required");
                isValid = false;
            }
            if (model.JumlahPembayaran == 0)
            {
                ModelState.AddModelError("JumlahPembayaran", "Jumlah Pembayaran must be greater than 0");
                isValid = false;
            }
            if (isValid)
            {
                // get list transaction
                //var a = db.Transaction.ToList();

                // get list table child (transactionpayment)
                //var payment = a[0].TransactionPayments.ToList();

                //file1= file1 ?? Request.Files["file"];
                if (ModelState.IsValid)
                {
                    if (model.image != null && model.image.ContentLength > 0)
                    {
                        if (model.image.ContentType == "image/png" || model.image.ContentType == "image/jpeg" || model.image.ContentType == "image/gif")
                        {
                            if (model.image.ContentLength < 2048000)
                            {
                                using (var reader = new System.IO.BinaryReader(model.image.InputStream))
                                {
                                    model.BuktiPembayaran = reader.ReadBytes(model.image.ContentLength);
                                }
                            }
                            else
                            {
                                ModelState.AddModelError("imagesize", "Max size of image is 2MB");
                                return Json(new { HtmlString = RenderPartialViewToString("paymentconfirm", model) });
                            }
                        }
                        else
                        {
                            ModelState.AddModelError("imageextension", "Only .png, .jpg and .gif extension allowed");
                            return Json(new { HtmlString = RenderPartialViewToString("paymentconfirm", model) });
                        }
                    }
                    
                    var rekeningUser = db.NoRekening.Where(a => a.Id == model.DariRekeningId).ToList();
                    string namaRekening = model.DariRekeningId == "0" ? model.NamaPemilikRekening : rekeningUser[0].AtasNama;
                    string noRekening = model.DariRekeningId == "0" ? model.NomorRekening : rekeningUser[0].NomorRekening;
                    string namaBank = model.DariRekeningId == "0" ? model.NamaBank : rekeningUser[0].Bank;
                    string cabangBank = model.DariRekeningId == "0" ? model.CabangRekening : rekeningUser[0].CabangBank;

                    var rekeningPickkado = db.NoRekeningPickkado.Where(a => a.Id == model.RekeningTujuanId).ToList();
                    string namaRekeningTujuan = rekeningPickkado[0].AtasNama;
                    string noRekeningTujuan = rekeningPickkado[0].NomorRekening;
                    string namaBankTujuan = rekeningPickkado[0].Bank;
                    string cabangBankTujuan = rekeningPickkado[0].CabangBank;

                    TransactionPayment tp = new TransactionPayment
                    {
                        TransactionId = model.TransactionId,
                        PaymentType = "Transfer",
                        UserId=user.UserId,
                        TanggalPembayaran = model.TanggalPembayaran,
                        NamaRekening = namaRekening,
                        NoRekening = noRekening,
                        NamaBank = namaBank,
                        CabangBank = cabangBank,
                        NoStrukPembayaran = model.NoStrukPembayaran,
                        StatusPembayaran = "", // seperti ini : lunas / belum lunas ?
                        NamaRekeningTujuan = namaRekeningTujuan,
                        NoRekeningTujuan = noRekeningTujuan,
                        NamaBankTujuan = namaBankTujuan,
                        CabangBankTujuan = cabangBankTujuan,
                        TotalDiBayar = model.JumlahPembayaran,
                        Remarks = "- User: " +model.Remarks,
                        BuktiPembayaran = model.BuktiPembayaran,
                        CreatedBy = user.UserId,
                        UpdatedBy = user.UserId,
                        CreatedDate = DateTime.Now,
                        UpdatedDate = DateTime.Now,
                    };
                    tp.Id = tp.GenerateId("TP");
                    db.TransactionPayment.Add(tp);

                    // save no rekening kalo rekening baru.
                    if (model.DariRekeningId == "0")
                    {
                        NoRekening nr = new NoRekening { 
                            UserId = user.UserId, // nanti diganti dari userlogin.userid
                            AtasNama = model.NamaPemilikRekening,
                            NomorRekening = model.NomorRekening,
                            Bank = model.NamaBank,
                            CabangBank = model.CabangRekening,
                            CreatedBy = user.UserId,
                            UpdatedBy = user.UserId,
                            CreatedDate = DateTime.Now,
                            UpdatedDate = DateTime.Now
                        };
                        nr.Id = nr.GenerateId("NR");
                        db.NoRekening.Add(nr);   
                    }


                    //var transaction = db.Transaction.Where(a => a.Id == model.TransactionId).ToList();
                    //transaction[0].Status = TransactionStatus.PaymentChecking;
                    if(!transaction.IsGroup)
                    {
                        transaction.Status=TransactionStatus.PaymentChecking;
                    }

                    Notification nt = new Notification
                    {
                        UserId = user.UserId,
                        Type = "TransactionStatus",
                        SenderId = "Pickkado",
                        SenderName = "Pickkado",
                        Description = "Your transaction payment with id 'TR2016020817032188' is being checked by pickkado. Please be patient. It takes maximum 1x24 hours.",
                        Thumbnail = null,
                        Link = "Link",
                        NotificationDate = DateTime.Now,
                        Title = "Payment checking",
                        IsDistributed = true,
                        IsSeen = false,
                        CreatedBy = "Admin",
                        CreatedDate = DateTime.Now,
                        UpdatedBy = "Admin",
                        UpdatedDate = DateTime.Now
                    };
                    nt.Id = nt.GenerateId("NT");
                    db.Notification.Add(nt);

                    db.SaveChanges();

                    return Json(new { redirectTo = returnUrl });
                }
            }
            else
            {
                var RekeningUser = db.NoRekening.Where(a => a.UserId == user.UserId).ToList(); // nanti diganti dari userlogin.userid
                model._dariRekening = new List<DariRekening>();
                model._dariRekening.Add(new DariRekening { Id = "-1", Name = "Dari Rekening*" });
                for (int i = 0; i < RekeningUser.Count; i++)
                {
                    model._dariRekening.Add(new DariRekening { Id = RekeningUser[i].Id, Name = RekeningUser[i].AtasNama + " - " + RekeningUser[i].NomorRekening + " - " + RekeningUser[i].Bank + " - " + RekeningUser[i].CabangBank });
                }
                model._dariRekening.Add(new DariRekening { Id = "0", Name = "Rekening Baru" }); 
                return Json(new { HtmlString = RenderPartialViewToString("paymentconfirm", model) });
            }

            return Json(new { HtmlString = RenderPartialViewToString("paymentconfirm", model) });
        }

        //
        // GET: /Popup/DetailPatungan
        [HttpGet]
        public ActionResult DetailPatungan(string transId)
        {
            DetailPatunganViewModel model = new DetailPatunganViewModel();
            var trans = db.Transaction.Find(transId);
            var transPayment = trans.TransactionPayments.ToList();
            var validPayment = transPayment.Where(a => a.StatusPembayaran == TransactionPaymentStatus.Valid).ToList();
            var totalPembayaran = validPayment.Sum(a => a.TotalDiBayar);
            var transMemberGroup = trans.TransactionMemberGroups.Where(a => a.IsAccept).ToList();

            model.BatasWaktuPelunasan = trans.TanggalKirim.Subtract(new TimeSpan(Rules.PaymentDueDateHMin, 0, 0, 0));
            model.TotalPembayaran = trans.GetTotalPrice();
            model.PembayaranYangTerkumpul = totalPembayaran;
            for (int i = 0; i < transMemberGroup.Count; i++)
            {
                model.StatusPembayaran.Add(
                    new StatusPembayaranViewModel
                    {
                        Name = db.User.Find(transMemberGroup[i].UserId).FirstName + ' ' + db.User.Find(transMemberGroup[i].UserId).LastName,
                        JumlahPembayaran = transMemberGroup[i].Price,
                        Status = transPayment.Where(a => a.UserId == transMemberGroup[i].UserId).ToList().Count > 0 ? transPayment.Where(a => a.UserId == transMemberGroup[i].UserId).ToList().Last().StatusPembayaran == TransactionPaymentStatus.Valid ? "Sudah diterima" : transPayment.Where(a => a.UserId == transMemberGroup[i].UserId).ToList().Last().StatusPembayaran : "Belum diterima"
                    }
                );
            }
            return View(model);
        }

        //
        // GET: /Popup/DetailGiftcard
        [HttpGet]
        public ActionResult DetailGiftcard(string transId)
        {
            var model = db.TransactionGiftcardMessage.Where(a => a.TransactionId == transId).ToList();
            return View(model);
        }

        // GET: /Popup/Login

        public ActionResult Login(string returnUrl)
        {
            ViewBag.ReturnUrl = returnUrl;
            return View();
        }

        //
        // GET: /Popup/Details/5

        public ActionResult Details(int id)
        {
            return View();
        }

        //
        // GET: /Popup/Create

        public ActionResult Create()
        {
            return View();
        }
        
        protected string RenderPartialViewToString(string viewName, object model)
        {
            if (string.IsNullOrEmpty(viewName))
                viewName = ControllerContext.RouteData.GetRequiredString("action");

            ViewData.Model = model;

            using (StringWriter sw = new StringWriter())
            {
                ViewEngineResult viewResult = ViewEngines.Engines.FindPartialView(ControllerContext, viewName);
                ViewContext viewContext = new ViewContext(ControllerContext, viewResult.View, ViewData, TempData, sw);
                viewResult.View.Render(viewContext, sw);

                return sw.GetStringBuilder().ToString();
            }
        }
    }

}
