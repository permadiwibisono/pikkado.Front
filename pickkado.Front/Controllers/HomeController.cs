using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace pickkado.Front.Controllers
{
    public class HomeController : Controller
    {
        private const string sessionName = "Transaction";
        public ActionResult Index()
        {
            if(Session[sessionName]!=null)
                Session[sessionName]=null;

            return View();
        }

        public ActionResult About()
        {
            ViewBag.Message = "Your app description page.";

            return View();
        }

        public ActionResult Contact()
        {
            ViewBag.Message = "Your contact page.";

            return View();
        }

        public ActionResult Catalog()
        {
            return View();
        }
    }
}
