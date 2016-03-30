<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site1.Master" Inherits="System.Web.Mvc.ViewPage<pickkado.Front.Models.RegisterViewModel>" %>

<asp:Content ID="registerTitle" ContentPlaceHolderID="TitleContent" runat="server">
    Register
</asp:Content>

<asp:Content ID="Content5" ContentPlaceHolderID="breadcumb" runat="server">
    <li><a href="/">Home</a></li>
    <li class="active">Register</li>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="navBar" runat="server">
    <%Html.RenderAction("login_partial","account"); %>
</asp:Content>
<asp:Content ID="registerContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container-fluid title-underline">
        <span class="font-avant">
            Personal Information
        </span>
    </div>

    <% using (Html.BeginForm("register", "account", null, FormMethod.Post))
       { %>
        <%: Html.AntiForgeryToken() %>
        <% if (ViewData.ModelState.Any(x => x.Value.Errors.Any()))
           {%>
                <div id="message" class="alert alert-danger form-message">                    
                    <strong> Please correct the following errors:</strong>
                    <a href="javascript:void(0);" class="alert-link" data-target="#divContentError" data-toggle="collapse" >Show</a>
                    <a href="#" class="close" data-dismiss="alert">×</a>
                    <div id="divContentError" class="collapse">
                        <%: Html.ValidationSummary("",new { @class = "validation-summary-custom" })%>

                    </div>
                </div>
            <% }%>

       <div class="container-fluid" style="padding:15px 0px;">
           <div class="row">
               <div class="col-lg-6">
                    <div class="input-group input-group-lg" style="padding:10px 0px">
                        <%:Html.TextBoxFor(m=>m.FirstName, new {@class="form-control",@placeholder="ENTER YOUR FIRSTNAME*"}) %>
                        <span class="input-group-addon">
                            <span class="glyphicon glyphicon-user" aria-hidden="true"></span>
                        </span>
                    </div>
               </div>
               <div class="col-lg-6">
                    <div class="input-group input-group-lg" style="padding:10px 0px">
                        <%:Html.TextBoxFor(m=>m.LastName, new {@class="form-control",@placeholder="ENTER YOUR LASTNAME*"}) %>
                        <span class="input-group-addon">
                            <span class="glyphicon glyphicon-user" aria-hidden="true"></span>
                        </span>
                    </div>
               </div>
               <div class="col-lg-12">
                    <div class="input-group input-group-lg" style="padding:10px 0px">
                        <%:Html.TextBoxFor(m=>m.Email, new {@class="form-control",@placeholder="EMAIL ADDRESS*"}) %>
                        <span class="input-group-addon">
                            <span class="glyphicon glyphicon-envelope" aria-hidden="true"></span>
                        </span>
                    </div>
               </div>
               <div class="col-lg-12">
                    <div class="input-group input-group-lg" style="padding:10px 0px">
                        <%:Html.TextBoxFor(m=>m.Phone, new {@class="form-control",@placeholder="ENTER YOUR PHONE NUMBER*"}) %>
                        <span class="input-group-addon">
                            <span class="glyphicon glyphicon-phone" aria-hidden="true"></span>
                        </span>
                    </div>
               </div>
           </div>
       </div>
        <div class="container-fluid title-underline">
            <span class="font-avant">
                Login Information
            </span>
        </div>
    <div class="container-fluid" style="padding:15px 0px;">
        <div class="row">
            <div class="col-lg-12">
                <div class="input-group input-group-lg" style="padding:10px 0px">
                        <%:Html.PasswordFor(m=>m.Password, new {@class="form-control",@placeholder="PASSWORD*"}) %>
                    <span class="input-group-addon">
                        <span class="glyphicon glyphicon-lock" aria-hidden="true"></span>
                    </span>
                </div>
            </div>
            <div class="col-lg-12">
                <div class="input-group input-group-lg" >
                        <%:Html.PasswordFor(m=>m.ConfirmPassword, new {@class="form-control",@placeholder="CONFIRM PASSWORD*"}) %>
                    <span class="input-group-addon">
                        <span class="glyphicon glyphicon-lock" aria-hidden="true"></span>
                    </span>
                </div>
            </div>
            <div class="col-lg-4" style="padding-top:15px; padding-bottom:15px">
                <button type="submit" class="btn btn-lg btn-block btn-login">REGISTER</button>
            </div>
            
        </div>
    </div>
    <% } %>
</asp:Content>

<asp:Content ID="scriptsContent" ContentPlaceHolderID="ScriptsSection" runat="server">
    <%--<%: Scripts.Render("~/bundles/jqueryval") %>--%>
</asp:Content>
