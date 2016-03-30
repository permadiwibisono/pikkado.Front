using pickkado.Front.Db;
using pickkado.Front.Models;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;
using Microsoft.AspNet.Identity.Owin;

namespace pickkado.Front.Controllers
{
    public class CatalogController : Controller
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
        public const string sessionName = "Transaction";
        public int block = 16;
        public int maxblock = 4;
        #endregion
        //
        // GET: /Catalog/

        public ActionResult Index()
        {
            return View();
        }

        public ActionResult Views(int category=0,string search="",int page=1)
        {
            var cate = db.Category.Find(category);
            var list = db.Category.OrderBy(m => m.Left).ToList();
            var list2 = (from l in list
                         from parent in list
                         where l.Left >= parent.Left && l.Left <= parent.Right
                         select new pickkado.Front.Areas.Admin.Models.CategoryModel
                         {
                             Id=l.Id,
                             Name = l.Name,
                             Parent = parent.Name,
                             Left=l.Left,
                             Right=l.Right
                         }).GroupBy(x =>x.Name).Select(g =>new{g.First().Id,g.First().Name,Level=g.Count()-1,g.First().Left,g.First().Right}).ToList();
            
            var productList = db.ProductVendor.ToList();
            var plist = (from item in productList
                         select new ProductCatalogModel
                         {
                             Id = item.Id,
                             Name = item.Name,
                             Price = item.Price.ToRupiah(),
                             Image = item.Thumbnails.Count > 0 ? item.Thumbnails.ElementAt(0).Image : null,
                             category = db.Category.Find(item.Categories)
                         }).Where(ex => ex.Name.ToUpper().Contains(search.ToUpper())).ToList();
            if (category != 0)
            {
                plist = plist.Where(ex => ex.category.Left <= cate.Right && ex.category.Left >= cate.Left).ToList();
            }
            else {
                cate = new Entities.Category();
                cate.Id = 0;
                cate.Left = 0;
                cate.Right = 100;
            }
            Task<string> t = new Task<string>(() => GenerateCategoryViews("", 0, list2, 0, cate));
            t.Start();
            var p = plist.ToList();
            var p1 = plist.ToList();
            var p2 = plist.ToList();
            plist.AddRange(p);
            plist.AddRange(p1);
            plist.AddRange(p2);
            //ViewBag.ProductList = plist;
            List<ProductCatalogModel> productPagingList = new List<ProductCatalogModel>();
            int end = plist.Count >= (page - 1) + block ? (page - 1) + block : plist.Count;
            for (int i = page-1; i < end; i++)
            {
                productPagingList.Add(plist[i]);
            }
            ViewBag.ProductList = productPagingList;
            ViewBag.PageCount = (plist.Count / block) + ((plist.Count % block) > 0 ? 1 : 0);
            ViewBag.MaxBlock = plist.Count < maxblock ? plist.Count : maxblock;
            ViewBag.StartIndex = page - 1;
            Task.WaitAll();
            string active = category == 0 ? "active" : "";
            //string html = "<li class=\"" + active + "\"><a class=\"link link-default\" href=\"/catalog/views?category=0\">Semua kategori</a></li>" + t.Result;
            string html = t.Result;
            ViewBag.Filter = html;
            return View();
        }

        public async Task<ActionResult> Details(string id)
        {
            var get = await GetProductAsync(id);
            if (get != null)
            {
                var model = new ProductDetailCatalogViewModel
                {
                    ProductId = get.Id,
                    Name=get.Name,
                    Price=get.Price,
                    Image=get.Thumbnail.Count>0?get.Thumbnail[0]:null,
                    Description=get.Description,
                    Weight=get.Weight,
                    CategoryName=db.Category.Find(get.Category).Name
                };

                if (Session[sessionName] != null)
                {
                    var trans = (TransactionModel)Session[sessionName];
                    model = trans.productInfo;
                }
                else
                {
                    model.AttributeSelected = new List<string>();
                    for (int i=0; i < get.MasterAttributeList.Count; i++)
                    {
                        model.AttributeSelected.Add("");
                    }
                }
                ViewBag.Title = get.Name;
                ViewBag.Product = get;
                return View(model);
            }
            else
            {
                return HttpNotFound();
            }
        }

