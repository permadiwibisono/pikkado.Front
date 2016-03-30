using pickkado.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using pickkado.Front.Areas.Admin.Models;
using System.Threading.Tasks;
using System.IO;

namespace pickkado.Front.Areas.Admin.Controllers
{
    [AuthorizeCustom(Roles = "Admin")]
    public class TransactionController : Controller
    {
        const int MaxDisplay = 1;
        Db.PickkadoDBContext db = new Db.PickkadoDBContext();
        //
        // GET: /Admin/Transaction/

        public ActionResult Index(string id="")
        {
            var list = db.Transaction.ToList();
            ViewBag.List = list;
            if (string.IsNullOrEmpty(id))
            {
                ViewBag.Tab = "list";
                return View();
            }
            else
            {
                var model = db.Transaction.Find(id);
                ViewBag.Tab = "header";
                return View(model);
            }
        }

        public ActionResult PaymentChecking()
        {
            return View();
        }
        public ActionResult Outstanding()
        {
            var transaction = db.Transaction.Where(e => e.Status == TransactionStatus.InventoryChecking).OrderBy(e => e.UpdatedDate).ToList();
            List<TransactionModel> list = new List<TransactionModel>();
            foreach (var item in transaction)
            {
                var a = new TransactionModel
                {
                    Id = item.Id,
                    Date = item.UpdatedDate,
                    Email = item.UserName,
                    Deadline = item.TanggalKirim,
                    ProductName = item.ProductName,
                    Total = item.GetTotalPrice(),
                    TotalTransfered = item.TransactionPayments.Where(p => p.StatusPembayaran == TransactionPaymentStatus.Valid || p.StatusPembayaran == TransactionPaymentStatus.UnderPayment).Sum(x => x.TotalDiBayar)

                };
                list.Add(a);
            }
            ViewBag.List = list;
            return View();
        }
        public ActionResult Onprocess()
        {
            var transaction = db.Transaction.OrderBy(e => e.UpdatedDate).ToList();
            List<TransactionModel> list = new List<TransactionModel>();
            foreach (var item in transaction.Where(e => e.Status == TransactionStatus.OnBuying).ToList())
            {
                var a = new TransactionModel
                {
                    Id = item.Id,
                    Email = item.UserName,
                    Deadline = item.TanggalKirim,
                    Total = item.GetTotalPrice(),
                    Address = item.DestinationAddress + ", " + item.Kecamatan + ", " + item.Kelurahan + ", " + item.City

                };
                list.Add(a);
            }
            ViewBag.List = list;

            List<TransactionModel> list2 = new List<TransactionModel>();
            foreach (var item in transaction.Where(e => e.Status == TransactionStatus.OnDelivering).ToList())
            {
                var a = new TransactionModel
                {
                    Id = item.Id,
                    Email = item.UserName,
                    Deadline = item.TanggalKirim,
                    Total = item.GetTotalPrice(),
                    Address = item.DestinationAddress + ", " + item.Kecamatan + ", " + item.Kelurahan + ", " + item.City,
                    ResiNumber = item.ResiNumber
                };
                list2.Add(a);
            }
            ViewBag.DeliveringList = list2;
            return View();
        }
        public ActionResult All(int page=1, string status="All")
        {
            var transaction = db.Transaction.ToList();
            List<TransactionModel> list = new List<TransactionModel>();
            int pageCount = transaction.Count>0? transaction.Count / MaxDisplay + (transaction.Count % MaxDisplay > 0 ? MaxDisplay : 0):0;
            int startIndex = page - 1;
            int endIndex = transaction.Count >= startIndex + MaxDisplay ? startIndex + MaxDisplay : transaction.Count;
            for (int i=startIndex;i<endIndex;i++)
            {
                var item = transaction[i];
                var a = new TransactionModel {
                    Id=item.Id,
                    Date=item.TransDate,
                    Deadline=item.TanggalKirim,
                    Email=item.UserName,
                    IsGroup=item.IsGroup,
                    Total=item.GetTotalPrice(),
                    TotalTransfered = item.TransactionPayments.Where(p => p.StatusPembayaran == TransactionPaymentStatus.Valid || p.StatusPembayaran == TransactionPaymentStatus.UnderPayment).Sum(x => x.TotalDiBayar),
                    Status=item.Status
                };
                list.Add(a);
            }
            //if (string.IsNullOrEmpty(id))
            //{
            //    ViewBag.Tab = "list";
            //}
            //else
            //{
            //    var model = db.Transaction.Find(id);
            //    ViewBag.Tab = "details";
            //    ViewBag.Transaction = model;
            //}
            ViewBag.List = list;
            ViewBag.PageCount = pageCount;
            ViewBag.NextPage= page+1;
            ViewBag.PrevPage = page - 1;
            return View();
        }
        public ActionResult tab_paymentlist(int page=1, string bank="")
        {
            bank = bank == "All" ? "" : bank;
            var transaction = db.TransactionPayment.ToList();
            transaction = transaction.Where(e => e.StatusPembayaran == "" && e.NamaBankTujuan.ToLower().Contains(bank.ToLower())).ToList();
            int pageCount = transaction.Count > 0 ? transaction.Count / MaxDisplay + (transaction.Count % MaxDisplay > 0 ? 1 : 0) : 0;
            int startIndex = page - 1;
            int endIndex = transaction.Count >= startIndex + MaxDisplay ? startIndex + MaxDisplay : transaction.Count;
            var list = new List<TransactionPayment>();
            for (int i = startIndex; i < endIndex; i++)
            {
                list.Add(transaction[i]);
            }
            ViewBag.PaymentCheckingList = list;
            ViewBag.PageCount = pageCount;
            ViewBag.NextPage = page + 1;
            ViewBag.PrevPage = page - 1;
            return View();

        }
        public ActionResult tab_underpaymentlist(int page=1,string bank="")
        {
            bank = bank == "All" ? "" : bank;
            var transaction = db.TransactionPayment.ToList();
            transaction = transaction.Where(e => e.StatusPembayaran == TransactionPaymentStatus.UnderPayment && e.NamaBankTujuan.ToLower().Contains(bank.ToLower())).ToList();
            int pageCount = transaction.Count > 0 ? transaction.Count / MaxDisplay + (transaction.Count % MaxDisplay > 0 ? 1 : 0) : 0;
            int startIndex = page - 1;
            int endIndex = transaction.Count >= startIndex + MaxDisplay ? startIndex + MaxDisplay : transaction.Count;
            var list = new List<TransactionPayment>();
            for (int i = startIndex; i < endIndex; i++)
            {
                list.Add(transaction[i]);
            }
            ViewBag.UnderPaymentList = list;
            ViewBag.PageCount = pageCount;
            ViewBag.NextPage = page + 1;
            ViewBag.PrevPage = page - 1;
            return View();

        }
        public ActionResult tab_validpaymentlist(int page=1,string bank="")
        {
            bank = bank == "All" ? "" : bank;
            var transaction = db.TransactionPayment.ToList();
            transaction = transaction.Where(e => e.StatusPembayaran == TransactionPaymentStatus.Valid && e.NamaBankTujuan.ToLower().Contains(bank.ToLower())).ToList();
            int pageCount = transaction.Count > 0 ? transaction.Count / MaxDisplay + (transaction.Count % MaxDisplay > 0 ? 1 : 0) : 0;
            int startIndex = page - 1;
            int endIndex = transaction.Count >= startIndex + MaxDisplay ? startIndex + MaxDisplay : transaction.Count;
            var list = new List<TransactionPayment>();
            for (int i = startIndex; i < endIndex; i++)
            {
                list.Add(transaction[i]);
            }
            ViewBag.ValidPaymentList = list;
            ViewBag.PageCount = pageCount;
            ViewBag.NextPage = page + 1;
            ViewBag.PrevPage = page - 1;
            return View();

        }
        public ActionResult tab_notvalidpaymentlist(int page=1 ,string bank="")
        {
            bank = bank == "All" ? "" : bank;
            var transaction = db.TransactionPayment.ToList();
            transaction = transaction.Where(e => e.StatusPembayaran == TransactionPaymentStatus.NotValid && e.NamaBankTujuan.ToLower().Contains(bank.ToLower())).ToList();
            int pageCount = transaction.Count > 0 ? transaction.Count / MaxDisplay + (transaction.Count % MaxDisplay > 0 ? 1 : 0) : 0;
            int startIndex = page - 1;
            int endIndex = transaction.Count >= startIndex + MaxDisplay ? startIndex + MaxDisplay : transaction.Count;
            var list = new List<TransactionPayment>();
            for (int i = startIndex; i < endIndex; i++)
            {
                list.Add(transaction[i]);
            }
            ViewBag.NotValidPaymentList = list;
            ViewBag.PageCount = pageCount;
            ViewBag.NextPage = page + 1;
            ViewBag.PrevPage = page - 1;
            return View();

        }
        public ActionResult popup_detail_transaction(string id = "")
        {

            if (string.IsNullOrEmpty(id))
            {
                //ViewBag.Tab = "list";
            }
            else
            {
                var model = db.Transaction.Find(id);
                //ViewBag.Tab = "details";
                ViewBag.Transaction = model;
            }
            return View();
        }
        
