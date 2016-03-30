﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Areas/Admin/Views/Shared/Admin.Master" Inherits="System.Web.Mvc.ViewPage<pickkado.Front.Areas.Admin.Models.MasterProductViewModel>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h2>Edit</h2>
    <% using (Html.BeginForm("edit", "masterproduct", new { id = ViewContext.RouteData.Values["id"] == null ? "" : ViewContext.RouteData.Values["id"] }, FormMethod.Post, new { @enctype = "multipart/form-data", @class="form-horizontal" }))
       { %>
    <%: Html.AntiForgeryToken()%>
    
    <%if(!string.IsNullOrEmpty(ViewBag.Success)){%>                               
        <div id="message" class="alert alert-success fadeIn animated">
            <a href="#" class="close" data-dismiss="alert">×</a>
            <strong>Success</strong> <%:ViewBag.Success%>
        </div>
    <%} %>
    <%if(!string.IsNullOrEmpty(ViewBag.Error)){%>                               
        <div id="Div1" class="alert alert-danger fadeIn animated">
            <a href="#" class="close" data-dismiss="alert">×</a>
            <strong>Error</strong> <%:ViewBag.Error%>
        </div>
    <%} %>
    <% if (ViewData.ModelState.Any(x => x.Value.Errors.Any())) {%>
        <div class="alert alert-danger fadeIn animated">
            <a href="#" class="close" data-dismiss="alert">×</a>
            <%:Html.ValidationSummary() %>
        </div>
    <%} %>
    
    <div class="container-fluid" style="padding:15px 0px;">
        <div class="form-group">
            <%:Html.LabelFor(m=>m.Brand,new{@class="col-sm-2 control-label"}) %>
            <div class="col-sm-10">
                <%:Html.TextBoxFor(m=>m.Brand,new{@class="col-sm-2 form-control",placeholder="Brand"}) %>
            </div>
        </div>
        <div class="form-group">
            <%:Html.LabelFor(m=>m.Name,new{@class="col-sm-2 control-label"}) %>
            <div class="col-sm-10">
                <%:Html.TextBoxFor(m=>m.Name,new{@class="col-sm-2 form-control",placeholder="Name"}) %>
            </div>
        </div>
        <div class="form-group">
            <%:Html.LabelFor(m=>m.Weight,new{@class="col-sm-2 control-label"}) %>
            <div class="col-sm-10">
                <%:Html.TextBoxFor(m=>m.Weight,new{@class="col-sm-2 form-control",placeholder="Weight"}) %>
            </div>
        </div>
        <div class="form-group">
            <%:Html.LabelFor(m=>m.Description,new{@class="col-sm-2 control-label"}) %>
            <div class="col-sm-10">
                <%:Html.TextBoxFor(m=>m.Description,new{@class="col-sm-2 form-control",placeholder="Description"}) %>
            </div>
        </div>
        <div class="form-group">
            <%:Html.LabelFor(m=>m.Gender,new{@class="col-sm-2 control-label"}) %>
            <div class="col-sm-10">
                <%:Html.TextBoxFor(m=>m.Gender,new{@class="col-sm-2 form-control",placeholder="Gender"}) %>
            </div>
        </div>
        <div class="form-group">
            <%:Html.LabelFor(m=>m.Price,new{@class="col-sm-2 control-label"}) %>
            <div class="col-sm-10">
                <%:Html.TextBoxFor(m=>m.Price, new{@class="col-sm-2 form-control", placeholder="Price"}) %>
            </div>
        </div>
        <div class="form-group">
            <%:Html.LabelFor(m=>m.Category,new{@class="col-sm-2 control-label"}) %>
            <div class="col-sm-10">
                <%:Html.TextBoxFor(m=>m.Category,new{@class="col-sm-2 form-control",placeholder="Category"}) %>
            </div>
        </div>
        <div class="form-group">
            <div class="col-lg-1">
                <a href="<%:Url.Action("index") %>" class="btn btn-default"><span class="icon fa fa-arrow-left"></span> Back</a>
            </div>
            <div class="col-lg-1">
                <button type="submit" class="btn btn-primary"><span class="icon fa fa-plus"></span> Save</button>   
            </div>

        </div>
    </div>
    <%} %>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="breadcumber" runat="server">
   <li>Dashboard</li>
   <li>Master Product</li>
   <li class="active">Edit</li>
</asp:Content>
