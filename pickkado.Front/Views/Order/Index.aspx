<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site1.Master" Inherits="System.Web.Mvc.ViewPage<pickkado.Front.Models.OrderViewModel>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Gift Information
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="navBar" runat="server">
    <%Html.RenderAction("login_partial","account"); %>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container-fluid">
        <div class="container-fluid title-underline">
            <span class="font-avant">Gift Information</span>
        </div>
        <% using (Html.BeginForm("","order",null,FormMethod.Post,new { @enctype = "multipart/form-data" }))
           { %>
        <%: Html.AntiForgeryToken() %>
        <% if (ViewData.ModelState.Any(x => x.Value.Errors.Any()))
           {%>
                <div id="message" class="alert alert-danger form-message">
                    <a href="#" class="close" data-dismiss="alert">×</a>
                    <%: Html.ValidationSummary("",new { @class = "validation-summary-custom" })%>
                </div>
            <% }%>

        <div class="container-fluid" style="padding:15px 0px;">
            <div class="container-fluid">
                <h4 class="font-helvetica" style="color:#353535; padding-top:40px">
                    What gift do you want ? We will help you to buy it.
                </h4>
            </div>
            <div class="row">
                <div class="col-lg-12">
                    <div class="form-group form-group-lg" style="padding:10px 0px">
                        <%: Html.TextAreaFor(m => m.OrderDetail, new {@class="form-control",placeholder="TEXT*",rows=5 })%>
                    </div>
                </div>
                <div class="col-lg-3" style="padding-top:10px; padding-bottom:10px">
                    <%:Html.TextBoxFor(m=>m.image,new{type="file",id="image", accept="image/x-png, image/gif, image/jpeg"}) %>
                </div>
                <div class="col-lg-12">
                    <div class="form-group">
                        <div class="container-fluid">
                            <h4 class="font-helvetica" style="color:#353535; padding-top:40px">
                                Price
                            </h4>
                        </div>
                        <div class="input-group input-group-lg" style="padding:10px 0px">
                            <span class="input-group-addon">
                                <span  aria-hidden="true">Rp.</span>
                            </span>
                            <%:Html.TextBoxFor(m=>m.Price,new {@class="form-control",id="price",placeholder="TEXT*" }) %>
                        </div>
                    </div>
                </div>
                
            </div>
            <div class="row">
                <div class="col-sm-offset-9 col-sm-3 col-md-offset-9 col-md-3 col-lg-offset-9 col-lg-3">
                    <button type="submit" class="btn btn-block btn-lg btn-login">
                        Next
                        <img src="../../Images/icon/PanahNextIcon.png" class="righticon" />
                    </button>                    
                </div>
            </div>
        </div>
    <% } %>
    </div>


</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ScriptsSection" runat="server">
</asp:Content>
