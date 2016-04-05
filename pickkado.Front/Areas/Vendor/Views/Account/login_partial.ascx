<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<dynamic>" %>

<%if (Request.IsAuthenticated)
  { %>               
    <% using (Html.BeginForm("logout", "account", FormMethod.Post, new { id = "logoutForm" }))
       { %>
        <%: Html.AntiForgeryToken()%>  
    <%} %>
        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false"><%:ViewBag.Name %><span class="caret"></span></a>
        <ul class="dropdown-menu animated fadeInDown">
            <li class="profile-img">
                <img src="../img/profile/picjumbo.com_HNCK4153_resize.jpg" class="profile-img">
            </li>
            <li>
                <div class="profile-info">
                    <h4 class="username"><%:ViewBag.Name %></h4>
                    <p><%:((string)ViewBag.UserName)%></p>
                    <div class="btn-group margin-bottom-2x" role="group">
                        <a href="<%:Url.Action("","account") %>" class="btn btn-default"><i class="fa fa-user"></i> Profile</a>
                        <a class="btn btn-default"  href="javascript:document.getElementById('logoutForm').submit()"> <i class="fa fa-sign-out"></i>Logout</a>
                       
                    </div>
                </div>
            </li>
        </ul>     

  <%} %>

