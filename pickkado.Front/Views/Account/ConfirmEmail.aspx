<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site1.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Confirmed Email
</asp:Content>

<asp:Content ID="Content5" ContentPlaceHolderID="breadcumb" runat="server">
    <li><a href="/">Home</a></li>
    <li class="active">Confirm Email</li>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="navBar" runat="server">
    <%Html.RenderAction("login_partial","account"); %>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<h2>Confirm Email</h2>
<p>
    Thank you for confirming your email. Please click <a class="btn-link" id="loginUrl" style="cursor:pointer">here</a> to login.
</p>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ScriptsSection" runat="server">
    <script type="text/javascript">
        $('#loginUrl').click(function () {
            $.get("../account/login",{"returnUrl":'<%:Url.Action("index", "home")%>'},
            function (data) {
                $("#popup").html(data);
            });

        });
    </script>
</asp:Content>
