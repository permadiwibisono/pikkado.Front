using pickkado.Front.Areas.Admin.Models;
using pickkado.Front.Db;
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

namespace pickkado.Front.Areas.Admin.Controllers
{
    [AuthorizeCustom(Roles = "Admin")]
    public class HomeController : Controller
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
        // GET: /Admin/Home/

        public ActionResult Index()
        {
            var model = new HomeViewModel();
            model.NewUserMonth = db.User.Where(e => e.CreatedDate.Month == DateTime.Now.Month && e.CreatedDate.Year == DateTime.Now.Year).ToList().Count;
            model.TotalUser = db.User.ToList().Count;
            model.NewVendorMonth=db.Store.Where(e => e.CreatedDate.Month == DateTime.Now.Month && e.CreatedDate.Year == DateTime.Now.Year).ToList().Count;
            var productList = db.ProductVendor.ToList();
            var getPopular = productList.OrderByDescending(t => t.Transactions.Count()).ToList();
            if (getPopular.Count > 0)
            {
                if (getPopular[0].Name.Length > 25)
                    model.ProductNamePopular = getPopular[0].Name.Replace(getPopular[0].Name.Substring(25), "...");
                else
                    model.ProductNamePopular = getPopular[0].Name;
                model.TotalProductPopular = getPopular[0].Transactions.Count;
            }
            else
            {
                model.ProductNamePopular = "No Product";
                model.TotalProductPopular = 0;
                
            }
            model.TotalVendor = db.Store.ToList().Count;
            model.TotalProduct = productList.ToList().Count;
            model.TotalPackage = db.Package.ToList().Count;
            model.TotalGiftcard = db.GiftCard.ToList().Count;
            var transactionList = db.Transaction.ToList();
            model.NewOrderToday = transactionList.Where(e =>!e.IsGroup&& e.CreatedDate.Date == DateTime.Now.Date && e.CreatedDate.Month == DateTime.Now.Month && e.CreatedDate.Year == DateTime.Now.Year).ToList().Count;
            model.TotalOrder = transactionList.Where(e => !e.IsGroup).ToList().Count;
            model.NewPatunganToday = transactionList.Where(e => e.IsGroup && e.CreatedDate.Date == DateTime.Now.Date && e.CreatedDate.Month == DateTime.Now.Month && e.CreatedDate.Year == DateTime.Now.Year).ToList().Count;
            model.TotalPatungan = transactionList.Where(e => e.IsGroup).ToList().Count;
            model.Income =transactionList.Where(e=>
                e.TransactionPayments.Where(t=>
                    t.StatusPembayaran==TransactionPaymentStatus.UnderPayment||
                    t.StatusPembayaran==TransactionPaymentStatus.Valid).Sum(s=>s.TotalDiBayar)>=e.GetTotalPrice()).Sum(x=>x.GetTotalPrice()).ToRupiah();
            model.Outcome = db.VendorPayment.Sum(x=>x.Price+x.OngkosKirim).ToRupiah();
            model.OnPaymentChecking = transactionList.Where(e => e.TransactionPayments.Where(t=>t.StatusPembayaran=="").ToList().Count>0).ToList().Count;
            model.OnProccess = transactionList.Where(e => e.Status == TransactionStatus.InventoryChecking || e.Status == TransactionStatus.OnBuying || e.Status == TransactionStatus.OnDelivering).ToList().Count;
            model.OnCancelled = transactionList.Where(e => e.Status == TransactionStatus.Cancel).ToList().Count;
            model.OnSuccess = transactionList.Where(e => e.Status == TransactionStatus.CompletedAdmin || e.Status == TransactionStatus.CompletedUser).ToList().Count;
            //var home = new HomeViewModel();
            //var post = new PostalCodeViewModel();
            //post.Kecamatans = post.Kecamatans.Where(e => e.CityName == "").ToList();
            //post.Kelurahans = post.Kelurahans.Where(e => e.KecamatanName == "").ToList();
            //home.postalcode = post;
            //ViewBag.PostalCode = post;
            return View(model);
        }
        [HttpPost]
        public ActionResult Index(HomeViewModel model)
        {
            return View(model);
        }
        [HttpPost]
        public ActionResult Postal_Code(HomeViewModel model, string city="", string kec="", string kel="")
        {
            model.postalcode.Kecamatans = model.postalcode.Kecamatans.Where(e => e.CityName == city || e.CityName == "").ToList();
            model.postalcode.Kelurahans = model.postalcode.Kelurahans.Where(e => e.KecamatanName == kec || e.KecamatanName == "").ToList();
            model.postalcode.CitySelected = city;
            model.postalcode.KecSelected = kec;
            model.postalcode.KelSelected = kel;
            return Json(new { HtmlString = RenderPartialViewToString("postal_code", model) });
        }
        [HttpGet]
        public ActionResult Postal_Code(HomeViewModel model)
        {
            //var model = new PostalCodeViewModel();
            return View(model);
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
