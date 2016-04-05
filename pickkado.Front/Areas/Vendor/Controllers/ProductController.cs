using pickkado.Entities;
using pickkado.Front.Areas.Vendor.Models;
using pickkado.Front.Db;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;

namespace pickkado.Front.Areas.Vendor.Controllers
{
    [AuthorizeCustom(Roles = "Vendor")]
    public class ProductController : Controller
    {
        PickkadoDBContext db = new PickkadoDBContext();
        //
        // GET: /Vendor/Product/

        public ActionResult Index()
        {
            if (TempData["Success"] != null)
            {
                ViewBag.Success = TempData["Success"];
                TempData["Success"] = null;
            }
            if (TempData["Error"] != null)
            {
                ViewBag.Error = TempData["Error"];
                TempData["Error"] = null;
            }
            var clist = db.Category.OrderBy(m => m.Left).ToList();
            var pList = db.ProductVendor.Where(m => m.StoreId == "ST20160323082232699VByI").ToList();
            var list = (from c in clist
                       join p in pList on c.Id equals p.Categories
                       select new ProductViewModel { 
                        Id=p.Id,
                        Name=p.Name,
                        CategoryName=c.Name,
                        Weight=p.Weight,
                        Gender=p.Gender,
                        Price=p.Price
                       }).ToList();
            ViewBag.List = list;
            return View();
        }

        public ActionResult New()
        {
            if (TempData["Success"] != null)
            {
                ViewBag.Success = TempData["Success"];
                TempData["Success"] = null;
            }
            if (TempData["Error"] != null)
            {
                ViewBag.Error = TempData["Error"];
                TempData["Error"] = null;
            }
            var list = db.Category.OrderBy(m => m.Left).ToList();
            var list2 = (from l in list
                         from parent in list
                         where l.Left >= parent.Left && l.Left <= parent.Right
                         orderby l.Left
                         //select l).GroupBy(x => new { x.Id, x.Name }).Select(g => new { g.Key.Id, Name = String.Concat(new string(' ',g.Count()), g.Key.Name), Level = g.Count() - 1 }).ToList();
                         select l).GroupBy(x => new { x.Id, x.Name }).Select(g => new { g.Key.Id, Name = g.Key.Name, Level = g.Count() - 1 }).ToList();
            string[] catList = new string[list2.Count];
            for (int i = 0; i < list2.Count; i++)
            {
                catList[i] = GetParent(i, list2, list2[i].Level);
            }
            ViewBag.CategoryNameList = catList;
            ViewBag.CategoryList = list;
            return View();
        }

        string GetParent(int start,IEnumerable<dynamic> list, int lastLevel)
        {
            var tolist = list.ToList();
            string cat = "";
            for (int i = start; i >=0; i--)
            {
                var a = tolist[i];
                if (lastLevel == a.Level)
                {
                    if (cat != "")
                        cat = a.Name + " > " + cat;
                    else
                        cat = a.Name;
                    lastLevel--;
                }
                //else if (lastLevel < a.Level&&lastLevel>=0&&i-1>=0)
                //{
                //    //lastLevel++;
                //    cat += GetParent(--i, list, lastLevel);
                //    //cat += a.Name;
                //}
            }
            return cat;
        }

