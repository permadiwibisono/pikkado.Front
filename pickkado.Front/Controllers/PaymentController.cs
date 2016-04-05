using pickkado.Entities;
using pickkado.Front.Models;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.Owin;
using Microsoft.Owin.Security;
using System.Threading.Tasks;
using unirest_net.http;
using System.Net;
using System.Text;
using pickkado.Front.Db;

namespace pickkado.Front.Controllers
{
    public class PaymentController : Controller
    {
        #region properties
        public const string sessionName = "Transaction";

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
        //
        // GET: /Payment/

        public PaymentController()
        {
        }

        public PaymentController(ApplicationUserManager userManager, ApplicationSignInManager signInManager)
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
        
        public async Task<ActionResult> Index(string id)
        {
            var tran = db.Transaction.Find(id);
            var userLogin = await UserManager.FindByNameAsync(User.Identity.Name);
            if (tran != null)
            {
                ViewBag.Transaction = tran;
                ViewBag.TotalHarga = tran.GetTotalPrice();
                ViewBag.ProductName = tran.ProductName;
                ViewBag.RekeningPickkadoes = db.NoRekeningPickkado.ToList();

                var tranMemberGroups = tran.TransactionMemberGroups.ToList();
                List<PatunganInvitationStatusViewModel> ListPatunganInvitationStatus = new List<PatunganInvitationStatusViewModel>();
                for (int i = 0; i < tranMemberGroups.Count; i++)
                {
                    var user = db.User.Find(tranMemberGroups[i].UserId);
                    string name = tranMemberGroups[i].Name;
                    if (!string.IsNullOrEmpty(tranMemberGroups[i].UserId) && tranMemberGroups[i].UserId == userLogin.UserId)
                        name = "You";
                    ListPatunganInvitationStatus.Add(new PatunganInvitationStatusViewModel { TransactionMemberGroupsId = tranMemberGroups[i].Id, UserId = tranMemberGroups[i].UserId, Name = name, Status = tranMemberGroups[i].IsResponse ? tranMemberGroups[i].IsAccept ? "Joined" : "Rejected" : "Waiting", PriceToRupiah = tranMemberGroups[i].Price.ToRupiah() });
                }

                ViewBag.ListPatunganInvitationStatus = ListPatunganInvitationStatus;
                return View();
            }
            else
                return RedirectToAction("index", "home");
        }

        // GET: /Payment/PurchaseInformation