        public ActionResult popup_detail_transaction_payment(string id = "")
        {

            if (string.IsNullOrEmpty(id))
            {
                //ViewBag.Tab = "list";
            }
            else
            {
                var model = db.TransactionPayment.Find(id);
                //ViewBag.Tab = "details";
                return View(model);
            }
            return View();
        }

        public ActionResult popup_product_confirmation(string id = "")
        {

            if (string.IsNullOrEmpty(id))
            {
                //ViewBag.Tab = "list";
            }
            else
            {
                var get = db.Transaction.Find(id);
                var trans = new TransactionModel
                {
                    Id = get.Id,
                    Email = get.UserName,
                    ProductName = get.ProductName,
                    Total = get.GetTotalPrice()
                };
                var model = new ProductConfirmationViewModel
                {
                    TransactionId = get.Id,
                };
                ViewBag.Transaction = trans;
                return View(model);
            }
            return View();
        }
        [HttpPost]
        public async Task<ActionResult> popup_product_confirmation(ProductConfirmationViewModel model, string id = "")
        {
            string message = "";
            try
            {
                if (ModelState.IsValid)
                {
                    var get = db.Transaction.Find(model.TransactionId);
                    var vendorPayment = new VendorPayment();
                    vendorPayment.Id = vendorPayment.GenerateId("VP");
                    vendorPayment.OngkosKirim = model.OngkosKirim;
                    vendorPayment.Price = model.Price == 0 ? get.ProductPrice : model.Price;
                    vendorPayment.ResiNumber = model.ResiNumber;
                    vendorPayment.CreatedBy = "Admin";
                    vendorPayment.CreatedDate = DateTime.Now;
                    vendorPayment.UpdatedBy = "Admin";
                    vendorPayment.UpdatedDate = DateTime.Now;
                    db.VendorPayment.Add(vendorPayment);
                    get.Status = TransactionStatus.OnBuying;
                    await db.SaveChangesAsync();
                    message = " success!";
                    return Json(new
                    {
                        Obj = new { Id = get.Id },
                        Message = message,
                        IsError = false
                    });
                }
            }
            catch (Exception ex)
            {
                message = " " + ex.Message;
                return Json(new { HTMLString = RenderPartialViewToString("popup_product_confirmation", model), Message = message, IsError = true });
            }
            if (string.IsNullOrEmpty(id))
            {
                //ViewBag.Tab = "list";
            }
            else
            {
                var get = db.Transaction.Find(id);
                var trans = new TransactionModel
                {
                    Id = get.Id,
                    Email = get.UserName,
                    ProductName = get.ProductName,
                    Total = get.GetTotalPrice()
                };
                ViewBag.Transaction = trans;
            }
            message = " your form not completed!";
            return Json(new { HTMLString = RenderPartialViewToString("popup_product_confirmation", model), Message = message, IsError = true });
        }