        [HttpPost]
        public ActionResult New(NewProductViewModel model)
        {
            if (TempData["Success"] != null)
            {
                ViewBag.Success = TempData["Success"];
                TempData["Success"] = null;
            }
            if (TempData["Error"] != null)
            {
                ViewBag.Error = TempData["Error"];
                TempData["Error"] = null;
            }
            try {

                if (ModelState.IsValid)
                {
                    var product = new Product();
                    product.Id = product.GenerateId("PR");
                    product.Name = model.Name;
                    product.Price = model.Price;
                    product.Weight = model.Weight;
                    product.Gender = model.Gender;
                    product.Categories = model.Category;
                    product.Description = model.Description;
                    product.StoreId = "ST20160323082232699VByI";
                    product.CreatedBy = "ST20160323082232699VByI";
                    product.CreatedDate = DateTime.Now;
                    product.UpdatedBy = "ST20160323082232699VByI";
                    product.UpdatedDate = DateTime.Now;
                    db.ProductVendor.Add(product);
                    db.SaveChanges();
                    TempData["Success"] = " insert data";
                    return RedirectToAction("index");
                } 
                var list = db.Category.OrderBy(m => m.Left).ToList();
                var list2 = (from l in list
                             from parent in list
                             where l.Left >= parent.Left && l.Left <= parent.Right
                             orderby l.Left
                             //select l).GroupBy(x => new { x.Id, x.Name }).Select(g => new { g.Key.Id, Name = String.Concat(new string(' ',g.Count()), g.Key.Name), Level = g.Count() - 1 }).ToList();
                             select l).GroupBy(x => new { x.Id, x.Name }).Select(g => new { g.Key.Id, Name = g.Key.Name, Level = g.Count() - 1 }).ToList();
                string[] catList = new string[list2.Count];
                for (int i = 0; i < list2.Count; i++)
                {
                    catList[i] = GetParent(i, list2, list2[i].Level);
                }
                ViewBag.CategoryNameList = catList;
                ViewBag.CategoryList = list;
                
            }
            catch (Exception ex)
            {
                TempData["Error"] = ex.Message;
            }
            return View(model);
        }

        [HttpPost]
        public ActionResult Delete(string id)
        {
            try
            {
                if (db.ProductVendor.Where(e => e.Id.Contains(id)).ToList().Count == 0)
                {
                    return HttpNotFound();
                }
                else
                {
                    var product = db.ProductVendor.Find(id);
                    db.ProductVendor.Remove(product);
                    db.SaveChanges();
                    TempData["Success"] = " delete data";
                    return RedirectToAction("index");
                }
            }
            catch (Exception ex)
            {
                TempData["Error"] = ex.Message;

            }
            return RedirectToAction("index");
        }

        public ActionResult Edit(string id)
        {
            if (TempData["Success"] != null)
            {
                ViewBag.Success = TempData["Success"];
                TempData["Success"] = null;
            }
            if (TempData["Error"] != null)
            {
                ViewBag.Error = TempData["Error"];
                TempData["Error"] = null;
            }

            try
            {
                var viewmodel = new NewProductViewModel();

                var list = db.Category.OrderBy(m => m.Left).ToList();
                var list2 = (from l in list
                             from parent in list
                             where l.Left >= parent.Left && l.Left <= parent.Right
                             orderby l.Left
                             //select l).GroupBy(x => new { x.Id, x.Name }).Select(g => new { g.Key.Id, Name = String.Concat(new string(' ',g.Count()), g.Key.Name), Level = g.Count() - 1 }).ToList();
                             select l).GroupBy(x => new { x.Id, x.Name }).Select(g => new { g.Key.Id, Name = g.Key.Name, Level = g.Count() - 1 }).ToList();
                string[] catList = new string[list2.Count];
                for (int i = 0; i < list2.Count; i++)
                {
                    catList[i] = GetParent(i, list2, list2[i].Level);
                }
                var attributeList = db.ProductAttribute.Where(e => e.ProductId == id).ToList();
                ViewBag.AttributeList = attributeList;
                ViewBag.CategoryNameList = catList;
                ViewBag.CategoryList = list;
                ViewBag.ProductThumbnail = db.ProductThumbnail.Where(e=>e.ProductId==id).ToList();
                if (string.IsNullOrEmpty(id))
                {
                    return HttpNotFound();
                }
                else if (db.ProductVendor.Where(e => e.Id.Contains(id)).ToList().Count != 0)
                {
                    var product = db.ProductVendor.Find(id);
                    //viewmodel.Brand = product.BrandId;
                    viewmodel.Name = product.Name;
                    viewmodel.Weight = product.Weight;
                    viewmodel.Description = product.Description;
                    viewmodel.Gender = product.Gender;
                    viewmodel.Price = product.Price;
                    viewmodel.Category = product.Categories;

                    return View(viewmodel);
                }
                else
                {
                    return HttpNotFound();
                }
            }
            catch (Exception ex)
            {
                TempData["Error"] = ex.Message;
            }
            return View();
            
        }