        [HttpGet]
        public ActionResult PurchaseInformation(string returnUrl)
        {
            if (Session[sessionName] != null)
            {
                var tran = (TransactionModel)Session[sessionName];
                var post = new PostalCodeViewModel();
                var kelurahanList = db.PostalCode.ToList();
                post.Kelurahans = (from c in kelurahanList
                                   select new Kelurahan()
                                   {
                                       KelurahanName = c.Kelurahan,
                                       KecamatanName = c.Kecamatan
                                   }).ToList();
                var cityList = kelurahanList.GroupBy(grp => grp.Kabupaten).Select(grp => grp.First()).ToList();
                post.Cities = (from c in cityList
                               select new City()
                               {
                                   CityName = c.Kabupaten
                               }).ToList();
                var kecamatanList = kelurahanList.GroupBy(grp => grp.Kecamatan).Select(grp => grp.First()).ToList();
                post.Kecamatans = (from c in kecamatanList
                                   select new Kecamatan()
                                   {
                                       CityName = c.Kabupaten,
                                       KecamatanName = c.Kecamatan
                                   }).ToList();
                post.Kelurahans.Insert(0, new Kelurahan { KecamatanName = "", KelurahanName = "Pilih Kelurahan" });
                post.Kecamatans.Insert(0, new Kecamatan { CityName = "", KecamatanName = "Pilih Kecamatan" });
                post.Cities.Insert(0, new City { CityName = "Pilih Kabupaten/Kota" });
                post.Kecamatans = post.Kecamatans.Where(e => e.CityName == "").ToList();
                post.Kelurahans = post.Kelurahans.Where(e => e.KecamatanName == "").ToList();
                //ViewBag.orderInfo = tran.productInfo;
                //ViewBag.packageInfo = tran.packageInfo;
                ViewBag.LinkBack = returnUrl;
                ViewBag.ProductName = tran.productInfo.Name;
                if (tran.purchaseInfo != null)
                {
                    if (tran.purchaseInfo.postalcode == null)
                        tran.purchaseInfo.postalcode = post;
                    Session[sessionName] = tran;
                    return View(tran.purchaseInfo);
                }
                else
                {
                    var model = new PurchaseInformationViewModel();
                    model.ProductPrice = tran.productInfo.Price;
                    model.PackagePrice = tran.GetPackagePriceToRupiah();
                    model.GiftcardPrice = tran.GetGiftCardPriceToRupiah();
                    model.SubTotal = tran.GetSubTotalToRupiah();
                    model.NamaKurir = "JNE";
                    model.BiayaKirim = "Rp. 0";
                    foreach (var item in tran.giftcardInviteInfo.FriendsGiftCard)
                    {
                        model.PatunganFriends.Add(item);
                    }
                    tran.purchaseInfo = model;
                    tran.purchaseInfo.postalcode = post;
                    Session[sessionName] = tran;
                    return View(tran.purchaseInfo);
                }
            }
            return RedirectToAction("", "home");

            //return View();
        }
        [HttpPost]
        public ActionResult PurchaseInformation(PurchaseInformationViewModel model, string returnUrl)
        {
            if (Session[sessionName] != null)
            {
                var tran = (TransactionModel)Session[sessionName];
                var post = new PostalCodeViewModel();
                //post.Kecamatans = post.Kecamatans.Where(e => e.CityName == "").ToList();
                //post.Kelurahans = post.Kelurahans.Where(e => e.KecamatanName == "").ToList();
                var kelurahanList = db.PostalCode.ToList();
                model.postalcode.Kelurahans = (from c in kelurahanList
                                   select new Kelurahan()
                                   {
                                       KelurahanName = c.Kelurahan,
                                       KecamatanName = c.Kecamatan
                                   }).ToList();
                var cityList = kelurahanList.GroupBy(grp => grp.Kabupaten).Select(grp => grp.First()).ToList();
                model.postalcode.Cities = (from c in cityList
                               select new City()
                               {
                                   CityName = c.Kabupaten
                               }).ToList();
                var kecamatanList = kelurahanList.GroupBy(grp => grp.Kecamatan).Select(grp => grp.First()).ToList();
                model.postalcode.Kecamatans = (from c in kecamatanList
                                   select new Kecamatan()
                                   {
                                       CityName = c.Kabupaten,
                                       KecamatanName = c.Kecamatan
                                   }).ToList();
                model.postalcode.Kelurahans.Insert(0, new Kelurahan { KecamatanName = "", KelurahanName = "Pilih Kelurahan" });
                model.postalcode.Kecamatans.Insert(0, new Kecamatan { CityName = "", KecamatanName = "Pilih Kecamatan" });
                model.postalcode.Cities.Insert(0, new City { CityName = "Pilih Kabupaten/Kota" });
                model.postalcode.Kecamatans = model.postalcode.Kecamatans.Where(e => e.CityName == model.postalcode.City).ToList();
                model.postalcode.Kelurahans = model.postalcode.Kelurahans.Where(e => e.KecamatanName == model.postalcode.Kecamatan).ToList();
                //ViewBag.orderInfo = tran.productInfo;
                //ViewBag.packageInfo = tran.packageInfo;
                ViewBag.ProductName = tran.productInfo.Name;
                //tran.purchaseInfo.postalcode = post;
                if (ModelState.IsValid)
                {
                    var inValidCount = 0;
                    if (model.postalcode.City == "Pilih Kabupaten/Kota" && model.postalcode.Kecamatan == "Pilih Kecamatan" && model.postalcode.Kelurahan == "Pilih Kelurahan")
                    {
                        ModelState.AddModelError("", "Choose your city or kecamatan or kelurahan of your address!");
                        inValidCount++;
                        return View(model);
                    }
                    if (model.SendDate == null)
                    {
                        ModelState.AddModelError("", "Send date is required!");
                        inValidCount++;
                    }
                    if (model.SendDate < DateTime.Now.AddDays(5))
                    {
                        ModelState.AddModelError("", "Minimum Send date is the next 5 days!");
                        inValidCount++;
                    }
                    if (model.IsPatungan)
                    {
                        if (string.IsNullOrEmpty(model.PatunganTitle))
                        {
                            ModelState.AddModelError("", "Title is required.");
                            inValidCount++;
                        }
                        if (string.IsNullOrEmpty(model.PatunganPenerimaKado))
                        {
                            ModelState.AddModelError("", "Penerima Kado is required.");
                            inValidCount++;
                        }
                        if (string.IsNullOrEmpty(model.PatunganDeskripsi))
                        {
                            ModelState.AddModelError("", "Deskripsi is required.");
                            inValidCount++;
                        }
                        if (model.PatunganFriends.Count > 0)
                        {
                            foreach (var item in model.PatunganFriends)
                            {
                                if (string.IsNullOrEmpty(item.Email) || string.IsNullOrEmpty(item.Name))
                                {
                                    ModelState.AddModelError("", "Please fulfill your friend's name and email.");
                                    inValidCount++;
                                    break;
                                }
                            }
                        }
                    }
                    else
                    {
                        model.PatunganFriends.Clear();
                    }
                    if (inValidCount == 0)
                    {
                        tran.purchaseInfo = model;
                        Session[sessionName] = tran;
                        return RedirectToAction("revieworder", new { returnUrl = GetReturnUrl() });
                    }
                }
                ViewBag.LinkBack = returnUrl;
                return View(model);
            }
            return RedirectToAction("", "home");
        }
        // GET: /Payment/ReviewOrder

