using pickkado.Entities;
using pickkado.Front.Areas.Admin.Models;
using pickkado.Front.Db;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace pickkado.Front.Areas.Admin.Controllers
{
    [AuthorizeCustom(Roles = "Admin")]
    public class MasterCategoryController : Controller
    {
        PickkadoDBContext db = new PickkadoDBContext();
        //
        // GET: /Admin/MasterCategory/

        public ActionResult Index()
        {
            var list=db.Category.OrderBy(m=>m.Left).ToList();
            var list2 = (from l in list
                        from parent in list
                        where l.Left >=parent.Left&&l.Left<=parent.Right
                        select new CategoryModel
                        {
                            Name = l.Name,
                            Parent = parent.Name,
                        }).GroupBy(x=>new{x.Name}).Select(g=>new{g.Key.Name,Level=g.Count()-1}).ToList();
            string html = recursiveMethod("", 0, list2, 0);
            ViewBag.Filter = html;
            ViewBag.List = list;
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
            return View();
        }
        string recursiveMethod(string html,int start, IEnumerable<dynamic> list, int lastLevel)
        {
            var toList = list.ToList();
            for (int i = start; i < toList.Count; i++)
            {
                var a = toList[i];
                if (lastLevel == a.Level)
                {
                    if (i + 1 < toList.Count)
                    {
                        html += "<li class=\"link link-default\"><a href=\"#\">" + a.Name + "</a>";
                        var b = toList[i + 1];
                        if (lastLevel < b.Level)
                        {
                            html += "<a class=\"collapsed\" data-toggle=\"collapse\" data-target=\"#parent"+i+"\"> " +
                                        "<i class=\"fa fa-fw fa-minus-square parent-collapsed\"></i>" +
                                        "<i class=\"fa fa-fw fa-plus-square parent-expanded\"></i>" +
                                    "</a>";
                            html += "<ul id=\"parent"+i+"\" aria-expanded=\"false\" class=\"collapse\" style=\"list-style:none;padding:0px "+(10*(lastLevel+1)).ToString()+"px;\">";
                            html = recursiveMethod(html, i + 1, list, lastLevel + 1);
                            html += "</ul>";
                            i++;
                        }
                        html += "</li>";
                    }
                    else
                        html += "<li class=\"link link-default\"><a href=\"#\">" + a.Name + "</a></li>";
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
                else if(lastLevel>a.Level)
                    break;
            }
            return html;
        }
        [HttpPost]
        public ActionResult New(MasterCategoryViewModel model)
        {
            try {

                if (ModelState.IsValid)
                {
                    var b = new Category();
                    //b.Id = b.GenerateId("CT");
                    b.Name = model.Name;
                    b.ImageUrl = model.ImageUrl;
                    b.CreatedBy = "Admin";
                    b.CreatedDate = DateTime.Now;
                    b.UpdatedBy = "Admin";
                    b.UpdatedDate = DateTime.Now;
                    b.Visible = true;
                    db.Category.Add(b);
                    db.SaveChangesAsync();
                    TempData["Success"] = " insert data";
                }
                else
                {
                    TempData["Error"] = " when inserting data";
                    
                }
            }
            catch (Exception ex)
            {
                TempData["Error"] = ex.Message;
                
            }
            return RedirectToAction("index");
        }

        [HttpGet]
        public ActionResult Edit(string id)
        {
            try {

                if (db.Category.Where(e => e.Id == Int32.Parse(id)).ToList().Count == 0)
                {
                    return HttpNotFound();
                }
                else
                {
                    var cat = db.Category.Find(id);
                    var viewmodel = new MasterCategoryViewModel();
                    viewmodel.Name = cat.Name;
                    viewmodel.ImageUrl = cat.ImageUrl;
                    viewmodel.Visible = cat.Visible;
                    return View(viewmodel);
                }
            }
            catch (Exception ex)
            {
                TempData["Error"] = ex.Message;
            
            }
            return View();
        }

        [HttpPost]
        public ActionResult Edit(MasterCategoryViewModel model, string id)
        {
            try {

                if (db.Category.Where(e => e.Id == Int32.Parse(id)).ToList().Count == 0)
                {
                    return HttpNotFound();
                }
                else
                {
                    var cat = db.Category.Find(id);
                    cat.Name = model.Name;
                    cat.ImageUrl = model.ImageUrl;
                    cat.UpdatedBy = "Admin";
                    cat.UpdatedDate = DateTime.Now;
                    cat.Visible = model.Visible;
                    db.SaveChangesAsync();
                    ViewBag.Success = " update data";
                    return View(model);
                }
            }
            catch (Exception ex)
            {
                ViewBag.Error = ex.Message;
            }
            return View(model);
        }

        [HttpPost]
        public ActionResult Delete(string id)
        {
            try
            {

                if (db.Category.Where(e => e.Id==Int32.Parse(id)).ToList().Count == 0)
                {
                    return HttpNotFound();
                }
                else
                {
                    var cat = db.Category.Find(id);
                    db.Category.Remove(cat);
                    db.SaveChangesAsync();
                    TempData["Success"] = " delete data";
                    return RedirectToAction("Index");
                }
            }
            catch (Exception ex)
            {
                TempData["Error"] = ex.Message;

            }
            return RedirectToAction("index");
        }

    }
}