        [HttpPost]
        public ActionResult Edit(NewProductViewModel model,string id)
        {
            if (TempData["Success"] != null)
            {
                ViewBag.Success = TempData["Success"];
                TempData["Success"] = null;
            }
            if (TempData["Error"] != null)
            {
                ViewBag.Error = TempData["Error"];
                TempData["Error"] = null;
            }
            try
            {

                if (ModelState.IsValid)
                {
                    var product = db.ProductVendor.Find(id);
                    if (product == null)
                        return HttpNotFound();
                    //product.Id = product.GenerateId("PR");
                    product.Name = model.Name;
                    product.Price = model.Price;
                    product.Weight = model.Weight;
                    product.Gender = model.Gender;
                    product.Categories = model.Category;
                    product.Description = model.Description;
                    //product.StoreId = "ST20160229052655663";
                    //product.CreatedBy = "ST20160229052655663";
                    //product.CreatedDate = DateTime.Now;
                    product.UpdatedBy = "ST20160323082232699VByI";
                    product.UpdatedDate = DateTime.Now;
                    //db.ProductVendor.Add(product);
                    db.SaveChanges();
                    TempData["Success"] = " update data";
                    //return View(model);
                }
                ViewBag.ProductThumbnail = db.ProductThumbnail.Where(e => e.ProductId == id).ToList();
                var list = db.Category.OrderBy(m => m.Left).ToList();
                var list2 = (from l in list
                             from parent in list
                             where l.Left >= parent.Left && l.Left <= parent.Right
                             orderby l.Left
                             //select l).GroupBy(x => new { x.Id, x.Name }).Select(g => new { g.Key.Id, Name = String.Concat(new string(' ',g.Count()), g.Key.Name), Level = g.Count() - 1 }).ToList();
                             select l).GroupBy(x => new { x.Id, x.Name }).Select(g => new { g.Key.Id, Name = g.Key.Name, Level = g.Count() - 1 }).ToList();
                string[] catList = new string[list2.Count];
                for (int i = 0; i < list2.Count; i++)
                {
                    catList[i] = GetParent(i, list2, list2[i].Level);
                }
                ViewBag.CategoryNameList = catList;
                ViewBag.CategoryList = list;

            }
            catch (Exception ex)
            {
                TempData["Error"] = ex.Message;
            }
            return View(model);
        }

        [HttpPost]
        public async Task<ActionResult> UploadPhoto(HttpPostedFileBase photo, string id)
        {
            byte[] photoByte = null;
            string message = "";
            if (photo != null && photo.ContentLength > 0)
            {
                if (photo.ContentType == "image/png" || photo.ContentType == "image/jpeg" || photo.ContentType == "image/gif")
                {
                    if (photo.ContentLength < 2048000)
                    {
                        using (var reader = new System.IO.BinaryReader(photo.InputStream))
                        {
                            photoByte = reader.ReadBytes(photo.ContentLength);
                        }
                    }
                    else
                    {
                        message = " Max size of image is 2MB";
                        return Json(new { Message = message, IsError = true });
                    }
                    var a = new ProductThumbnail();
                    a.Id = a.GenerateId("PT");
                    a.CreatedBy = "ST20160323082232699VByI";
                    a.CreatedDate = DateTime.Now;
                    a.ProductId = id;
                    a.UpdatedBy = "ST20160323082232699VByI";
                    a.UpdatedDate = DateTime.Now;
                    a.Image = photoByte;
                    db.ProductThumbnail.Add(a);
                    await db.SaveChangesAsync();
                    message = " upload!";
                    return Json(new { Photo = "data:image;base64," + System.Convert.ToBase64String(a.Image), Id = a.Id, Message = message, IsError = false });
                }
                else
                {
                    message = " Only .png, .jpg and .gif extension allowed";
                    return Json(new { Message = message, IsError = true });
                }
            }
            message = " please select your photo!";
            return Json(new { Message = message, IsError = true });
        }

