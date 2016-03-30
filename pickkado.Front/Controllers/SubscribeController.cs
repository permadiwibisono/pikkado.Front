using pickkado.Front.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.Owin;
using Microsoft.Owin.Security;

using System.Threading.Tasks;
using pickkado.Entities;

namespace pickkado.Front.Controllers
{
    public class SubscribeController : Controller
    {
        pickkado.Front.Db.PickkadoDBContext db = new pickkado.Front.Db.PickkadoDBContext();
        //
        // GET: /Subscribe/

        public ActionResult Index()
        {
            return View();
        }
        public ActionResult Index2()
        {
            return View();
        }
        [HttpPost]
        public async Task<ActionResult> Index(SubscribeViewModel model)
        {
            if (ModelState.IsValid)
            {
                if (db.EmailSubscribe.Where(e => e.Email == model.Email).ToList().Count == 0)
                {
                    var emailSubscribe = new EmailSubscribe();
                    emailSubscribe.Id = emailSubscribe.GenerateId("ES");
                    emailSubscribe.Email = model.Email;
                    emailSubscribe.UpdatedBy = emailSubscribe.Id;
                    emailSubscribe.CreatedBy = emailSubscribe.Id;
                    emailSubscribe.CreatedDate = DateTime.Now;
                    emailSubscribe.UpdatedDate = DateTime.Now;
                    db.EmailSubscribe.Add(emailSubscribe);
                    await db.SaveChangesAsync();
                    ViewBag.Success = "Thank you";
                    model.Email = "";
                }
                else
                {
                    ModelState.AddModelError("", "Your email already registered");
                }
            }

            return View(model);
        }


    }
}
