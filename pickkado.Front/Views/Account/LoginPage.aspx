<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<pickkado.Front.Models.LoginViewModel>" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <meta name="viewport" content="width=device-width" />
    <link href="<%: Url.Content("~/favicon.ico") %>" rel="shortcut icon" type="image/x-icon" />
    <link rel="stylesheet" href="/Content/bootstrap/css/bootstrap.css" />
    <link rel="stylesheet" href="/Content/master.css" />
    <script src="../../Scripts/jquery-1.10.2.js"></script>
    <script src="../../Scripts/jquery-ui-1.8.24.js"></script>
    <title>Login</title>
</head>
<body>
    <div class="container-fluid" style="background-color:#5db194;height:100vh; width:100vw;">
        <div class="container" style="height:100%;">
            <div style="margin:auto; width:500px; position:relative; top:50%; transform:translateY(-50%); color:white;">
                
                <div>                
                  <% using (Html.BeginForm("loginpage", "account", new { returnUrl=ViewBag.ReturnUrl==null?"":ViewBag.ReturnUrl}, FormMethod.Post))
                     { %>
                    <%: Html.AntiForgeryToken()%>
                        <a href="/"><img src="../../Images/brand.png" /></a>  
                            <div class="row">
                                <div class="col-lg-12">
                                <div class="input-group input-group-lg" style="padding:10px 0px">
                                    <%:Html.TextBoxFor(m => m.Email, new { id = "txtEmail", @class = "form-control", @placeholder = "EMAIL ADDRESS" })%>
                        
                                    <span class="input-group-addon">
                                        <span class="glyphicon glyphicon-envelope" aria-hidden="true"></span>
                                    </span>
                                </div>

                                </div>
                            </div>
                            <div class="row">
                                <div class="col-lg-12">
                                <div class="input-group input-group-lg" style="padding:10px 0px">
                                    <%:Html.PasswordFor(m => m.Password, new { id = "txtPassword", @class = "form-control", @placeholder = "PASSWORD" })%>
                                    <span class="input-group-addon">
                                        <span class="glyphicon glyphicon-lock" aria-hidden="true"></span>
                                    </span>
                                </div>

                                </div>
                            </div>
                            <div class="row">
                                <div class="col-lg-12">
                                <div class="input-group input-group-lg" style="padding:10px 0px; width:100%">
                                    <button type="submit" class="btn  btn-lg btn-block btn-login-inverse">LOGIN</button>
                                </div>
                                </div>
                            </div>
                    <% if (ViewData.ModelState.Any(x => x.Value.Errors.Any()))
                       {%>
                            <div id="message" class="alert alert-danger form-message">
                                <a href="#" class="close" data-dismiss="alert">×</a>
                                <%: Html.ValidationSummary("", new { @class = "validation-summary-custom " })%>
                            </div>
                        <% }%>
                    <%} %>
                </div>
            </div>
        <script src="../../Scripts/validation-summary.js"></script>
        <%: Scripts.Render("~/bundles/bootstrap") %>
        </div>
    </div>
</body>
</html>
