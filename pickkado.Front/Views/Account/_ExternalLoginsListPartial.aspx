<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<pickkado.Front.Models.ExternalLoginListViewModel>" %>
<%@ import namespace='Microsoft.Owin.Security'%>
<% {
    var loginProviders = Context.GetOwinContext().Authentication.GetExternalAuthenticationTypes();
    if (loginProviders.Count() == 0) {%>
    <% }
    else {
        using (Html.BeginForm("ExternalLogin", "Account", new { ReturnUrl = Model.ReturnUrl })) {%>
            <%:Html.AntiForgeryToken()%>
            <div id="socialLoginList">
                   <% foreach (AuthenticationDescription p in loginProviders) {
                          if(p.AuthenticationType=="Google")
                          {
                          %>
                            <div class="row">
                                <div class="col-lg-12">
                                <div class="input-group input-group-lg" style="padding:10px 0px; width:100%">
                                    <button type="submit" class="btn btn-lg btn-block btn-google" id="<%:p.AuthenticationType %>" name="provider" value="<%:p.AuthenticationType %>" title="Log in using your <%: p.Caption%> account"> <img src="../../Images/icon/gplus.png" style="padding-right:20px" />Login with Google</button>
                                </div>
                                </div>
                            </div>
                        <%}
                        else if (p.AuthenticationType == "Facebook") { %>                
                            <div class="row">
                                <div class="col-lg-12">
                                <div class="input-group input-group-lg" style="padding:10px 0px; width:100%">
                                    <button type="submit" class="btn btn-lg btn-block btn-fb"  id="<%:p.AuthenticationType %>" name="provider" value="<%:p.AuthenticationType %>" title="Log in using your <%: p.Caption%> account"><img src="../../Images/icon/fb.png" style="padding-right:20px"  />  Login with Facebook</button>
                                </div>
                                </div>
                            </div>
                         <% } %>
                    <%}%>
            </div>
        <%}
    }
}%>
