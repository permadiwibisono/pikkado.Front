using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.Owin;
using Microsoft.AspNet.Identity.Owin;
using Microsoft.Owin.Security;
using pickkado.Front.Models;
using pickkado.Front.Db;
using pickkado.Front.Areas.Vendor.Models;
using pickkado.Entities;
namespace pickkado.Front.Areas.Vendor.Controllers
{
    public class OrderController : Controller
    {
        //
        // GET: /Vendor/Order/
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

        public ActionResult tab_order()
        {
            var user = UserManager.FindByEmail(User.Identity.GetUserName());
            var paymentList = db.VendorPayment.ToList();
            var list = db.Transaction.Where(e => e.Status == TransactionStatus.InventoryChecking
                &&e.StoreId==user.user.StoreId).ToList();
            var list2 = (from l in list
                         where !(from p in paymentList select p.TransactionId).Contains(l.Id)
                         select l).ToList();
            var listModel = new List<pickkado.Front.Areas.Vendor.Models.OrderViewModel>();
            foreach (var item in list2)
            {
                DateTime bataswaktu = item.TanggalKirim.Subtract(new TimeSpan(Rules.PaymentDueDateHMin - 1,0,0,0));
                listModel.Add(new Areas.Vendor.Models.OrderViewModel { 
                    Id=item.Id,
                    Price=item.ProductPrice.ToRupiah(),
                    ProductName=item.ProductName,
                    BatasWaktu=bataswaktu
                });
            }
            ViewBag.List = listModel;
            return View();
        }
        [HttpPost]
        public ActionResult AcceptOrder(string transId)
        {
            try
            {
                var user = UserManager.FindByEmail(User.Identity.GetUserName());
                bool isError = false;
                string message = "";
                var trans = db.Transaction.Where(e=>e.Id==transId&&e.StoreId==user.user.StoreId).SingleOrDefault();
                if (trans!=null)
                {
                    var payment = db.VendorPayment.Where(e => e.Id == transId).SingleOrDefault();
                    bool found = false;
                    found=payment==null?false:true;
                    if (found)
                    {
                        payment.IsAccepted = true;
                        payment.IsDeliver = false;
                        payment.IsDelivered = false;
                        payment.IsPaid = false;
                        payment.UpdatedBy = user.user.StoreId;
                        payment.UpdatedDate = DateTime.Now;
                    }
                    else
                    {
                        payment = new VendorPayment();
                        payment.TransactionId = transId;
                        payment.Id = payment.GenerateId("VP");
                        payment.IsAccepted = true;
                        payment.IsDeliver = false;
                        payment.IsDelivered = false;
                        payment.IsPaid = false;
                        payment.Price = trans.ProductPrice;
                        payment.UpdatedBy = user.user.StoreId;
                        payment.CreatedBy = user.user.StoreId;
                        db.VendorPayment.Add(payment);
                    }
                    message = "Success accepted order, now your order in Ready to Delivery List!";
                    db.SaveChanges();
                }
                else
                {
                    message = "Not Found!";
                }
                return Json(new { IsError = isError, Message = message });
            }
            catch (Exception ex)
            {
                return Json(new {IsError=true,Message=ex.Message });
            }
        }
        public ActionResult tab_ready()
        {
            var user = UserManager.FindByEmail(User.Identity.GetUserName());
            var paymentList = db.VendorPayment.Where(e=>e.IsAccepted&&!e.IsDeliver).ToList();
            var list = db.Transaction.Where(e => e.StoreId == user.user.StoreId).ToList();
            var list2 = (from l in list
                         join p in paymentList
                         on l.Id equals p.TransactionId
                         select new { 
                            l.Id,
                            l.ProductPrice,
                            l.ProductName,
                            l.TanggalKirim,
                            PaymentId=p.Id
                         }).ToList();
            var listModel = new List<pickkado.Front.Areas.Vendor.Models.OrderViewModel>();
            foreach (var item in list2)
            {
                DateTime bataswaktu = item.TanggalKirim.Subtract(new TimeSpan(Rules.PaymentDueDateHMin - 1, 0, 0, 0));
                listModel.Add(new Areas.Vendor.Models.OrderViewModel
                {
                    Id = item.Id,
                    PaymentId=item.PaymentId,
                    Price = item.ProductPrice.ToRupiah(),
                    ProductName = item.ProductName,
                    BatasWaktu = bataswaktu
                });
            }
            ViewBag.List = listModel;
            return View();
        }
        public ActionResult tab_confirmed()
        {
            var user = UserManager.FindByEmail(User.Identity.GetUserName());
            var paymentList = db.VendorPayment.ToList();
            var list = db.Transaction.Where(e => e.StoreId == user.user.StoreId).ToList();
            var list2 = (from l in list
                         join p in paymentList
                         on l.Id equals p.TransactionId
                         select new{
                            l.Id,
                            Price=l.ProductPrice.ToRupiah(),
                            ProductName=l.ProductName,
                            IsAccepted=p.IsAccepted,
                            IsPaid=p.IsPaid,
                            IsDeliver=p.IsDeliver,
                            IsDelivered=p.IsDelivered,
                            l.TanggalKirim,
                            p.Remarks,
                            p.ResiNumber
                         }).ToList();
            var listModel = new List<pickkado.Front.Areas.Vendor.Models.OrderViewModel>();
            foreach (var item in list2)
            {
                DateTime bataswaktu = item.TanggalKirim.Subtract(new TimeSpan(Rules.PaymentDueDateHMin - 1, 0, 0, 0));
                var model=new Areas.Vendor.Models.OrderViewModel
                {
                    Id = item.Id,
                    Price = item.Price,
                    ProductName = item.ProductName,
                    BatasWaktu = bataswaktu,
                    NoResi=item.ResiNumber,
                    Remarks=item.Remarks
                };
                if (!item.IsAccepted)
                    model.Status = "Rejected";
                else {
                    if (item.IsPaid)
                        model.Status = "Paid";
                    else
                    {
                        if (item.IsAccepted)
                        {
                            model.Status = "Waiting to Deliver";
                            if (item.IsDeliver&&item.IsDelivered)
                            {
                                model.Status = "Accepted by Pickkado";
                            }
                            else if (item.IsDeliver && !item.IsDelivered)
                                model.Status = "On Delivering";
                        }
                    }

                }
                listModel.Add(model);
                    
            }
            ViewBag.List = listModel;
            return View();
        }
    }
}
