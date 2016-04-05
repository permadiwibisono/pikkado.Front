using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.Owin;
using Microsoft.Owin.Security;
using pickkado.Front.Db;
using pickkado.Front.Models;
using pickkado.Front.Areas.Vendor.Models;
using System.IO;
using pickkado.Entities;

namespace pickkado.Front.Areas.Vendor.Controllers
{
    public class PopupController : Controller
    {
        //
        // GET: /Vendor/Popup/
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
        public ActionResult Index()
        {
            return View();
        }
        public ActionResult popup_order_details(string id)
        {
            return View();
        }
        public ActionResult popup_product_details(string id)
        {
            var getTrans = db.Transaction.Find(id);
            var model = new PopupProductDetailsViewModel();
            model.ProductName=getTrans.ProductName;
            model.ProductWeight=getTrans.ProductWeight;
            model.ProductDescription=getTrans.ProductDescription;
            model.DiscountProduct = 0;
            model.Price = getTrans.ProductPrice;
            model.Total = model.Price - model.DiscountProduct;
            model.Image = getTrans.ProductImage;
            foreach (var item in getTrans.TransactionProductAttributes.ToList())
            {
                model.ProdutAttributeList.Add(new ProductAttributeViewModel { 
                    Name=item.Name,
                    Value=item.Value
                });
            }
            return View(model);
        }

        public ActionResult popup_reject_order(string id)
        {
            try
            {
                var user = UserManager.FindByEmail(User.Identity.GetUserName());
                var getTrans = db.Transaction.Where(e => e.Id == id && e.StoreId == user.user.StoreId).SingleOrDefault();
                
                var model = new PopupProductDetailsViewModel();
                model.ProductName = getTrans.ProductName;
                model.ProductWeight = getTrans.ProductWeight;
                model.ProductDescription = getTrans.ProductDescription;
                model.DiscountProduct = 0;
                model.Price = getTrans.ProductPrice;
                model.Total = model.Price - model.DiscountProduct;
                model.Image = getTrans.ProductImage;
                foreach (var item in getTrans.TransactionProductAttributes.ToList())
                {
                    model.ProdutAttributeList.Add(new ProductAttributeViewModel
                    {
                        Name = item.Name,
                        Value = item.Value
                    });
                }
                var model2 = new PopupRejectOrderViewModel();
                model2.Id = getTrans.Id;
                ViewBag.ProductDetails = model;
                return View(model2);
            }
            catch (Exception ex)
            {
                return Json(new { IsError = true, Message = ex.Message });                 
            }
        }
        [HttpPost]
        public ActionResult popup_reject_order(PopupRejectOrderViewModel model2)
        {
            try
            {
                var user = UserManager.FindByEmail(User.Identity.GetUserName());
                var getTrans = db.Transaction.Where(e => e.Id == model2.Id && e.StoreId == user.user.StoreId).SingleOrDefault();
                
                var model = new PopupProductDetailsViewModel();
                model.ProductName = getTrans.ProductName;
                model.ProductWeight = getTrans.ProductWeight;
                model.ProductDescription = getTrans.ProductDescription;
                model.DiscountProduct = 0;
                model.Price = getTrans.ProductPrice;
                model.Total = model.Price - model.DiscountProduct;
                model.Image = getTrans.ProductImage;
                foreach (var item in getTrans.TransactionProductAttributes.ToList())
                {
                    model.ProdutAttributeList.Add(new ProductAttributeViewModel
                    {
                        Name = item.Name,
                        Value = item.Value
                    });
                }
                ViewBag.ProductDetails = model;
                if (ModelState.IsValid)
                {
                    bool isError = false;
                    string msg = "";
                    if (getTrans != null)
                    {
                        var payment = db.VendorPayment.Where(e => e.TransactionId == model2.Id).SingleOrDefault();
                        bool found = false;
                        found = payment == null ? false : true;
                        if (found)
                        {
                            payment.IsAccepted = false;
                            payment.IsDeliver = false;
                            payment.IsDelivered = false;
                            payment.IsPaid = false;
                            payment.Remarks = model2.Remarks;
                            payment.UpdatedBy = user.user.StoreId;
                            payment.UpdatedDate = DateTime.Now;
                        }
                        else
                        {
                            payment = new VendorPayment();
                            payment.TransactionId = model2.Id;
                            payment.Id = payment.GenerateId("VP");
                            payment.IsAccepted = false;
                            payment.IsDeliver = false;
                            payment.IsDelivered = false;
                            payment.IsPaid = false;
                            payment.Remarks = model2.Remarks;
                            payment.Price = getTrans.ProductPrice;
                            payment.UpdatedBy = user.user.StoreId;
                            payment.CreatedBy = user.user.StoreId;
                            db.VendorPayment.Add(payment);
                        }
                        getTrans.Status = TransactionStatus.Cancel;
                        db.SaveChanges();
                        msg = "Success rejected this order!";
                        return Json(new { IsError = isError, Message = msg });                        
                    }
                    else
                    {
                        return Json(new { IsError = true, Message = "Not Found!" });
                    }
                }
                return Json(new { IsError = true, Message = "Please fullfill your form!", HtmlString = RenderPartialViewToString("popup_reject_order",model2) });
            }
            catch (Exception ex)
            {
                return Json(new { IsError = true, Message = ex.Message });                
            }
        }

