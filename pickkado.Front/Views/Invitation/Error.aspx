<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site1.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Error
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h3 class="text-danger">Error.</h3>
<% 
   if (String.IsNullOrEmpty(ViewBag.errorMessage))
   {%>
      <h4 class="text-danger">An error occurred while processing your request.</h4>
   <% }
   else
   { %>
      <h4 class="text-danger"><%:ViewBag.errorMessage%></h4>
   <% }%>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="navBar" runat="server">
    <%Html.RenderAction("login_partial","account"); %>
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="breadcumb" runat="server">
   <li >Home</li>
   <li class="active">Error</li>
</asp:Content>

<asp:Content ID="Content5" ContentPlaceHolderID="ScriptsSection" runat="server">
</asp:Content>
