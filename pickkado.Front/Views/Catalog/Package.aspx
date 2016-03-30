<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site1.Master" Inherits="System.Web.Mvc.ViewPage<pickkado.Front.Models.PackageViewModel>" %>

<asp:Content ID="packageTitle" ContentPlaceHolderID="TitleContent" runat="server">
    Package & Giftcard
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="navBar" runat="server">
    <%Html.RenderAction("login_partial","account"); %>
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="breadcumb" runat="server">
    <li><a href="/">Home</a></li>
    <li>Catalog</li>
    <li ><a href="<%:ViewBag.LinkBack %>"><%:ViewBag.ProductName %></a></li>
    <li class="active">Package & Giftcard</li>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container-fluid title-underline">
        <span class="font-avant" style="font-size:15px">
            Choose Package
        </span>
    </div>

    <% using (Html.BeginForm())
       { %>
        <%: Html.AntiForgeryToken()%>
        <% if (ViewData.ModelState.Any(x => x.Value.Errors.Any()))
           {%>
                <div id="message" class="alert alert-danger form-message">
                    <a href="#" class="close" data-dismiss="alert">×</a>
                    <%: Html.ValidationSummary("",new { @class = "validation-summary-custom" })%>
                </div>
            <% }%>

        <div class="container-fluid" style="padding:15px 0px;">
            <div class="row" id="package-list">
                <% Html.RenderPartial("package_partial", (pickkado.Front.Models.PackagePartialView)ViewBag.PackagePartialView); %> 
            </div>
        </div>
                <%:Html.HiddenFor(m => m.PackageId)%>
        <div class="container-fluid title-underline">
            <span class="font-avant" style="font-size:15px">
                Choose Gift Card
            </span>
        </div>
        
        <div class="container-fluid" style="padding:15px 0px;">
            <div class="row" id="giftcard-list">
                <% Html.RenderPartial("giftcard_partial", (pickkado.Front.Models.GiftCardPartialView)ViewBag.GiftcardPartialView); %> 
            </div>
        </div>
                <%:Html.HiddenFor(m => m.GiftcardId)%>
        <div class="container-fluid" style="padding:15px 0px;">
            <div class="row" style="margin:30px 0px 30px 0px">
                <div class="col-xm-2 col-sm-2 col-md-2 col-lg-2">
                    <a href="<%:ViewBag.LinkBack%>"  class="btn btn-lg btn-block btn-login"> <img src="../../images/icon/PanahBackIcon.png" class="lefticon"/> Back</a>
                </div>
                <div class="col-xm-offset-7 col-xm-3 col-sm-offset-7 col-sm-3 col-md-offset-7 col-md-3 col-lg-offset-7 col-lg-3" >
                    <button type="submit" class="btn btn-lg btn-block btn-login"> Next <img src="../../images/icon/PanahNextIcon.png" class="righticon"/> </button>
                </div>
            </div>
        </div>

    <% } %>

</asp:Content>

<asp:Content ID="scriptsContent" ContentPlaceHolderID="ScriptsSection" runat="server">
    <%: Scripts.Render("~/bundles/jqueryval") %>
    <script>
        $('[data-toggle="tooltip"]').tooltip();
        $('#package-list .circle-gray').click(function () {
            //alert('a');
            $('#package-list .circle-gray').removeClass('selected');
            $(this).addClass('selected');
            var target = $(this).attr('data-bind-name');
            $(target).val($(this).find("img").attr('id'));
            //$('#PackageId').val($(this).find("img").attr('id'));
            //$('#CategorySelected_CategoryName').val($(this).find("img").attr('alt'));
            //alert($(this).attr('id'));
        });
        $('#giftcard-list .circle-gray').click(function () {
            //alert('a');
            $('#giftcard-list .circle-gray').removeClass('selected');
            $(this).addClass('selected');
            var target = $(this).attr('data-bind-name');
            $(target).val($(this).find("img").attr('id'));
            //$('#CategorySelected_CategoryName').val($(this).find("img").attr('alt'));
            //alert($(this).attr('id'));
        });
    </script>
</asp:Content>