<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site1.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="resultTitle" ContentPlaceHolderID="TitleContent" runat="server">
    Pickkado Suggest - Result
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="navBar" runat="server">
    <%Html.RenderAction("login_partial","account"); %>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container-fluid title-underline">
        <span class="font-avant" style="font-size:15px">
            Gift Suggestion
        </span>
    </div>

    <% using (Html.BeginForm()) { %>
        <%: Html.AntiForgeryToken() %>
        <%: Html.ValidationSummary() %>

        <div class="container-fluid" style="padding:15px 0px;">
            <div class="row">
                <div class="col-xs-12 col-sm-6 col-md-4">
                    <a href="/suggest/details">
                        <div class="thumbnail">
                            <img src="../../images/Shoesjackass.jpg"/>
                        </div>
                    </a>
                </div>
                <div class="col-xs-12 col-sm-6 col-md-4">
                    <a href="/suggest/details">
                        <div class="thumbnail">
                            <img src="../../images/ShoesVans1.jpg"/>
                        </div>
                    </a>
                </div>
                <div class="col-xs-12 col-sm-6 col-md-4">
                    <a href="/suggest/details">
                        <div class="thumbnail">
                            <img src="../../images/ShoesNike.jpg"/>
                        </div>
                    </a>
                </div>
                <a href="/Suggest/Result" style="margin-top:50px; margin-right:50px; float:right; color:#918E89">
                    <img src="../../images/Refresh.png"/>
                    Refresh
                </a>
            </div>
            <div class="row" style="margin:30px 0px 30px 0px">
                <div class="col-lg-2" style="padding-top:15px; padding-bottom:15px">
                    <a href="../suggest" style="text-decoration:none">
                        <button type="button" class="btn btn-default btn-lg btn-block btn-login"> <img src="../../images/icon/PanahBackIcon.png"/> Back</button>
                    </a>
                </div>
            </div>
        </div>

    <% } %>
</asp:Content>

<asp:Content ID="scriptsContent" ContentPlaceHolderID="ScriptsSection" runat="server">
    <%: Scripts.Render("~/bundles/jqueryval") %>
</asp:Content>
