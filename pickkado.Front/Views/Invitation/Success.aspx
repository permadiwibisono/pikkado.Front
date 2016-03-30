<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site1.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Success
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h3 class="text-success">Success.</h3>
<% 
   if (String.IsNullOrEmpty(ViewBag.successMessage))
   {%>
      <h4 class="text-success"></h4>
   <% }
   else
   { %>
      <h4 class="text-success"><%:ViewBag.successMessage%></h4>
   <% }%>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="navBar" runat="server">
    <%Html.RenderAction("login_partial","account"); %>  
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="breadcumb" runat="server">
   <li >Home</li>
   <li class="active">Success</li>
</asp:Content>

<asp:Content ID="Content5" ContentPlaceHolderID="ScriptsSection" runat="server">
</asp:Content>