        [HttpPost]
        public ActionResult Postal_Code(PurchaseInformationViewModel model, string city = "", string kec = "", string kel = "")
        {
            //HttpResponse<dynamic> jsonResponse = Unirest.get("http://api.rajaongkir.com/starter/city")
            //  .header("key", "0f89cac1a365b19d9232df468d89fd48")
            //  .header("accept", "application/json")
            //  //.field("parameter", "value")
            //  //.field("foo", "bar")
            //  .asJson<dynamic>();
            var kelurahanList = db.PostalCode.ToList();
            model.postalcode.Kelurahans = (from c in kelurahanList
                               select new Kelurahan()
                               {
                                   KelurahanName = c.Kelurahan,
                                   KecamatanName = c.Kecamatan
                               }).ToList();
            var cityList = kelurahanList.GroupBy(grp => grp.Kabupaten).Select(grp => grp.First()).ToList();
            model.postalcode.Cities = (from c in cityList
                           select new City()
                           {
                               CityName = c.Kabupaten
                           }).ToList();
            var kecamatanList = kelurahanList.GroupBy(grp => grp.Kecamatan).Select(grp => grp.First()).ToList();
            model.postalcode.Kecamatans = (from c in kecamatanList
                               select new Kecamatan()
                               {
                                   CityName = c.Kabupaten,
                                   KecamatanName = c.Kecamatan
                               }).ToList();
            model.postalcode.Kelurahans.Insert(0, new Kelurahan { KecamatanName = "", KelurahanName = "Pilih Kelurahan" });
            model.postalcode.Kecamatans.Insert(0, new Kecamatan { CityName = "", KecamatanName = "Pilih Kecamatan" });
            model.postalcode.Cities.Insert(0, new City { CityName = "Pilih Kabupaten/Kota" });
            model.postalcode.Kecamatans = model.postalcode.Kecamatans.Where(e => e.CityName == city || e.CityName == "").ToList();
            model.postalcode.Kelurahans = model.postalcode.Kelurahans.Where(e => e.KecamatanName == kec || e.KecamatanName == "").ToList();
            return Json(new { HtmlString = RenderPartialViewToString("postal_code", model) });
        }

