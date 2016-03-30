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
    public class NotificationController : Controller
    {
        PickkadoDBContext db = new PickkadoDBContext();
        //
        // GET: /Admin/Notification/

        public ActionResult Index()
        {
            return View();
        }

        //
        // GET: /Admin/Notification/Compose
        [HttpGet]
        public ActionResult Compose()
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

            return View(new NotificationViewModel());
        }

        //
        // POST: /Admin/Notification/Compose
        [HttpPost]
        public ActionResult Compose(NotificationViewModel model)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    var notif = new Notification
                    {
                        UserId = null,
                        Type = model.Type,
                        SenderId = "",
                        SenderName = "Pickkado",
                        Description = model.Description,
                        Thumbnail = null,
                        Link = model.Link,
                        NotificationDate = DateTime.Now,
                        Title = model.Title,
                        IsDistributed = false,
                        IsSeen = false,
                        CreatedBy = "Admin",
                        CreatedDate = DateTime.Now,
                        UpdatedBy = "Admin",
                        UpdatedDate = DateTime.Now,
                        
                    };
                    notif.Id = notif.GenerateId("NT");

                    db.Notification.Add(notif);
                    db.SaveChanges();

                    TempData["Success"] = " compose notification";
                    return RedirectToAction("compose");
                }
            }
            catch (Exception ex)
            {
                ViewBag.Error = ex.Message;
            }
            return View();
        }

    }
}