        public ActionResult popup_product_delivery(string id = "")
        {

            if (string.IsNullOrEmpty(id))
            {
                //ViewBag.Tab = "list";
            }
            else
            {
                var get = db.Transaction.Find(id);
                var trans = new TransactionModel
                {
                    Id = get.Id,
                    Email = get.UserName,
                    ProductName = get.ProductName,
                    Address = get.DestinationAddress + ", " + get.Kecamatan + ", " + get.Kelurahan + ", " + get.City,                   
                    Total = get.GetTotalPrice()
                };
                var model = new ProductDeliveryViewModel
                {
                    TransactionId = get.Id,
                };
                ViewBag.Transaction = trans;
                return View(model);
            }
            return View();
        }
        [HttpPost]
        public async Task<ActionResult> popup_product_delivery(ProductDeliveryViewModel model, string id = "")
        {
            string message = "";
            try
            {
                if (ModelState.IsValid)
                {
                    var get = db.Transaction.Find(model.TransactionId);
                    get.ResiNumber = model.ResiNumber;
                    get.Status = TransactionStatus.OnDelivering;
                    get.UpdatedBy = "Admin";
                    get.UpdatedDate = DateTime.Now;
                    await db.SaveChangesAsync();
                    message = " success!";
                    return Json(new
                    {
                        Obj = new
                        {
                            Id = get.Id,
                            Deadline = get.TanggalKirim.ToShortDateString(),
                            Address=get.DestinationAddress+", "+get.Kecamatan+", "+get.Kelurahan+", "+get.City,
                            Email = get.UserName,
                            Total = get.GetTotalPrice(),
                            ResiNumber = get.ResiNumber
                        },
                        Message = message,
                        IsError = false
                    });
                }
            }
            catch (Exception ex)
            {
                message = " " + ex.Message;
                return Json(new { HTMLString = RenderPartialViewToString("popup_product_delivery", model), Message = message, IsError = true });
            }
            if (string.IsNullOrEmpty(id))
            {
                //ViewBag.Tab = "list";
            }
            else
            {
                var get = db.Transaction.Find(id);
                var trans = new TransactionModel
                {
                    Id = get.Id,
                    Email = get.UserName,
                    ProductName = get.ProductName,
                    Total = get.GetTotalPrice()
                };
                ViewBag.Transaction = trans;
            }
            message = " your form not completed!";
            return Json(new { HTMLString = RenderPartialViewToString("popup_product_delivery", model), Message = message, IsError = true });
        }