        [HttpGet]
        public ActionResult ReviewOrder(string returnUrl)
        {
            if (Session["Transaction"] != null)
            {
                var tran = (TransactionModel)Session["Transaction"];
                var attributeList = db.ProductAttribute.Where(e => e.ProductId == tran.productInfo.ProductId).ToList();
                ViewBag.AdditionalInfo = (from at in attributeList
                                      where (from ats in tran.productInfo.AttributeSelected select ats).Contains(at.Id)
                                      select at).ToList();

                ViewBag.LinkBack = returnUrl;
                ViewBag.ProductName = tran.productInfo.Name;
                if (tran.purchaseInfo.IsPatungan)
                {
                    var jumlahPatungan=tran.purchaseInfo.PatunganFriends.Count + 1;
                    ViewBag.JumlahPatungan = jumlahPatungan;
                    var total = Math.Ceiling(float.Parse(tran.purchaseInfo.Total.DeleteNonNumeric())/jumlahPatungan);
                    ViewBag.TotalPerorangan = total.ToRupiah();                    
                }
                return View(tran);
            }
            else
                return RedirectToAction("index", "home");
        }

        [HttpPost]
        [Authorize]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult>ReviewOrder(TransactionModel model, string returnUrl)
        {
            try {
                if (Session[sessionName] != null)
                {
                    model = (TransactionModel)Session[sessionName];
                    var transaction = new Transaction();
                    transaction.Id = model.TransactionId;
                    transaction.TransDate = model.TransactionDate;
                    transaction.TanggalKirim = model.purchaseInfo.SendDate;
                    var user = await UserManager.FindByNameAsync(User.Identity.Name);
                    if (user != null)
                    {
                        transaction.UserId = user.UserId;
                        transaction.UserName = user.UserName;
                    }
                    var userDb = db.User.Find(transaction.UserId);
                    transaction.User = userDb;
                    if (model.TransactionType == TransactionType.Order)
                    {
                        transaction.TransactionType = TransactionType.Order;
                        transaction.ProductId = null;
                        transaction.ProductName = TransactionType.Order;
                        transaction.ProductCategory = "";
                        transaction.ProductBrand = "";
                        transaction.ProductDescription = model.orderInfo.OrderDetail;
                        transaction.ProductPrice = model.orderInfo.Price;
                        transaction.ProductImage = model.orderInfo.imageByte;
                    }
                    else if (transaction.TransactionType == TransactionType.Suggest)
                    {
                        transaction.TransactionType = TransactionType.Suggest;
                        transaction.ProductId = null;
                        transaction.ProductName = model.orderInfo.OrderDetail;
                    }
                    else
                    {
                        transaction.TransactionType = TransactionType.Catalog;
                        transaction.ProductId = model.productInfo.ProductId;
                        transaction.ProductName = model.productInfo.Name;
                        transaction.ProductCategory = model.productInfo.CategoryName;
                        transaction.ProductBrand = "";
                        transaction.ProductDescription = model.productInfo.Description;
                        transaction.ProductPrice = float.Parse(model.productInfo.Price.DeleteNonNumeric());
                        transaction.ProductImage = model.productInfo.Image;
                        transaction.ProductWeight = model.productInfo.Weight;

                    }
                    transaction.PackageId = model.packageInfo.package.Id;
                    transaction.PackageImage = model.packageInfo.package.Image;
                    transaction.PackageName = model.packageInfo.package.Name;
                    transaction.PackagePrice = model.packageInfo.package.Price;
                    transaction.GreetingCardId = model.packageInfo.giftcard.Id;
                    transaction.GreetingCardImage = model.packageInfo.giftcard.Image;
                    transaction.GreetingCardName = model.packageInfo.giftcard.Name;
                    transaction.GreetingCardPrice = model.packageInfo.giftcard.Price;
                    transaction.GreetingCardImage = model.packageInfo.giftcard.Image;
                    transaction.ReceiveName = model.purchaseInfo.ReceiverName;
                    transaction.DestinationAddress = model.purchaseInfo.DeliveryAddress;
                    transaction.City = model.purchaseInfo.postalcode.City;
                    transaction.Kecamatan = model.purchaseInfo.postalcode.Kecamatan;
                    transaction.Kelurahan = model.purchaseInfo.postalcode.Kelurahan;
                    //transaction.City = model.purchaseInfo.Kota;
                    //transaction.Kecamatan = model.purchaseInfo.Kecamatan;
                    //transaction.Kelurahan = model.purchaseInfo.Kelurahan;
                    transaction.ShippingFee = float.Parse(model.purchaseInfo.BiayaKirim.DeleteNonNumeric().ToString());
                    transaction.NamaKurir = model.purchaseInfo.NamaKurir;
                    transaction.JenisPaket = model.purchaseInfo.JenisPaket;
                    transaction.AsuransiKurir = model.purchaseInfo.AsuransiPaket;
                    transaction.ServiceFee = Fee.ServiceFee;
                    transaction.VoucherId = "";
                    transaction.DiscountVoucherPrice = 0;
                    var isGroup = model.purchaseInfo.IsPatungan;
                    var groupCount = model.purchaseInfo.PatunganFriends.Where(e => !string.IsNullOrEmpty(e.Name) && !string.IsNullOrEmpty(e.Email)).Count() + 1;
                    transaction.IsGroup = isGroup;
                    transaction.GroupCount = groupCount;
                    if (!transaction.IsGroup)
                        transaction.Status = TransactionStatus.UnconfirmPayment;
                    else
                        transaction.Status = TransactionStatus.InvitationGroup;
                    transaction.CreatedBy = transaction.UserId;
                    transaction.CreatedDate = DateTime.Now;
                    transaction.UpdatedBy = transaction.UserId;
                    transaction.UpdatedDate = DateTime.Now;

                    transaction.InviteFriendGiftcardMessage = model.giftcardInviteInfo.MessageToFriends;


                    db.Transaction.Add(transaction);
                    //add transaction product attribute list
                    var addTransactionProductAttributeAsync = AddTransactionProductAttributeAsync(model.productInfo.AttributeSelected, transaction);
                    //add giftcard message list
                    var addTransactionGiftCardMessageAsync = AddTransactionGiftCardMessageAsync(model.giftcardInviteInfo, transaction, userDb);
                    //add transaction group member list
                    if (isGroup && groupCount > 1)
                    {
                        double totalPerorangan = Math.Ceiling(transaction.GetTotalPrice() / (groupCount));
                        transaction.GroupTitle = model.purchaseInfo.PatunganTitle;
                        transaction.GroupDescription = model.purchaseInfo.PatunganDeskripsi;
                        transaction.GroupReceiverName = model.purchaseInfo.PatunganPenerimaKado;
                        var addTransactionMemberGroupAsync = AddTransactionMemberGroupAsync(model.purchaseInfo, transaction, userDb, totalPerorangan);

                        await Task.WhenAll(addTransactionProductAttributeAsync, addTransactionGiftCardMessageAsync, addTransactionMemberGroupAsync);
                        db.TransactionProductAttribute.AddRange(addTransactionProductAttributeAsync.Result);
                        db.TransactionGiftcardMessage.AddRange(addTransactionGiftCardMessageAsync.Result);
                        db.TransactionMemberGroup.AddRange(addTransactionMemberGroupAsync.Result);
                        await db.SaveChangesAsync();
                        await SendEmailInvite(addTransactionGiftCardMessageAsync.Result, transaction);
                        await SendEmailInvitePatungan(addTransactionMemberGroupAsync.Result, transaction);
                        await SendEmailStruk(addTransactionMemberGroupAsync.Result, transaction);
                    }
                    else
                    {
                        await Task.WhenAll(addTransactionProductAttributeAsync, addTransactionGiftCardMessageAsync);
                        db.TransactionProductAttribute.AddRange(addTransactionProductAttributeAsync.Result);
                        db.TransactionGiftcardMessage.AddRange(addTransactionGiftCardMessageAsync.Result);
                        await db.SaveChangesAsync();
                        await SendEmailInvite(addTransactionGiftCardMessageAsync.Result, transaction);
                        await SendEmailStruk(transaction);
                    }
                    Session[sessionName] = null;
                    return RedirectToAction("", new { id = transaction.Id });
                }
                else
                    return RedirectToAction("", "home");
            }
            catch (Exception ex)
            {
                ViewBag.Error = ex.Message;
                return View("Error");
            }
            
        }
        async Task SendEmailStruk(Transaction transaction)
        {
            var body = "";
            using (var sr = new StreamReader(Server.MapPath("\\App_Data\\Templates\\") + "struk.txt"))
            {
                body = sr.ReadToEnd();
            }
            //var pathLogo = Server.MapPath("\\Images\\") + "brand.png";
            //var byteLogo = System.IO.File.ReadAllBytes(pathLogo);
            await SendEmail.SendEmailStruk(new StrukSentEmailModel
            {
                TemplateEmail = body,
                //Logo = byteLogo,
                ToName = transaction.User.FirstName,
                ToEmail = transaction.User.Email,
                //FromName = transaction.User.FirstName,
                TransactionId = transaction.Id,
                ProductName = transaction.ProductName,
                TanggalPengiriman = transaction.TanggalKirim.ToString("dd MMM yyyy"),
                Patungan = transaction.IsGroup ? "Ya" : "Tidak",
                TotalProduct = transaction.ProductPrice.ToRupiah(),
                TotalGiftcard = transaction.GreetingCardPrice.ToRupiah(),
                TotalPackage = transaction.PackagePrice.ToRupiah(),
                OngkosKirim = transaction.ShippingFee.ToRupiah(),
                ServiceFee = transaction.ServiceFee.ToRupiah(),
                TOTAL = transaction.GetTotalPrice().ToRupiah(),
                BatasWaktu = transaction.TanggalKirim.ToString("dd MMM yyyy")
            });
        }
        async Task SendEmailStruk(List<TransactionMemberGroup> list, Transaction transaction)
        {
            var body = "";
            using (var sr = new StreamReader(Server.MapPath("\\App_Data\\Templates\\") + "strukpatungan.txt"))
            {
                body = sr.ReadToEnd();
            }
            //var pathLogo = Server.MapPath("\\Images\\") + "brand.png";
            //var byteLogo = System.IO.File.ReadAllBytes(pathLogo);
            string daftarMember = "";
            foreach (var item in list)
            {
                daftarMember += "<tr><td style=\"padding:5px;\">" +(transaction.UserId==item.UserId?"You": item.Name) + "<td><td style=\"padding:5px;text-align:right;\">" + item.Price.ToRupiah() + "</td></tr>";
            }
            await SendEmail.SendEmailStruk(new StrukPatunganSentEmailModel
            {
                TemplateEmail = body,
                //Logo = byteLogo,
                ToName = transaction.User.FirstName,
                ToEmail = transaction.User.Email,
                //FromName = transaction.User.FirstName,
                TransactionId = transaction.Id,
                ProductName = transaction.ProductName,
                TanggalPengiriman = transaction.TanggalKirim.ToString("dd MMM yyyy"),
                TotalProduct = transaction.ProductPrice.ToRupiah(),
                TotalGiftcard = transaction.GreetingCardPrice.ToRupiah(),
                TotalPackage = transaction.PackagePrice.ToRupiah(),
                OngkosKirim = transaction.ShippingFee.ToRupiah(),
                ServiceFee = transaction.ServiceFee.ToRupiah(),
                TOTAL = transaction.GetTotalPrice().ToRupiah(),
                BatasWaktu = transaction.TanggalKirim.ToString("dd MMM yyyy"),
                DaftarMemberPlainHtml=daftarMember
            });
        }
        async Task SendEmailInvite(List<TransactionGiftcardMessage> list, Transaction transaction)
        {
            var body = "";
            using (var sr = new StreamReader(Server.MapPath("\\App_Data\\Templates\\") + "invitegiftcardmessage.txt"))
            {
                body = sr.ReadToEnd();
            }
            //var pathLogo = Server.MapPath("\\Images\\") + "brand.png";
            //var byteLogo = System.IO.File.ReadAllBytes(pathLogo);
            foreach (var l in list)
            {
                if (l.Email != transaction.User.Email)
                {
                    await SendEmail.SendEmailInviteToGiftcardMessage(new InviteGiftCardSentEmailModel
                    {
                        TemplateEmail = body,
                        //Logo = byteLogo,
                        ToName = l.Name,
                        ToEmail = l.Email,
                        FromName = transaction.User.FirstName,
                        InviteMessage = transaction.InviteFriendGiftcardMessage,
                        Link = Url.Action("giftcard","invitation",new{code=l.ShareCode.ToString()}),
                        BatasWaktu = l.BatasWaktu.ToString("dd MMM yyyy")
                    });
                }
            }
        }
        async Task SendEmailInvitePatungan(List<TransactionMemberGroup> list, Transaction transaction)
        {
            var body = "";
            using (var sr = new StreamReader(Server.MapPath("\\App_Data\\Templates\\") + "invitepatunganmessage.txt"))
            {
                body = sr.ReadToEnd();
            }
            //var pathLogo = Server.MapPath("\\Images\\") + "brand.png";
            //var byteLogo = System.IO.File.ReadAllBytes(pathLogo);
            foreach (var l in list)
            {
                if (l.Email != transaction.User.Email)
                {
                    await SendEmail.SendEmailInviteToPatunganMessage(new InvitePatunganSentEmailModel
                    {
                        TemplateEmail = body,
                        //Logo = byteLogo,
                        ToName = l.Name,
                        ToEmail = l.Email,
                        FromName = transaction.User.FirstName,
                        InviteMessage = transaction.GroupDescription,
                        Link = "",
                        JumlahPatungan = l.Price.ToRupiah(),
                        BatasWaktu = transaction.TanggalKirim.ToString("dd MMM yyyy"),
                        PenerimaKado = transaction.GroupReceiverName
                    });
                }
            }
        }
        async Task<List<TransactionProductAttribute>> AddTransactionProductAttributeAsync(List<string> productAttributeSelectedList,Transaction transaction)
        {
            List<TransactionProductAttribute> TransAttList = new List<TransactionProductAttribute>();
            var attributeList = db.ProductAttribute.Where(e => e.ProductId == transaction.ProductId).ToList();
            var list = (from at in attributeList
                        where (from ats in productAttributeSelectedList select ats).Contains(at.Id)
                        select at).ToList();
            int count = 1;
            foreach (var at in list)
            {
                var a = new TransactionProductAttribute();
                a.Id = a.GenerateId("TPA")+"-"+count++.ToString();
                a.TransactionId = transaction.Id;
                a.ProductId = transaction.ProductId;
                a.Name = at.master.Name;
                a.Value = at.Value;
                a.CreatedBy = transaction.UserId;
                a.CreatedDate = DateTime.Now;
                a.UpdatedBy = transaction.UserId;
                a.UpdatedDate = DateTime.Now;
                TransAttList.Add(a);
            }
            return TransAttList;
        }
        async Task<List<TransactionGiftcardMessage>> AddTransactionGiftCardMessageAsync(GiftCardInviteViewModel model, Transaction transaction, User userDb)
        {

            var giftCardFriends = new List<TransactionGiftcardMessage>();
            var giftcardMessage = new TransactionGiftcardMessage();
            int count = 1;
            giftcardMessage.Id = giftcardMessage.GenerateId("TGM")+"-"+count.ToString();
            giftcardMessage.TransactionId = transaction.Id;
            giftcardMessage.UserId = transaction.UserId;
            giftcardMessage.Email = transaction.UserName;
            giftcardMessage.Name = userDb.FirstName + ' ' + userDb.LastName;
            giftcardMessage.Message = model.MyGiftCard;
            giftcardMessage.CreatedBy = transaction.UserId;
            giftcardMessage.CreatedDate = DateTime.Now;
            giftcardMessage.UpdatedBy = transaction.UserId;
            giftcardMessage.UpdatedDate = DateTime.Now;
            giftcardMessage.ShareCode = Guid.NewGuid();
            giftcardMessage.BatasWaktu = transaction.TanggalKirim;
            giftCardFriends.Add(giftcardMessage);
            count++;
            foreach (var gf in model.FriendsGiftCard)
            {
                if (!string.IsNullOrEmpty(gf.Email) && !string.IsNullOrEmpty(gf.Name))
                {
                    var giftcardFriend = new TransactionGiftcardMessage();
                    giftcardFriend.Id = giftcardFriend.GenerateId("TGM") + "-" + count++.ToString();
                    giftcardFriend.TransactionId = transaction.Id;
                    giftcardFriend.UserId = null;
                    giftcardFriend.Email = gf.Email;
                    giftcardFriend.Name = gf.Name;
                    giftcardFriend.Message = "";
                    giftcardFriend.CreatedBy = transaction.UserId;
                    giftcardFriend.CreatedDate = DateTime.Now;
                    giftcardFriend.UpdatedBy = transaction.UserId;
                    giftcardFriend.UpdatedDate = DateTime.Now;
                    giftcardFriend.ShareCode = Guid.NewGuid();
                    giftcardFriend.BatasWaktu = transaction.TanggalKirim;
                    //await SendEmail.SendEmailInviteToGiftcardMessage(body, byteLogo, gf.Name, gf.Email, userDb.FirstName, model.giftcardInviteInfo.MessageToFriends, "");
                    
                    giftCardFriends.Add(giftcardFriend);
                }

            }
            return giftCardFriends;
            
        }
        async Task<List<TransactionMemberGroup>> AddTransactionMemberGroupAsync(PurchaseInformationViewModel model, Transaction transaction, User userDb,double totalPerorangan)
        {
            var patungan = new TransactionMemberGroup();
            var memberList = new List<TransactionMemberGroup>();
            int count = 1;
            patungan.Id = patungan.GenerateId("TMG") + "-" + count.ToString();
            patungan.IsAccept = true;
            patungan.IsResponse = true;
            patungan.UserId = userDb.Id;
            patungan.Email = userDb.Email;
            patungan.Name = userDb.FirstName + ' ' + userDb.LastName;
            patungan.Price = float.Parse(totalPerorangan.ToString());
            patungan.TransactionId = transaction.Id;
            patungan.BatasWaktu = transaction.TanggalKirim;
            patungan.ShareCode = new Guid();
            patungan.CreatedBy = transaction.UserId;
            patungan.CreatedDate = DateTime.Now;
            patungan.UpdatedBy = transaction.UserId;
            patungan.UpdatedDate = DateTime.Now;
            memberList.Add(patungan);
            count++;
            foreach (var pat in model.PatunganFriends)
            {
                if (!string.IsNullOrEmpty(pat.Email) && !string.IsNullOrEmpty(pat.Name))
                {
                    var member = new TransactionMemberGroup();
                    member.Id = member.GenerateId("TMG") + "-" + count++.ToString();
                    member.Price = float.Parse(totalPerorangan.ToString());
                    member.TransactionId = transaction.Id;
                    member.UserId = null;
                    member.Email = pat.Email;
                    member.Name = pat.Name;
                    member.CreatedBy = transaction.UserId;
                    member.CreatedDate = DateTime.Now;
                    member.UpdatedBy = transaction.UserId;
                    member.UpdatedDate = DateTime.Now;
                    //send email we
                    //await SendEmail.SendEmailInviteToGiftcardMessage(body, byteLogo, gf.Name, gf.Email, userDb.FirstName, model.giftcardInviteInfo.MessageToFriends, "");
                    
                    memberList.Add(member);
                }

            }
            return memberList;
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


        string GetReturnUrl()
        {
            return Request.UrlReferrer.PathAndQuery.ToString();
        }
    }
}