        [HttpPost]
        public async Task<ActionResult> Details(ProductDetailCatalogViewModel model)
        {
            if (ModelState.IsValid)
            {
                var get = await GetProductAsync(model.ProductId);
                if (get != null)
                {
                    int i = 0; 
                    bool isNotValid=false;
                    foreach (var master in get.MasterAttributeList)
                    {
                        if (string.IsNullOrEmpty(model.AttributeSelected[i]))
                        {
                            ModelState.AddModelError("", master.Name + " is required. Please choose it!");
                            isNotValid = true;
                            break;
                        }
                        i++;
                    }
                    if (isNotValid)
                    {
                        ViewBag.Title = get.Name;
                        ViewBag.Product = get;
                        return View(model);
                    }
                    model.Name = get.Name;
                    model.Price = get.Price;
                    model.Image = get.Thumbnail[0];
                    model.Description = get.Description;
                    model.Weight = get.Weight;
                    model.CategoryName = db.Category.Find(get.Category).Name;
                    
                    if (Session[sessionName] == null)
                    {
                        var trans = new TransactionModel();
                        trans.TransactionType = TransactionType.Catalog;
                        trans.productInfo = model;
                        Session[sessionName] = trans;
                    }
                    else
                    {
                        var trans = (TransactionModel)Session[sessionName];
                        trans.productInfo = model;
                        Session[sessionName] = trans;
                        
                    }
                    return RedirectToAction("package", new { returnUrl = GetReturnUrl() });
                }
                else
                {
                    return HttpNotFound();
                }
            }
            else
            {
                var get = await GetProductAsync(model.ProductId);
                if (get != null)
                {
                    ViewBag.Title = get.Name;
                    ViewBag.Product = get;
                    return View(model);
                }
                else
                {
                    return HttpNotFound();
                }
            }
        }