        public ActionResult popup_transaction_success_confirm(string id = "")
        {

            if (string.IsNullOrEmpty(id))
            {
                //ViewBag.Tab = "list";
            }
            else
            {

                var get = db.Transaction.Find(id);
                var model = new TransactionSuccessConfirmViewModel();
                model.TransactionId = get.Id;
                ViewBag.TransactionId = id;
                return View(model);
            }
            return View();
        }
        [HttpPost]
        public async Task<ActionResult> popup_transaction_success_confirm(TransactionSuccessConfirmViewModel model, string id = "")
        {
            string message = "";
            try
            {
                if (ModelState.IsValid)
                {
                    var get = db.Transaction.Find(model.TransactionId);
                    get.Status = TransactionStatus.CompletedAdmin;
                    get.UpdatedBy = "Admin";
                    get.UpdatedDate = DateTime.Now;
                    await db.SaveChangesAsync();
                    message = " success!";
                    return Json(new
                    {
                        Obj=new{Id=get.Id},
                        Message = message,
                        IsError = false
                    });
                }
            }
            catch (Exception ex)
            {
                message = " " + ex.Message;
            }
            return Json(new { HTMLString = RenderPartialViewToString("popup_transaction_success_confirm", model), Message = message, IsError = true });
        }

        public ActionResult popup_payment_confirmation(string id = "")
        {

            if (string.IsNullOrEmpty(id))
            {
                //ViewBag.Tab = "list";
            }
            else
            {
                var get = db.TransactionPayment.Find(id);
                var model = new PaymentConfirmationViewModel
                {
                    PaymentId = get.Id
                };
                ViewBag.Payment = get;
                return View(model);
            }
            return View();
        }

        [HttpPost]
        public async Task<ActionResult> popup_payment_confirmation(PaymentConfirmationViewModel model, string id = "")
        {
            string message = "";
            try {
                if (ModelState.IsValid)
                {
                    var get = db.TransactionPayment.Find(model.PaymentId);
                    get.Remarks+= " - Admin: " + (string.IsNullOrEmpty( model.Remarks)?"OK":model.Remarks);
                    get.StatusPembayaran = model.Status;
                    get.UpdatedBy = "Admin";
                    get.UpdatedDate = DateTime.Now;
                    var trans = db.Transaction.Find(get.TransactionId);
                    if (model.Status == TransactionPaymentStatus.Valid)
                    {
                        var total = trans.GetTotalPrice();
                        var allPaymentTotal = trans.TransactionPayments.Where(e => e.StatusPembayaran == TransactionPaymentStatus.Valid || e.StatusPembayaran == TransactionPaymentStatus.UnderPayment).Sum(e => e.TotalDiBayar);
                        if (allPaymentTotal >= total)
                        {
                            trans.Status = TransactionStatus.InventoryChecking;
                            trans.UpdatedBy = "Admin";
                            trans.UpdatedDate = DateTime.Now;
                        }
                       
                    }
                    else if (model.Status == TransactionPaymentStatus.UnderPayment)
                    {
                        get.TotalDiBayar = model.KoreksiTotalBayar;
                        if (!trans.IsGroup)
                            trans.Status = TransactionStatus.UnderPayment;
                    }
                    await db.SaveChangesAsync();
                    message = " success!";
                    return Json(new { Obj = new {Date=get.TanggalPembayaran.ToShortDateString(),
                        Username=get.user.Email,
                        NoRekening=get.NoRekening,
                        NamaBank=get.NamaBank,
                        NoRekeningTujuan=get.NoRekeningTujuan,
                        NamaBankTujuan=get.NamaBankTujuan,
                        Total=get.TotalDiBayar,
                        Status=get.StatusPembayaran,
                        Id=get.Id
                    },
                        Message = message, IsError = false });
                }
            }
            catch (Exception ex)
            {
                message = " " + ex.Message;
                return Json(new { HTMLString = RenderPartialViewToString("popup_payment_confirmation", model), Message = message, IsError = true });               
            }
            if (string.IsNullOrEmpty(id))
            {
                //ViewBag.Tab = "list";
            }
            else
            {
                var get = db.TransactionPayment.Find(id);
                ViewBag.Payment = get;
            }
            message = " your form not completed!";
            return Json(new { HTMLString = RenderPartialViewToString("popup_payment_confirmation", model), Message = message, IsError = true });
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
