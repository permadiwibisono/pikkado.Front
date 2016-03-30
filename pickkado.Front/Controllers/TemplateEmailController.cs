using pickkado.Front.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace pickkado.Front.Controllers
{
    public class TemplateEmailController : Controller
    {
        //
        // GET: /TemplateEmail/

        public ActionResult Index()
        {
            return View();
        }

        public ActionResult ConfirmEmail()
        {
            return View();
        }
        public ActionResult Invite()
        {
            return View();
        }
        public ActionResult InvitePatungan()
        {
            return View();
        }
        public ActionResult Struk()
        {
            return View();
        }
        public ActionResult StrukPatungan()
        {
            return View();
        }

    }
}