        [HttpGet]
        public ActionResult popup_confirm_delivery(string paymentId, string transId)
        {
            try
            {
                var user = UserManager.FindByEmail(User.Identity.GetUserName());
                var getTrans = db.Transaction.Where(e => e.Id == transId && e.StoreId == user.user.StoreId).SingleOrDefault();
                var payment = db.VendorPayment.Find(paymentId);
                var model = new PopupProductDetailsViewModel();
                model.ProductName = getTrans.ProductName;
                model.ProductWeight = getTrans.ProductWeight;
                model.ProductDescription = getTrans.ProductDescription;
                model.DiscountProduct = 0;
                model.Price = getTrans.ProductPrice;
                model.Total = model.Price - model.DiscountProduct;
                model.Image = getTrans.ProductImage;
                foreach (var item in getTrans.TransactionProductAttributes.ToList())
                {
                    model.ProdutAttributeList.Add(new ProductAttributeViewModel
                    {
                        Name = item.Name,
                        Value = item.Value
                    });
                }
                var model2 = new PopupConfirmOrderViewModel();
                model2.Id = getTrans.Id;
                model2.PaymentId = payment.Id;
                model2.JenisPaket = "YES";
                model2.NamaKurir = "JNE";
                model2.AlamatPickkado = "Menara Top Food 6th Floor, Jalur Sutera Barat 3, Alam Sutera - Tangerang";
                ViewBag.ProductDetails = model;
                return View(model2);
            }
            catch (Exception ex)
            {
                return Json(new { IsError = true, Message = ex.Message });
            }
        }

        [HttpPost]
        public ActionResult popup_confirm_delivery(PopupConfirmOrderViewModel model2)
        {
            try
            {
                var user = UserManager.FindByEmail(User.Identity.GetUserName());
                var getTrans = db.Transaction.Where(e => e.Id == model2.Id && e.StoreId == user.user.StoreId).SingleOrDefault();

                var model = new PopupProductDetailsViewModel();
                model.ProductName = getTrans.ProductName;
                model.ProductWeight = getTrans.ProductWeight;
                model.ProductDescription = getTrans.ProductDescription;
                model.DiscountProduct = 0;
                model.Price = getTrans.ProductPrice;
                model.Total = model.Price - model.DiscountProduct;
                model.Image = getTrans.ProductImage;
                foreach (var item in getTrans.TransactionProductAttributes.ToList())
                {
                    model.ProdutAttributeList.Add(new ProductAttributeViewModel
                    {
                        Name = item.Name,
                        Value = item.Value
                    });
                }
                ViewBag.ProductDetails = model;
                if (ModelState.IsValid)
                {
                    bool isError = false;
                    string msg = "";
                    var payment = db.VendorPayment.Find(model2.PaymentId);
                    if (getTrans != null && payment != null)
                    {
                        payment.ResiNumber = model2.NoResi;
                        payment.IsDeliver = true;
                        payment.AlamatPickkado = model2.AlamatPickkado;
                        payment.NamaKurir = model2.NamaKurir;
                        payment.JenisPaket = model2.JenisPaket;
                        payment.UpdatedBy = user.user.StoreId;
                        payment.UpdatedDate = DateTime.Now;
                        getTrans.Status = TransactionStatus.OnBuying;
                        db.SaveChanges();
                        msg = "Success delivering this order!";
                        return Json(new { IsError = isError, Message = msg });
                    }
                    else
                    {
                        return Json(new { IsError = true, Message = "Not Found!" });
                    }
                }
                return Json(new { IsError = true, Message = "Please fullfill your form!", HtmlString = RenderPartialViewToString("popup_confirm_delivery", model2) });
            }
            catch (Exception ex)
            {
                return Json(new { IsError = true, Message = ex.Message });
            }
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
