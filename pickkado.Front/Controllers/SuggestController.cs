using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using pickkado.Front.Models;
using ServiceStack;

namespace pickkado.Front.Controllers
{
    public class SuggestController : Controller
    {
        pickkado.Front.Db.PickkadoDBContext db = new pickkado.Front.Db.PickkadoDBContext();
        //
        // GET: /Suggest/
        [HttpGet]
        public ActionResult Index()
        {
            //JsonServiceClient client = new JsonServiceClient("http://localhost:55850/api/");
            //var response = client.Send(new CategoryRequest());
            ViewBag.CategoryList = db.Category.OrderBy(m=>m.Name).ToList();
            return View();
        }
        [HttpPost]
        public ActionResult Index(CategoryViewModel model)
        {
            if (ModelState.IsValid)
            {
                return RedirectToAction("result");
            }
            //JsonServiceClient client = new JsonServiceClient("http://localhost:55850/api/");
            //var response = client.Send(new CategoryRequest());
            //ViewBag.CategoryList = response.Result.OrderBy(m => m.Name);
            
            ViewBag.CategoryList = db.Category.OrderBy(m => m.Name).ToList();
            return View();
        }

        public ActionResult category_partial()
        {
            return View();
        }

        //
        // GET: /Suggest/Result

        public ActionResult Result()
        {
            return View();
        }

        //
        // GET: /Suggest/Details

        public ActionResult Details()
        {
            return View();
        }

        //
        // GET: /Suggest/Invite

        public ActionResult Invite()
        {
            return View();
        }

        //
        // GET: /Suggest/Package
        [HttpGet]
        public ActionResult Package(string returnUrl)
        {
            PackageViewModel model=new PackageViewModel();
            var packagePartial = new PackagePartialView()
            {
                List = db.Package.Where(e => e.Visible && e.Quantity > 0).OrderBy(m => m.Name).ToList(),
                PackageSelected = model.PackageId
            };
            var giftcardPartial = new GiftCardPartialView()
            {
                List = db.GiftCard.Where(e => e.Visible&&e.Quantity>0).OrderBy(m => m.Name).ToList(),
                GiftcardSelected = ""
            };
            ViewBag.LinkBack = returnUrl;
            ViewBag.PackagePartialView = packagePartial;
            ViewBag.GiftcardPartialView = giftcardPartial;
            return View();
            //if (Session["Transaction"] != null)
            //{
            //    var tran = (TransactionModel)Session["Transaction"];
            //    if (tran.packageInfo != null)
            //    {
            //        model = tran.packageInfo;
            //        ViewBag.PackageId = model.PackageId;
            //        var packagePartial = new PackagePartialView()
            //        {
            //            List = db.Package.Where(e => e.Visible).OrderBy(m => m.Name).ToList(),
            //            PackageSelected = model.PackageId
            //        };
            //        ViewBag.LinkBack = returnUrl;
            //        ViewBag.PackagePartialView = packagePartial;
            //        return View(model);
            //    }
            //    else
            //    {
            //        var packagePartial = new PackagePartialView()
            //        {
            //            List = db.Package.Where(e => e.Visible).OrderBy(m => m.Name).ToList(),
            //            PackageSelected = model.PackageId
            //        };
            //        ViewBag.LinkBack = returnUrl;
            //        ViewBag.PackagePartialView = packagePartial;
            //        return View();
            //    }
            //}
            //return RedirectToAction("", "home");
        }

        [HttpPost]
        public ActionResult Package(PackageViewModel model,string returnUrl)
        {
            if (ModelState.IsValid)
            {
                var tran = (TransactionModel) Session["Transaction"];
                model.package = db.Package.Find(model.PackageId);
                tran.packageInfo = model;
                Session["Transaction"] = tran;
                return RedirectToAction("purchaseinformation", "payment", new {returnUrl=Request.Url.AbsoluteUri });
            }
            var packagePartial = new PackagePartialView()
            {
                List = db.Package.Where(e => e.Visible).OrderBy(m => m.Name).ToList(),
                PackageSelected = model.PackageId
            };
            ViewBag.LinkBack = returnUrl;
            ViewBag.PackagePartialView = packagePartial;

            return View();
        }

        public ActionResult package_partial()
        {
            return View();
        }


    }
}