        [HttpPost]
        public async Task<ActionResult> DeletePhoto(string id)
        {
            var message = "";
            try {

                var get = db.ProductThumbnail.Find(id);
                db.ProductThumbnail.Remove(get);
                await db.SaveChangesAsync();
                message = " delete photo!";
                return Json(new { Message = message, IsError = false });
            }
            catch (Exception ex)
            {
                message = ex.Message;
                return Json(new { Message = message, IsError = true });
            }
        }

        public ActionResult NewAttribute(string id)
        {
            ViewBag.MasterList = db.MasterProductAttribute.ToList();
            return View();
        }

        [HttpPost]
        public async Task<ActionResult> NewAttribute(NewAttributeViewModel model,string id)
        {
            string message = "";
            try {
                if (ModelState.IsValid)
                {
                    var a = new ProductAttribute();
                    a.Id = a.GenerateId("PA");
                    a.MasterProductAttributeId = model.AttributeId;
                    a.ProductId = id;
                    a.Value = model.Values;
                    a.Disabled = model.Disabled;
                    a.CreatedBy = "ST20160323082232699VByI";
                    a.CreatedDate = DateTime.Now;
                    a.UpdatedBy = "ST20160323082232699VByI";
                    a.UpdatedDate = DateTime.Now;
                    db.ProductAttribute.Add(a);
                    var master=db.MasterProductAttribute.Find(model.AttributeId);
                    await db.SaveChangesAsync();
                    message = " when inserting data product attribute!";
                    return Json(new { Obj = new {Id=a.Id,Type=master.Name,Value=a.Value,Disabled=a.Disabled }, Message = message, IsError = false });
                }                
            }
            catch (Exception ex)
            {
                message = " " + ex.Message+"!";
                return Json(new {Message=message,IsError=true });
            }
            ViewBag.MasterList = db.MasterProductAttribute.ToList();
            message = " your form not completed!";
            return Json(new {HTMLString=RenderPartialViewToString("NewAttribute",model), Message = message, IsError = true });
        }

        public ActionResult EditAttribute(string id)
        {
            var get = db.ProductAttribute.Find(id);
            var model = new EditAttributeViewModel();
            model.Id = get.Id;
            model.AttributeId = get.MasterProductAttributeId;
            model.Disabled = get.Disabled;
            model.Values = get.Value;
            ViewBag.MasterList = db.MasterProductAttribute.ToList();
            return View(model);
        }

        [HttpPost]
        public async Task<ActionResult> EditAttribute(EditAttributeViewModel model,string id)
        {
            string message = "";
            try
            {
                if (ModelState.IsValid)
                {
                    var a = db.ProductAttribute.Find(id);
                    //a.Id = model.Id;
                    a.MasterProductAttributeId = model.AttributeId;
                    //a.ProductId = id;
                    a.Value = model.Values;
                    a.Disabled = model.Disabled;
                    a.UpdatedBy = "ST20160323082232699VByI";
                    a.UpdatedDate = DateTime.Now;
                    var master = db.MasterProductAttribute.Find(model.AttributeId);
                    await db.SaveChangesAsync();
                    message = " when updating data product attribute!";
                    return Json(new { Obj = new { Id = a.Id, Type = master.Name, Value = a.Value, Disabled = a.Disabled }, Message = message, IsError = false });
                }
            }
            catch (Exception ex)
            {
                message = " " + ex.Message + "!";
                return Json(new { Message = message, IsError = true });
            }
            ViewBag.MasterList = db.MasterProductAttribute.ToList();
            message = " your form not completed!";
            return Json(new { HTMLString = RenderPartialViewToString("EditAttribute", model), Message = message, IsError = true });
        }

        [HttpPost]
        public async Task<ActionResult> DeleteAttribute(string id)
        {
            var message = "";
            try
            {

                var get = db.ProductAttribute.Find(id);
                db.ProductAttribute.Remove(get);
                await db.SaveChangesAsync();
                message = " delete attribute!";
                return Json(new { Message = message, IsError = false });
            }
            catch (Exception ex)
            {
                message = ex.Message;
                return Json(new { Message = message, IsError = true });
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
