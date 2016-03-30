using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.Mvc;

namespace pickkado.Front
{
    public class AuthorizeCustom : AuthorizeAttribute
    {
        //source:http://stackoverflow.com/questions/19562733/mvc-authorize-roles-goes-to-login-view
        //source:http://stackoverflow.com/questions/2504923/how-to-redirect-authorize-to-loginurl-only-when-roles-are-not-used
        //source:http://farm-fresh-code.blogspot.co.id/2009/11/customizing-authorization-in-aspnet-mvc.html
        private string redirectUrl = "";
        private string notifyUrl = "/error/unauthorized";
        public string NotifyUrl {
            get { return notifyUrl; }
            set { notifyUrl = value; }
        }
        public AuthorizeCustom():base()
        {

        }
        public AuthorizeCustom(string notifyUrl):base()
        {
            this.notifyUrl = notifyUrl;
        }
        protected override void HandleUnauthorizedRequest(AuthorizationContext filterContext)
        {
            if (filterContext.HttpContext.Request.IsAuthenticated)
            {
                string authUrl = NotifyUrl; //passed from attribute

                //if null, get it from config
                //if (String.IsNullOrEmpty(authUrl))
                //    authUrl = System.Web.Configuration.WebConfigurationManager.AppSettings["RolesAuthRedirectUrl"];

                if (!String.IsNullOrEmpty(authUrl))
                    filterContext.HttpContext.Response.Redirect(authUrl);
            }

            //else do normal process
            base.HandleUnauthorizedRequest(filterContext);
        }
    }
}
