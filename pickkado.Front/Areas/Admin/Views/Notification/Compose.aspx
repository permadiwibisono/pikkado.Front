<%@ Page Title="" Language="C#" MasterPageFile="~/Areas/Admin/Views/Shared/Admin.Master" Inherits="System.Web.Mvc.ViewPage<pickkado.Front.Areas.Admin.Models.NotificationViewModel>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <% using (Html.BeginForm("compose", "notification", new { id = ViewContext.RouteData.Values["id"] == null ? "" : ViewContext.RouteData.Values["id"] }, FormMethod.Post, new { @enctype = "multipart/form-data",@class="form-horizontal" }))
       { %>
    <%: Html.AntiForgeryToken()%>    
    
    <div class="page-title">
        <span class="title">Compose</span>
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
    </div>
    <div class="row">
        <div class="col-xs-12">
            <div class="card">
                <div class="card-header">
                    <%if (ViewContext.RouteData.Values["id"] != null)
                        { %>
                        <div class="card-title">
                                <div class="title"><%:ViewContext.RouteData.Values["id"] %></div>
                        </div>
                    <%} %>
                </div>
                <div class="card-body">
                    <div class="form-group">
                        <%:Html.LabelFor(m=>m.Type,new{@class="col-sm-2 control-label"}) %>
                        <div class="col-sm-10">
                            <%:Html.TextBoxFor(m=>m.Type,new{@class="col-sm-2 form-control",placeholder="Type"}) %>
                        </div>
                    </div>
                    <div class="form-group">
                        <%:Html.LabelFor(m=>m.UserId,new{@class="col-sm-2 control-label"}) %>
                        <div class="col-sm-10">
                            <%:Html.TextBoxFor(m=>m.UserId,new{@class="col-sm-2 form-control",placeholder="User Id"}) %>
                        </div>
                    </div>
                    <div class="form-group">
                        <%:Html.LabelFor(m=>m.Title,new{@class="col-sm-2 control-label"}) %>
                        <div class="col-sm-10">
                            <%:Html.TextBoxFor(m=>m.Title,new{@class="col-sm-2 form-control",placeholder="Title"}) %>
                        </div>
                    </div>
                    <div class="form-group">
                        <%:Html.LabelFor(m=>m.Description,new{@class="col-sm-2 control-label"}) %>
                        <div class="col-sm-10">
                            <%:Html.TextBoxFor(m=>m.Description,new{@class="col-sm-2 form-control",placeholder="Description"}) %>
                        </div>
                    </div>
                    <div class="form-group">
                        <%:Html.LabelFor(m=>m.Link,new{@class="col-sm-2 control-label"}) %>
                        <div class="col-sm-10">
                            <%:Html.TextBoxFor(m=>m.Link,new{@class="col-sm-2 form-control",placeholder="Link"}) %>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-lg-2"></div>
                        <div class="col-lg-1">
                            <a href="<%:Url.Action("index") %>" class="btn btn-default"><span class="icon fa fa-arrow-left"></span> Back</a>
                        </div>
                        <div class="col-lg-1">
                            <button type="submit" class="btn btn-primary"><span class="icon fa fa-plus"></span> Save</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="container-fluid" style="padding:15px 0px;">
    </div>
    <%} %>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="breadcumber" runat="server">
    <li>Dashboard</li>
    <li>Notification</li>
    <li class="active">Compose</li>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="navBar" runat="server">
    <%Html.RenderAction("login_partial","account"); %>
</asp:Content>