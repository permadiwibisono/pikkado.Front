using System.Web.Mvc;

namespace pickkado.Front.Areas.Vendor
{
    public class VendorAreaRegistration : AreaRegistration
    {
        public override string AreaName
        {
            get
            {
                return "Vendor";
            }
        }

        public override void RegisterArea(AreaRegistrationContext context)
        {
            context.MapRoute(
                "Vendor_default",
                "vendor/{controller}/{action}/{id}",
                new { controller="home",action = "Index", id = UrlParameter.Optional }
            );
        }
    }
}
