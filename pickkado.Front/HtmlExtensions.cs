using System;
using System.Linq.Expressions;
using System.Web;
using System.Web.Mvc;
using System.Web.Mvc.Html;
using System.Web.Routing;
public static class HtmlExtensions
{
    public static IHtmlString MyTextBoxFor<TModel, TProperty>(
        this HtmlHelper<TModel> htmlHelper,
        Expression<Func<TModel, TProperty>> expression,
        object htmlAttributes,
        bool disabled
    )
    {
        var attributes = new RouteValueDictionary(htmlAttributes);
        if (disabled)
        {
            attributes["disabled"] = "disabled";
        }
        return htmlHelper.TextBoxFor(expression, attributes);
    }
    public static string MakeActiveClass(this UrlHelper urlHelper, string controller)
    {
        string result = "active";

        string controllerName = urlHelper.RequestContext.RouteData.Values["controller"].ToString();

        if (!controllerName.Equals(controller, StringComparison.OrdinalIgnoreCase))
        {
            result = null;
        }

        return result;
    }
}
