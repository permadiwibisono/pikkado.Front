<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site1.Master" Inherits="System.Web.Mvc.ViewPage<pickkado.Front.Models.CategoryViewModel>" %>

<asp:Content ID="categoryTitle" ContentPlaceHolderID="TitleContent" runat="server">
    Pickkado Suggest - Choose Category & Budget
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="navBar" runat="server">
    <%Html.RenderAction("login_partial","account"); %>
</asp:Content>

<asp:Content ID="categoryContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container-fluid title-underline">
        <span class="font-avant" style="font-size:15px">
            Choose Category
        </span>
    </div>

    <% using (Html.BeginForm())
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
            <div class="row">
                <%:Html.HiddenFor(m => m.CategoryId)%>           
                <% Html.RenderPartial("category_partial", (List<pickkado.Entities.Category>)ViewBag.CategoryList); %>   
            </div>
        </div>
        <div class="container-fluid title-underline">
            <span class="font-avant" style="font-size:15px">
                Enter Budget
            </span>
        </div>
        <div class="container-fluid" style="padding:15px 0px;">
            <div class="row">
                <div class="col-lg-6">
                    <div class="input-group input-group-lg" style="padding:10px 0px">
                        <span class="input-group-addon">
                            <span  aria-hidden="true">Rp.</span>
                        </span>
                            <%:Html.TextBoxFor(m => m.Budget, new { @class = "form-control textbox", @placeholder = "ENTER YOUR BUDGET*" })%>
                        
                    </div>
                </div>
            </div>
            <div class="row" style="margin:30px 0px 30px 0px">
                <div class="col-lg-2" style="padding-top:15px; padding-bottom:15px">
                    <button type="button" class="btn btn-default btn-lg btn-block btn-login"> <img src="../../images/icon/PanahBackIcon.png" class="lefticon"/> Back</button>
                </div>
                <div class="col-lg-3" style="padding-top:15px; padding-bottom:15px; float:right">
                    <button type="submit" class="btn btn-default btn-lg btn-block btn-login"> Next <img src="../../images/icon/PanahNextIcon.png" class="righticon"/> </button>
                </div>
            </div>
        </div>
    <% } %>

</asp:Content>

<asp:Content ID="scriptsContent" ContentPlaceHolderID="ScriptsSection" runat="server">
    <%--<%: Scripts.Render("~/bundles/jqueryval") %>--%>
    <script>
        $('.circle-gray').hover(function () {
            var title = $(this).find('.title');
            title.show();
            var img = $(this).find('img').attr('src');
            $(this).find('img').attr('src', img.replace('.png', '2.png'));
        }, function () {
            var title = $(this).find('.title');
            title.hide();
            var img = $(this).find('img').attr('src');
            $(this).find('img').attr('src', img.replace('2.png', '.png'));
        });
        $('.circle-gray').click(function () {
            //alert('a');
            $('.circle-gray').removeClass('selected');
            $(this).addClass('selected');
            $('#CategoryId').val($(this).find("img").attr('id'));
            //alert($(this).attr('id'));
        });
    </script>
</asp:Content>
