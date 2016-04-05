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
        const int MaxDisplay = 10;
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
        #region All

        public ActionResult All(int page = 1, string status = "All", string sortby = "0")
        {
            var statusFilter = status == "All" ? "" : status;
            var transaction = db.Transaction.ToList();
            if (!string.IsNullOrEmpty(statusFilter))
                transaction = transaction.Where(e => e.Status.ToLower().Contains(statusFilter.ToLower())).ToList();

            switch (sortby)
            {
                case "0": transaction = transaction.OrderByDescending(e => e.TransDate).ToList();
                    break;
                case "1": transaction = transaction.OrderBy(e => e.TransDate).ToList();
                    break;
                case "2": transaction = transaction.OrderBy(e => e.GetTotalPrice()).ToList();
                    break;
                case "3": transaction = transaction.OrderByDescending(e => e.GetTotalPrice()).ToList();
                    break;
                case "4": transaction = transaction.OrderBy(e => e.TanggalKirim).ToList();
                    break;
                case "5": transaction = transaction.OrderByDescending(e => e.TanggalKirim).ToList();
                    break;
                default: transaction = transaction.OrderBy(e => e.TransDate).ToList();
                    break;
            }
            List<TransactionModel> list = new List<TransactionModel>();
            PaginationViewModel pagination = new PaginationViewModel(MaxDisplay, page, transaction.Count);
            int start = pagination.StartIndex() < 0 ? 0 : pagination.StartIndex();
            int end = pagination.EndIndex();
            for (int i = start; i < end; i++)
            {
                var item = transaction[i];
                var a = new TransactionModel
                {
                    Id = item.Id,
                    Date = item.TransDate,
                    Deadline = item.TanggalKirim,
                    Email = item.UserName,
                    IsGroup = item.IsGroup,
                    Total = item.GetTotalPrice(),
                    TotalTransfered = item.TransactionPayments.Where(p => p.StatusPembayaran == TransactionPaymentStatus.Valid || p.StatusPembayaran == TransactionPaymentStatus.UnderPayment).Sum(x => x.TotalDiBayar),
                    Status = item.Status
                };
                list.Add(a);
            }
            pagination.NextPageLink = Url.Action("all", new { page = pagination.NextPage(), status = status, sortby = sortby });
            pagination.PrevPageLink = Url.Action("all", new { page = pagination.PrevPage(), status = status, sortby = sortby });
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
            ViewBag.Pagination = pagination;
            var model = new AllTransactionFilterViewModel()
            {
                Status = status,
                SortBy = sortby
            };
            return View(model);
        }
        
        [HttpPost]
        public ActionResult All(AllTransactionFilterViewModel model)
        {
            var statusFilter = model.Status == "All" ? "" : model.Status;
            var transaction = db.Transaction.ToList();

            if (!string.IsNullOrEmpty(statusFilter))
                transaction = transaction.Where(e => e.Status.ToLower().Contains(statusFilter.ToLower())).ToList();
            switch (model.SortBy)
            {
                case "0": transaction = transaction.OrderByDescending(e => e.TransDate).ToList();
                    break;
                case "1": transaction = transaction.OrderBy(e => e.TransDate).ToList();
                    break;
                case "2": transaction = transaction.OrderBy(e => e.GetTotalPrice()).ToList();
                    break;
                case "3": transaction = transaction.OrderByDescending(e => e.GetTotalPrice()).ToList();
                    break;
                case "4": transaction = transaction.OrderBy(e => e.TanggalKirim).ToList();
                    break;
                case "5": transaction = transaction.OrderByDescending(e => e.TanggalKirim).ToList();
                    break;
                default: transaction = transaction.OrderBy(e => e.TransDate).ToList();
                    break;
            }
            List<TransactionModel> list = new List<TransactionModel>();
            PaginationViewModel pagination = new PaginationViewModel(MaxDisplay, 1, transaction.Count);
            int start = pagination.StartIndex() < 0 ? 0 : pagination.StartIndex();
            int end = pagination.EndIndex();
            for (int i = start; i < end; i++)
            {
                var item = transaction[i];
                var a = new TransactionModel
                {
                    Id = item.Id,
                    Date = item.TransDate,
                    Deadline = item.TanggalKirim,
                    Email = item.UserName,
                    IsGroup = item.IsGroup,
                    Total = item.GetTotalPrice(),
                    TotalTransfered = item.TransactionPayments.Where(p => p.StatusPembayaran == TransactionPaymentStatus.Valid || p.StatusPembayaran == TransactionPaymentStatus.UnderPayment).Sum(x => x.TotalDiBayar),
                    Status = item.Status
                };
                list.Add(a);
            }

            pagination.NextPageLink = Url.Action("all", new { page = pagination.NextPage(), status = model.Status, sortby = model.SortBy });
            pagination.PrevPageLink = Url.Action("all", new { page = pagination.PrevPage(), status = model.Status, sortby = model.SortBy });
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
            ViewBag.Pagination = pagination;
            return View(model);
        }
        
        #endregion

        #region Payment Checking

        public ActionResult PaymentChecking()
        {
            return View();
        }
        public ActionResult tab_paymentlist(int page = 1, string bank = "")
        {
            bank = bank == "All" ? "" : bank;
            var transaction = db.TransactionPayment.ToList();
            transaction = transaction.Where(e => e.StatusPembayaran == "" && e.NamaBankTujuan.ToLower().Contains(bank.ToLower())).ToList();
            PaginationViewModel pagination = new PaginationViewModel(MaxDisplay, page, transaction.Count);
            int start = pagination.StartIndex() < 0 ? 0 : pagination.StartIndex();
            int end = pagination.EndIndex();
            var list = new List<TransactionPayment>();
            for (int i = start; i < end; i++)
            {
                list.Add(transaction[i]);
            }
            pagination.NextPageLink = "javascript:goToPage('#paymentlist .contentplaceholder','" + Url.Action("tab_paymentlist") + "','#paymentlist select'," + pagination.NextPage() + ")";
            pagination.PrevPageLink = "javascript:goToPage('#paymentlist .contentplaceholder','" + Url.Action("tab_paymentlist") + "','#paymentlist select'," + pagination.PrevPage() + ")";
            ViewBag.PaymentCheckingList = list;
            ViewBag.Pagination = pagination;
            return View();

        }
        public ActionResult tab_underpaymentlist(int page = 1, string bank = "")
        {
            bank = bank == "All" ? "" : bank;
            var transaction = db.TransactionPayment.ToList();
            transaction = transaction.Where(e => e.StatusPembayaran == TransactionPaymentStatus.UnderPayment && e.NamaBankTujuan.ToLower().Contains(bank.ToLower())).ToList();
            PaginationViewModel pagination = new PaginationViewModel(MaxDisplay, page, transaction.Count);
            int start = pagination.StartIndex() < 0 ? 0 : pagination.StartIndex();
            int end = pagination.EndIndex();
            var list = new List<TransactionPayment>();
            for (int i = start; i < end; i++)
            {
                list.Add(transaction[i]);
            }
            pagination.NextPageLink = "javascript:goToPage('#underpaymentlist .contentplaceholder','" + Url.Action("tab_underpaymentlist") + "','#underpaymentlist select'," + pagination.NextPage() + ");";
            pagination.PrevPageLink = "javascript:goToPage('#underpaymentlist .contentplaceholder','" + Url.Action("tab_underpaymentlist") + "','#underpaymentlist select'," + pagination.PrevPage() + ");";
            ViewBag.UnderPaymentList = list;
            ViewBag.Pagination = pagination;
            return View();

        }
        public ActionResult tab_validpaymentlist(int page = 1, string bank = "")
        {
            bank = bank == "All" ? "" : bank;
            var transaction = db.TransactionPayment.ToList();
            transaction = transaction.Where(e => e.StatusPembayaran == TransactionPaymentStatus.Valid && e.NamaBankTujuan.ToLower().Contains(bank.ToLower())).ToList();
            PaginationViewModel pagination = new PaginationViewModel(MaxDisplay, page, transaction.Count);
            int start = pagination.StartIndex() < 0 ? 0 : pagination.StartIndex();
            int end = pagination.EndIndex();
            var list = new List<TransactionPayment>();
            for (int i = start; i < end; i++)
            {
                list.Add(transaction[i]);
            }
            pagination.NextPageLink = "javascript:goToPage('#validpaymentlist .contentplaceholder','" + Url.Action("tab_validpaymentlist") + "','#validpaymentlist select'," + pagination.NextPage() + ");";
            pagination.PrevPageLink = "javascript:goToPage('#validpaymentlist .contentplaceholder','" + Url.Action("tab_validpaymentlist") + "','#validpaymentlist select'," + pagination.PrevPage() + ");";
            ViewBag.ValidPaymentList = list;
            ViewBag.Pagination = pagination;
            return View();

        }
        public ActionResult tab_notvalidpaymentlist(int page = 1, string bank = "")
        {
            bank = bank == "All" ? "" : bank;
            var transaction = db.TransactionPayment.ToList();
            transaction = transaction.Where(e => e.StatusPembayaran == TransactionPaymentStatus.NotValid && e.NamaBankTujuan.ToLower().Contains(bank.ToLower())).ToList();
            PaginationViewModel pagination = new PaginationViewModel(MaxDisplay, page, transaction.Count);
            int start = pagination.StartIndex() < 0 ? 0 : pagination.StartIndex();
            int end = pagination.EndIndex();
            var list = new List<TransactionPayment>();
            for (int i = start; i < end; i++)
            {
                list.Add(transaction[i]);
            }
            pagination.NextPageLink = "javascript:goToPage('#notvalidpaymentlist .contentplaceholder','" + Url.Action("tab_notvalidpaymentlist") + "','#notvalidpaymentlist select'," + pagination.NextPage() + ");";
            pagination.PrevPageLink = "javascript:goToPage('#notvalidpaymentlist .contentplaceholder','" + Url.Action("tab_notvalidpaymentlist") + "','#notvalidpaymentlist select'," + pagination.PrevPage() + ");";
            ViewBag.NotValidPaymentList = list;
            ViewBag.Pagination = pagination;
            return View();

        }

        #endregion

        #region Outstanding

        public ActionResult Outstanding()
        {
            return View();
        }

        public ActionResult tab_waitingprocess(int page = 1, string sortby = "0", string email = "", string vendorname = "")
        {
            var transaction = db.Transaction.Where(e => e.Status == TransactionStatus.InventoryChecking).ToList();
            
            transaction = transaction.Where(e => e.UserName.ToLower().Contains(email.ToLower())).ToList();
            switch (sortby)
            {
                case "0": transaction = transaction.OrderByDescending(e => e.TransDate).ToList();
                    break;
                case "1": transaction = transaction.OrderBy(e => e.TransDate).ToList();
                    break;
                case "2": transaction = transaction.OrderBy(e => e.GetTotalPrice()).ToList();
                    break;
                case "3": transaction = transaction.OrderByDescending(e => e.GetTotalPrice()).ToList();
                    break;
                case "4": transaction = transaction.OrderBy(e => e.TanggalKirim).ToList();
                    break;
                case "5": transaction = transaction.OrderByDescending(e => e.TanggalKirim).ToList();
                    break;
                default: transaction = transaction.OrderBy(e => e.TransDate).ToList();
                    break;
            }
            var payment = db.VendorPayment.Where(e => !e.IsPaid).ToList();
            var transactionJoinPayment = (from t in transaction
                                          join p in payment
                                          on t.Id equals p.TransactionId
                                          select new OutstandingViewModel
                                          {
                                              Id = t.Id,
                                              VendorPaymentId=p.Id,
                                              Date = t.UpdatedDate,
                                              Email = t.UserName,
                                              Deadline = t.TanggalKirim,
                                              ProductName = t.ProductName,
                                              Total = t.GetTotalPrice(),
                                              VendorName = t.StoreName,
                                              IsAccepted = p.IsAccepted,
                                              IsDeliver = p.IsDeliver,
                                              IsDelivered = p.IsDelivered
                                          }).ToList();
            List<OutstandingViewModel> list = new List<OutstandingViewModel>();
            foreach (var item in transaction)
            {
                bool found = false;
                foreach (var item2 in transactionJoinPayment)
                {
                    if (!item2.IsAccepted)
                        item2.Status = "Rejected";
                    else
                    {
                        if (item2.IsAccepted)
                        {
                            item2.Status = "Waiting to Deliver";
                            if (item2.IsDeliver && item2.IsDelivered)
                            {
                                item2.Status = "Accepted by Pickkado";
                            }
                            else if (item2.IsDeliver && !item2.IsDelivered)
                                item2.Status = "On Delivering";
                        }

                    }
                    list.Add(item2);
                    found = true;
                    break;
                }
                if (!found)
                {
                    var a = new OutstandingViewModel
                    {
                        Id = item.Id,
                        VendorPaymentId = "",
                        Date = item.UpdatedDate,
                        Email = item.UserName,
                        Deadline = item.TanggalKirim,
                        ProductName = item.ProductName,
                        Total = item.GetTotalPrice(),
                        VendorName = item.StoreName,
                        IsAccepted = false,
                        IsDeliver = false,
                        IsDelivered = false,
                        Status="Waiting for Vendor's Response"
                    };
                    list.Add(a);
                }
            }
            PaginationViewModel pagination = new PaginationViewModel(MaxDisplay, page, transaction.Count);
            int start = pagination.StartIndex() < 0 ? 0 : pagination.StartIndex();
            int end = pagination.EndIndex();
            List<OutstandingViewModel> list2 = new List<OutstandingViewModel>();
            for (int i = start; i < end; i++)
            {
                var item = list[i];
                list2.Add(item);
            }
            pagination.NextPageLink = "javascript:goToPage('#waitinglist .card-body','" + Url.Action("tab_onprocess", new { sortby = sortby, email = email, vendorname = vendorname }) + "'," + pagination.NextPage() + ")";
            pagination.PrevPageLink = "javascript:goToPage('#waitinglist .card-body','" + Url.Action("tab_onprocess", new { sortby = sortby, email = email, vendorname = vendorname }) + "'," + pagination.PrevPage() + ")";

            ViewBag.List = list2;
            ViewBag.Pagination = pagination;
            var model = new OnProcessTransactionFilterViewModel()
            {
                VendorName = vendorname,
                SortBy = sortby,
                Email = email
            };
            return View(model);
        }
        [HttpPost]
        public ActionResult tab_waitingprocess(OnProcessTransactionFilterViewModel model)
        {
            var transaction = db.Transaction.Where(e => e.Status != TransactionStatus.InventoryChecking).ToList();
            string emailFilter = string.IsNullOrEmpty(model.Email) ? "" : model.Email;
            transaction = transaction.Where(e => e.UserName.ToLower().Contains(emailFilter.ToLower())).ToList();
            switch (model.SortBy)
            {
                case "0": transaction = transaction.OrderByDescending(e => e.TransDate).ToList();
                    break;
                case "1": transaction = transaction.OrderBy(e => e.TransDate).ToList();
                    break;
                case "2": transaction = transaction.OrderBy(e => e.GetTotalPrice()).ToList();
                    break;
                case "3": transaction = transaction.OrderByDescending(e => e.GetTotalPrice()).ToList();
                    break;
                case "4": transaction = transaction.OrderBy(e => e.TanggalKirim).ToList();
                    break;
                case "5": transaction = transaction.OrderByDescending(e => e.TanggalKirim).ToList();
                    break;
                default: transaction = transaction.OrderBy(e => e.TransDate).ToList();
                    break;
            } 
            var payment = db.VendorPayment.Where(e => !e.IsPaid).ToList();
            var transactionJoinPayment = (from t in transaction
                                          join p in payment
                                          on t.Id equals p.TransactionId
                                          select new OutstandingViewModel
                                          {
                                              Id = t.Id,
                                              VendorPaymentId = p.Id,
                                              Date = t.UpdatedDate,
                                              Email = t.UserName,
                                              Deadline = t.TanggalKirim,
                                              ProductName = t.ProductName,
                                              Total = t.GetTotalPrice(),
                                              VendorName = t.StoreName,
                                              IsAccepted = p.IsAccepted,
                                              IsDeliver = p.IsDeliver,
                                              IsDelivered = p.IsDelivered
                                          }).ToList();
            List<OutstandingViewModel> list = new List<OutstandingViewModel>();
            foreach (var item in transaction)
            {
                bool found = false;
                foreach (var item2 in transactionJoinPayment)
                {
                    if (!item2.IsAccepted)
                        item2.Status = "Rejected";
                    else
                    {
                        if (item2.IsAccepted)
                        {
                            item2.Status = "Waiting to Deliver";
                            if (item2.IsDeliver && item2.IsDelivered)
                            {
                                item2.Status = "Accepted by Pickkado";
                            }
                            else if (item2.IsDeliver && !item2.IsDelivered)
                                item2.Status = "On Delivering";
                        }

                    }
                    list.Add(item2);
                    found = true;
                    break;
                }
                if (!found)
                {
                    var a = new OutstandingViewModel
                    {
                        Id = item.Id,
                        VendorPaymentId = "",
                        Date = item.UpdatedDate,
                        Email = item.UserName,
                        Deadline = item.TanggalKirim,
                        ProductName = item.ProductName,
                        Total = item.GetTotalPrice(),
                        VendorName = item.StoreName,
                        IsAccepted = false,
                        IsDeliver = false,
                        IsDelivered = false,
                        Status = "Waiting for Vendor's Response"
                    };
                    list.Add(a);
                }
            }
            List<OutstandingViewModel> list2 = new List<OutstandingViewModel>();
            PaginationViewModel pagination = new PaginationViewModel(MaxDisplay, 1, transaction.Count);
            int start = pagination.StartIndex() < 0 ? 0 : pagination.StartIndex();
            int end = pagination.EndIndex();
            for (int i = start; i < end; i++)
            {
                var item = list[i];
                list2.Add(item);
            }
            pagination.NextPageLink = "javascript:goToPage('#waitinglist .card-body','" + Url.Action("tab_onprocess", new { sortby = model.SortBy, email = model.Email, vendorname = model.VendorName }) + "'," + pagination.NextPage() + ")";
            pagination.PrevPageLink = "javascript:goToPage('#waitinglist .card-body','" + Url.Action("tab_onprocess", new { sortby = model.SortBy, email = model.Email, vendorname = model.VendorName }) + "'," + pagination.PrevPage() + ")";

            ViewBag.List = list;
            ViewBag.Pagination = pagination;
            return View(model);
        }
        #endregion

        #region On Process

        public ActionResult Onprocess()
        {
            var transaction = db.Transaction.OrderBy(e => e.UpdatedDate).ToList();
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

        public ActionResult tab_onprocess(int page = 1, string sortby = "0", string email = "", string vendorname = "")
        {
            var transaction = db.Transaction.Where(e => e.Status == TransactionStatus.OnBuying).ToList();
            transaction = transaction.Where(e => e.UserName.ToLower().Contains(email.ToLower())).ToList();
            switch (sortby)
            {
                case "0": transaction = transaction.OrderByDescending(e => e.TransDate).ToList();
                    break;
                case "1": transaction = transaction.OrderBy(e => e.TransDate).ToList();
                    break;
                case "2": transaction = transaction.OrderBy(e => e.GetTotalPrice()).ToList();
                    break;
                case "3": transaction = transaction.OrderByDescending(e => e.GetTotalPrice()).ToList();
                    break;
                case "4": transaction = transaction.OrderBy(e => e.TanggalKirim).ToList();
                    break;
                case "5": transaction = transaction.OrderByDescending(e => e.TanggalKirim).ToList();
                    break;
                default: transaction = transaction.OrderBy(e => e.TransDate).ToList();
                    break;
            }
            List<TransactionModel> list = new List<TransactionModel>();
            PaginationViewModel pagination = new PaginationViewModel(MaxDisplay, page, transaction.Count);
            int start = pagination.StartIndex() < 0 ? 0 : pagination.StartIndex();
            int end = pagination.EndIndex();
            for (int i = start; i < end; i++)
            {
                var item = transaction[i];
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
            pagination.NextPageLink = "javascript:goToPage('#list .card-body','" + Url.Action("tab_onprocess", new { sortby = sortby, email = email, vendorname = vendorname }) + "'," + pagination.NextPage() + ")";
            pagination.PrevPageLink = "javascript:goToPage('#list .card-body','" + Url.Action("tab_onprocess", new { sortby = sortby, email = email, vendorname = vendorname }) + "'," + pagination.PrevPage() + ")";

            ViewBag.List = list;
            ViewBag.Pagination = pagination;
            var model = new OnProcessTransactionFilterViewModel()
            {
                VendorName = vendorname,
                SortBy = sortby,
                Email = email
            };
            return View(model);
        }
        [HttpPost]
        public ActionResult tab_onprocess(OnProcessTransactionFilterViewModel model)
        {
            var transaction = db.Transaction.Where(e => e.Status == TransactionStatus.OnBuying).ToList();
            string emailFilter = string.IsNullOrEmpty(model.Email) ? "" : model.Email;
            transaction = transaction.Where(e => e.UserName.ToLower().Contains(emailFilter.ToLower())).ToList();
            switch (model.SortBy)
            {
                case "0": transaction = transaction.OrderByDescending(e => e.TransDate).ToList();
                    break;
                case "1": transaction = transaction.OrderBy(e => e.TransDate).ToList();
                    break;
                case "2": transaction = transaction.OrderBy(e => e.GetTotalPrice()).ToList();
                    break;
                case "3": transaction = transaction.OrderByDescending(e => e.GetTotalPrice()).ToList();
                    break;
                case "4": transaction = transaction.OrderBy(e => e.TanggalKirim).ToList();
                    break;
                case "5": transaction = transaction.OrderByDescending(e => e.TanggalKirim).ToList();
                    break;
                default: transaction = transaction.OrderBy(e => e.TransDate).ToList();
                    break;
            }
            List<TransactionModel> list = new List<TransactionModel>();
            PaginationViewModel pagination = new PaginationViewModel(MaxDisplay, 1, transaction.Count);
            int start = pagination.StartIndex() < 0 ? 0 : pagination.StartIndex();
            int end = pagination.EndIndex();
            for (int i = start; i < end; i++)
            {
                var item = transaction[i];
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
            pagination.NextPageLink = "javascript:goToPage('#list .card-body','" + Url.Action("tab_onprocess", new { sortby = model.SortBy, email = model.Email, vendorname = model.VendorName }) + "'," + pagination.NextPage() + ")";
            pagination.PrevPageLink = "javascript:goToPage('#list .card-body','" + Url.Action("tab_onprocess", new { sortby = model.SortBy, email = model.Email, vendorname = model.VendorName }) + "'," + pagination.PrevPage() + ")";

            ViewBag.List = list;
            ViewBag.Pagination = pagination;
            return View(model);
        }

        public ActionResult tab_deliveryprocess(int page = 1, string sortby = "0", string email = "", string vendorname = "", string noresi="")
        {
            var transaction = db.Transaction.Where(e => e.Status == TransactionStatus.OnDelivering).ToList();
            transaction = transaction.Where(e =>
                e.UserName.ToLower().Contains(email.ToLower())
                && (string.IsNullOrEmpty(e.ResiNumber)? true : e.ResiNumber.ToLower().Contains(noresi.ToLower()))).ToList();
            switch (sortby)
            {
                case "0": transaction = transaction.OrderByDescending(e => e.TransDate).ToList();
                    break;
                case "1": transaction = transaction.OrderBy(e => e.TransDate).ToList();
                    break;
                case "2": transaction = transaction.OrderBy(e => e.GetTotalPrice()).ToList();
                    break;
                case "3": transaction = transaction.OrderByDescending(e => e.GetTotalPrice()).ToList();
                    break;
                case "4": transaction = transaction.OrderBy(e => e.TanggalKirim).ToList();
                    break;
                case "5": transaction = transaction.OrderByDescending(e => e.TanggalKirim).ToList();
                    break;
                default: transaction = transaction.OrderBy(e => e.TransDate).ToList();
                    break;
            }
            List<TransactionModel> list = new List<TransactionModel>();
            PaginationViewModel pagination = new PaginationViewModel(MaxDisplay, page, transaction.Count);
            int start = pagination.StartIndex() < 0 ? 0 : pagination.StartIndex();
            int end = pagination.EndIndex();
            for (int i = start; i < end; i++)
            {
                var item = transaction[i];
                var a = new TransactionModel
                {
                    Id = item.Id,
                    Email = item.UserName,
                    Deadline = item.TanggalKirim,
                    Total = item.GetTotalPrice(),
                    Address = item.DestinationAddress + ", " + item.Kecamatan + ", " + item.Kelurahan + ", " + item.City,
                    ResiNumber = item.ResiNumber??""
                };
                list.Add(a);
            }
            pagination.NextPageLink = "javascript:goToPage('#deliverprocesslist .card-body','" + Url.Action("tab_deliveryprocess", new {noresi=noresi, sortby = sortby, email = email, vendorname = vendorname }) + "'," + pagination.NextPage() + ")";
            pagination.PrevPageLink = "javascript:goToPage('#deliverprocesslist .card-body','" + Url.Action("tab_deliveryprocess", new {noresi=noresi, sortby = sortby, email = email, vendorname = vendorname }) + "'," + pagination.PrevPage() + ")";

            ViewBag.DeliveringList = list;
            ViewBag.Pagination = pagination;
            var model = new DeliveryProcessTransactionFilterViewModel()
            {
                VendorName = vendorname,
                NoResi=noresi,
                SortBy = sortby,
                Email = email
            };
            return View(model);
        }
        [HttpPost]
        public ActionResult tab_deliveryprocess(DeliveryProcessTransactionFilterViewModel model)
        {
            var transaction = db.Transaction.Where(e => e.Status == TransactionStatus.OnDelivering).ToList();
            string emailFilter = string.IsNullOrEmpty(model.Email) ? "" : model.Email;
            string noresiFilter = string.IsNullOrEmpty(model.NoResi) ? "" : model.NoResi;
            transaction = transaction.Where(e =>
                e.UserName.ToLower().Contains(emailFilter.ToLower())
                && (string.IsNullOrEmpty(e.ResiNumber) ? true : e.ResiNumber.ToLower().Contains(noresiFilter.ToLower()))).ToList();
            switch (model.SortBy)
            {
                case "0": transaction = transaction.OrderByDescending(e => e.TransDate).ToList();
                    break;
                case "1": transaction = transaction.OrderBy(e => e.TransDate).ToList();
                    break;
                case "2": transaction = transaction.OrderBy(e => e.GetTotalPrice()).ToList();
                    break;
                case "3": transaction = transaction.OrderByDescending(e => e.GetTotalPrice()).ToList();
                    break;
                case "4": transaction = transaction.OrderBy(e => e.TanggalKirim).ToList();
                    break;
                case "5": transaction = transaction.OrderByDescending(e => e.TanggalKirim).ToList();
                    break;
                default: transaction = transaction.OrderBy(e => e.TransDate).ToList();
                    break;
            }
            List<TransactionModel> list = new List<TransactionModel>();
            PaginationViewModel pagination = new PaginationViewModel(MaxDisplay, 1, transaction.Count);
            int start = pagination.StartIndex() < 0 ? 0 : pagination.StartIndex();
            int end = pagination.EndIndex();
            for (int i = start; i < end; i++)
            {
                var item = transaction[i];
                var a = new TransactionModel
                {
                    Id = item.Id,
                    Email = item.UserName,
                    Deadline = item.TanggalKirim,
                    Total = item.GetTotalPrice(),
                    Address = item.DestinationAddress + ", " + item.Kecamatan + ", " + item.Kelurahan + ", " + item.City,
                    ResiNumber = item.ResiNumber??""
                };
                list.Add(a);
            }
            pagination.NextPageLink = "javascript:goToPage('#deliverprocesslist .card-body','" + Url.Action("tab_deliveryprocess", new { noresi = model.NoResi, sortby = model.SortBy, email = model.Email, vendorname = model.VendorName }) + "'," + pagination.NextPage() + ")";
            pagination.PrevPageLink = "javascript:goToPage('#deliverprocesslist .card-body','" + Url.Action("tab_deliveryprocess", new { noresi = model.NoResi, sortby = model.SortBy, email = model.Email, vendorname = model.VendorName }) + "'," + pagination.PrevPage() + ")";

            ViewBag.DeliveringList = list;
            ViewBag.Pagination = pagination;
            return View(model);
        }

        #endregion

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
