<%@ Page Title="" Language="C#" MasterPageFile="~/Areas/Admin/Views/Shared/Admin.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

<h2>New</h2>
<div class="container">
    
    <%using(Html.BeginForm("new","masterbrand",FormMethod.Post)){%>
    <div class="row">
        <div class="col-lg-2">
            <%:Html.LabelFor(m=>m.Name) %>
        </div>
        <div class="col-lg-6">
            <%:Html.TextBoxFor(m=>m.Name,new{@class="form-control"}) %>
            <%:Html.ValidationMessageFor(m=>m.Name) %>
        </div>
        <div class="col-lg-2">
            <a href="../admin/masterbrand" class="btn btn-default"><span class="icon fa fa-back"></span> Back</a>   

        </div>
        <div class="col-lg-2">
            <button type="submit" class="btn btn-primary"><span class="icon fa fa-plus"></span> Save</button>   

        </div>
    </div>
    <%} %>
</div>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
    
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="breadcumber" runat="server">
   <li >Dashboard</li>
   <li >Master Brands</li>
   <li class="active">New</li>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="navBar" runat="server">
    <%Html.RenderAction("login_partial","account"); %>
</asp:Content>
