﻿<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<dynamic>" %>
<% {
    ViewBag.Title = "Error";
 }%>

<h1 class="text-danger">Error.</h1>
<% 
   if (String.IsNullOrEmpty(ViewBag.errorMessage))
   {%>
      <h2 class="text-danger">An error occurred while processing your request.</h2>
   <% }
   else
   { %>
      <h2 class="text-danger"><%:ViewBag.errorMessage%></h2>
   <% }%>

