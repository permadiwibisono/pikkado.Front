<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site1.Master" Inherits="System.Web.Mvc.ViewPage<pickkado.Front.Models.InputGiftcardMessageViewModel>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Giftcard
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container-fluid title-underline" style="margin-bottom:20px">
        <span class="font-avant" style="font-size:15px">
            Ucapan kamu kepadanya
        </span>
    </div>
    <div class="container-fluid" style="padding:0px">
    <% using (Html.BeginForm("giftcard", "invitation", new {code=Request.Params["code"]}, FormMethod.Post))
       { %>
        <%: Html.AntiForgeryToken()%>
        <% if (ViewData.ModelState.Any(x => x.Value.Errors.Any()))
           {%>
            <div id="message" class="alert alert-danger form-message">
                <a href="#" class="close" data-dismiss="alert">×</a>
                <%: Html.ValidationSummary("", new { @class = "validation-summary-custom" })%>
            </div>
        <% }%>

        <div class="container-fluid" style="padding:15px 0px;">
            <div class="col-xs-12" style="padding:0px;padding-bottom:10px">
                <div class="form-group form-group-lg" >
                    <%:Html.HiddenFor(m => m.Id)%>
                    <%:Html.TextAreaFor(m => m.Message, new { rows = "5", @class = "form-control", placeholder = "TYPE YOUR WORDS FOR THE GIFT CARD" })%>
                </div>

            </div>
            <%if (!Request.IsAuthenticated)
              { %>
            <div class="col-xs-12" style="padding:0px; padding-bottom:10px;">
                <span>Untuk submit kamu harus login terlebih dahulu</span>
            </div>
            <div class="col-xs-12" style="padding:0px; padding-left:0px; padding-bottom:10px;">               
                
                <div class="col-xs-12 col-lg-6" style="padding:0px; padding-right:10px;">
                    <div class="form-group form-group-lg" >
                        <%:Html.HiddenFor(m => m.EmailLogin)%>
                        <%:Html.TextBoxFor(m => m.EmailLogin, new { @class = "form-control", disabled = "disabled", placeholder = "EMAIL" })%>
                    </div>
                    <div class="form-group form-group-lg" >
                        <%:Html.PasswordFor(m => m.PasswordLogin, new { @class = "form-control", placeholder = "PASSWORD" })%>
                    </div>
                    <div class="col-xs-12" style="text-align:right">
                        <div class="form-group form-group-lg" >
                            <a class="btn btn-link link-green" data-toggle="collapse" data-target="#divRegister">Register, jika kamu tidak punya akun</a>
                        </div>
                    </div>

                </div>
                <div class="col-xs-12 col-lg-6 collapse" style="padding:0px"  id="divRegister" >
                    <div class="col-xs-12 col-lg-6" style="padding:0px">
                        <div class="form-group form-group-lg" >
                            <%:Html.TextBoxFor(m => m.Firstname, new { @class = "form-control", placeholder = "FIRSTNAME" })%>
                        </div>
                    </div>
                    <div class="col-xs-12 col-lg-6" style="padding:0px">
                        <div class="form-group form-group-lg" >
                            <%:Html.TextBoxFor(m => m.Lastname, new { @class = "form-control", placeholder = "LASTNAME" })%>
                        </div>
                    </div>
                    <div class="form-group form-group-lg" >
                        <%:Html.HiddenFor(m => m.EmailRegister)%>
                        <%:Html.TextBoxFor(m => m.EmailRegister, new { @class = "form-control", disabled = "disabled", placeholder = "EMAIL" })%>
                    </div>
                    <div class="form-group form-group-lg" >
                        <%:Html.PasswordFor(m => m.PasswordRegister, new { @class = "form-control", placeholder = "PASSWORD" })%>
                    </div>
                    <div class="form-group form-group-lg" >
                        <%:Html.PasswordFor(m => m.ConfirmPasswordRegister, new { @class = "form-control", placeholder = "PASSWORD" })%>
                    </div>

                </div>
            </div>
            <%} %>
            <div class=" col-xs-4"  style="padding: 0px;padding-bottom:10px">                 
                <button type="submit" class="btn btn-lg btn-block btn-login">SUBMIT</button>
            </div>

        </div>
        <%} %>
    </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="navBar" runat="server">
    <%Html.RenderAction("login_partial","account"); %>
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="breadcumb" runat="server">
</asp:Content>

<asp:Content ID="Content5" ContentPlaceHolderID="ScriptsSection" runat="server">
    <%: Scripts.Render("~/bundles/jqueryval") %>
</asp:Content>