        [HttpGet]
        public ActionResult Invite(string returnUrl)
        {
            if (Session[sessionName] != null)
            {
                var tran = (TransactionModel)Session[sessionName];
                var model = new GiftCardInviteViewModel();
                if (tran.giftcardInviteInfo != null)
                    model = tran.giftcardInviteInfo;
                ViewBag.LinkBack = returnUrl;
                ViewBag.ProductName = tran.productInfo.Name;
                return View(model);
            }
            return RedirectToAction("","home");
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Invite(GiftCardInviteViewModel model, string returnUrl)
        {
            if (Session[sessionName] != null)
            {
                var tran = (TransactionModel)Session[sessionName];
                if (ModelState.IsValid)
                {
                    // nanti masukkin ke TransactionModel. 04/03/2016
                    //if (model.FriendsGiftCard.Count > 0)
                    //{
                    //    var body = "";
                    //    using (var sr = new StreamReader(Server.MapPath("\\App_Data\\Templates\\") + "invitegiftcardmessage.txt"))
                    //    {
                    //        body = sr.ReadToEnd();
                    //    }
                    //    var pathLogo = Server.MapPath("\\Images\\") + "brand.png";
                    //    var byteLogo = System.IO.File.ReadAllBytes(pathLogo);
                    //    foreach (var i in model.FriendsGiftCard)
                    //    {
                    //        await SendEmail.SendEmailInviteToGiftcardMessage(body, byteLogo, i.Name, i.Email, "Permadi Wibisono", model.MessageToFriends, "");
                    //    }
                    //}
                    var error = "";
                    if (!string.IsNullOrEmpty(model.MessageToFriends))
                    {
                        if (model.FriendsGiftCard.Count > 0)
                        {
                            foreach (var item in model.FriendsGiftCard)
                            {
                                if (string.IsNullOrEmpty(item.Name) || string.IsNullOrEmpty(item.Email))
                                {
                                    error = "Please fulfill your friend's name and email.";
                                    break;
                                }
                            }
                        }
                    }
                    else
                    {
                        if (model.FriendsGiftCard.Count > 1)
                        {
                            foreach (var item in model.FriendsGiftCard)
                            {
                                if (!string.IsNullOrEmpty(item.Name) || !string.IsNullOrEmpty(item.Email))
                                {
                                    error = "Please fulfill your message to your friends.";
                                    break;
                                }
                            }
                        }
                        else
                        {
                            if (!string.IsNullOrEmpty(model.FriendsGiftCard[0].Name) || !string.IsNullOrEmpty(model.FriendsGiftCard[0].Name))
                            {
                                error = "Please fulfill your friend's name and email.";
                            }
                            else
                            {
                                model.FriendsGiftCard.Clear();
                            }
                        }
                    }
                    if (string.IsNullOrEmpty(error))
                    {
                        tran.giftcardInviteInfo = model;
                        return RedirectToAction("purchaseinformation", "payment", new { returnUrl = GetReturnUrl() });
                    }
                    else
                    {
                        ModelState.AddModelError("", error);
                    }
                }
                ViewBag.LinkBack = returnUrl;
                ViewBag.ProductName = tran.productInfo.Name;
                return View(model);
            }
            return RedirectToAction("", "home");
        }

        async Task<ProductDetailCatalogModel> GetProductAsync(string id)
        {
            var get = db.ProductVendor.Find(id);
            if (get != null)
            {
                var p = new ProductDetailCatalogModel
                    {
                        Id = get.Id,
                        Name = get.Name,
                        Description = get.Description,
                        Weight = get.Weight,
                        Category = get.Categories,
                        Price = get.Price.ToRupiah(),
                        Thumbnail = (from image in get.Thumbnails
                                     select image.Image).ToList(),
                        AttributeProductList = (from at in get.Attribute
                                                select new AttributeProductModel
                                                {
                                                    MasterAttributeId=at.MasterProductAttributeId,
                                                    Text = at.Value,
                                                    Value = at.Id,
                                                    Disabled=at.Disabled
                                                }).ToList(),
                        MasterAttributeList = (from mat in db.MasterProductAttribute.ToList()
                                               where (from at in get.Attribute select at.MasterProductAttributeId).Contains(mat.Id)
                                               orderby mat.Name
                                               select new MasterAttributeProductModel
                                               {
                                                   Id = mat.Id,
                                                   Name = mat.Name
                                               }).ToList()
                    };
                return p;
            }
            else
                return null;
        }

        [HttpGet]
        public ActionResult Package(string returnUrl)
        {
            PackageViewModel model = new PackageViewModel();
            if (Session["Transaction"] != null)
            {
                var tran = (TransactionModel)Session["Transaction"];
                if (tran.packageInfo != null)
                {
                    model = tran.packageInfo;
                    var packagePartial = new PackagePartialView()
                    {
                        List = db.Package.Where(e => e.Visible && e.Quantity > 0).OrderBy(m => m.Name).ToList(),
                        PackageSelected = model.PackageId
                    };
                    var giftcardPartial = new GiftCardPartialView()
                    {
                        List = db.GiftCard.Where(e => e.Visible && e.Quantity > 0).OrderBy(m => m.Name).ToList(),
                        GiftcardSelected = model.GiftcardId
                    };
                    ViewBag.LinkBack = returnUrl;
                    ViewBag.PackagePartialView = packagePartial;
                    ViewBag.GiftcardPartialView = giftcardPartial;
                    ViewBag.ProductName = tran.productInfo.Name;
                    return View(model);
                }
                else
                {
                    var packagePartial = new PackagePartialView()
                    {
                        List = db.Package.Where(e => e.Visible && e.Quantity > 0).OrderBy(m => m.Name).ToList(),
                        PackageSelected = model.PackageId
                    };
                    var giftcardPartial = new GiftCardPartialView()
                    {
                        List = db.GiftCard.Where(e => e.Visible && e.Quantity > 0).OrderBy(m => m.Name).ToList(),
                        GiftcardSelected = model.GiftcardId
                    };
                    ViewBag.LinkBack = returnUrl;
                    ViewBag.PackagePartialView = packagePartial;
                    ViewBag.GiftcardPartialView = giftcardPartial;
                    ViewBag.ProductName = tran.productInfo.Name;
                    return View();
                }
            }
            return RedirectToAction("", "home");

        }

        [HttpPost]
        public ActionResult Package(PackageViewModel model, string returnUrl)
        {
            var tran = (pickkado.Front.Models.TransactionModel)Session[sessionName];
            if (ModelState.IsValid)
            {
                model.package = db.Package.Find(model.PackageId);
                model.giftcard = db.GiftCard.Find(model.GiftcardId);
                tran.packageInfo = model;
                Session[sessionName] = tran;

                return RedirectToAction("invite", "catalog", new { returnUrl = GetReturnUrl() });
            }
            var packagePartial = new PackagePartialView()
            {
                List = db.Package.Where(e => e.Visible && e.Quantity > 0).OrderBy(m => m.Name).ToList(),
                PackageSelected = model.PackageId
            };
            var giftcardPartial = new GiftCardPartialView()
            {
                List = db.GiftCard.Where(e => e.Visible && e.Quantity > 0).OrderBy(m => m.Name).ToList(),
                GiftcardSelected = model.GiftcardId
            };
            ViewBag.LinkBack = returnUrl;
            ViewBag.PackagePartialView = packagePartial;
            ViewBag.GiftcardPartialView = giftcardPartial;
            ViewBag.ProductName = tran.productInfo.Name;

            return View(model);
        }

        string GetReturnUrl()
        {
            return Request.UrlReferrer.PathAndQuery.ToString();
        }

        string GenerateCategoryViews(string html, int start, IEnumerable<dynamic> list, int lastLevel,pickkado.Entities.Category cat)
        {
            var toList = list.ToList();
            string activeClass = "active";
            for (int i = start; i < toList.Count; i++)
            {
                var a = toList[i];
                if (lastLevel == a.Level)
                {
                    if (i + 1 < toList.Count)
                    {
                        if (a.Left <= cat.Left && a.Right >= cat.Right && cat.Id != 0)
                        {
                            html += "<li class=\"" + activeClass + "\"><a class=\"link link-default\" href=\"/catalog/views?category=" + a.Id + "\">" + a.Name + "</a>";
                        }
                        else
                            html += "<li><a class=\"link link-default\" href=\"/catalog/views?category=" + a.Id + "\">" + a.Name + "</a>";
                        var b = toList[i + 1];
                        if (lastLevel < b.Level)
                        {
                            html += "<a class=\"collapsed\" data-toggle=\"collapse\" data-target=\"#parent" + i + "\"> " +
                                        "<i class=\"glyphicon glyphicon-triangle-top parent-collapsed\"></i>" +
                                        "<i class=\"glyphicon glyphicon-triangle-bottom parent-expanded\"></i>" +
                                    "</a>";
                            html += "<ul id=\"parent" + i + "\" aria-expanded=\"false\" class=\"collapse\" style=\"padding:0px " + (10 * (lastLevel + 1)).ToString() + "px;\">";
                            html = GenerateCategoryViews(html, i + 1, list, lastLevel + 1, cat);
                            html += "</ul>";
                            i++;
                        }
                        html += "</li>";
                    }
                    else
                    {
                        if (a.Left >= cat.Left && a.Left <= cat.Right&& cat.Id != 0)
                        {
                            html += "<li class=\"" + activeClass + "\"><a class=\"link link-default\" href=\"/catalog/views?category=" + a.Id + "\">" + a.Name + "</a>";
                        }
                        else
                            html += "<li><a class=\"link link-default\" href=\"/catalog/views?category=" + a.Id + "\">" + a.Name + "</a>";                            
                        
                        //html += "<li class=\"" + a.Left < cat.Right ? activeClass : "" + "\"><a class=\"link link-default\" href=\"/catalog/views?category=" + a.Id + "\">" + a.Name + "</a></li>";
                    }
                    //lastLevel = a.Level;
                }
                //else if (lastLevel < a.Level)
                //{
                //    html += "<li class=\"link link-default\"><a href=\"#\">" + a.Name + "</a>";
                //    html += "<ul>";
                //    html=recursiveMethod(html, i+1, list, lastLevel + 1);
                //    html += "</ul></li>";
                //    //lastLevel++;
                //    i++;
                //}
                else if (lastLevel > a.Level)
                    break;
            }
            return html;
        }
    }
}
