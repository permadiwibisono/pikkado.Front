<%@ Page Title="" Language="C#" MasterPageFile="~/Areas/Admin/Views/Shared/Admin.Master" Inherits="System.Web.Mvc.ViewPage<pickkado.Front.Areas.Admin.Models.MasterGiftCardViewModel>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <% using (Html.BeginForm("edit", "mastergiftcard", new { id = ViewContext.RouteData.Values["id"] == null ? "" : ViewContext.RouteData.Values["id"] }, FormMethod.Post, new { @enctype = "multipart/form-data",@class="form-horizontal" }))
       { %>
    <%: Html.AntiForgeryToken()%>    
    
    <div class="page-title">
        <span class="title">Edit</span>
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
                        <div class="col-lg-offset-2 col-lg-1">
                            <%if (ViewContext.RouteData.Values["id"] != null)
                              { 
                                  if(Model.image==null){ %>
                            <img src="../../../../Images/no-thumb.png" class="img-rounded" height="200" width="200"/>
                            <%} else{%>
                            <img src="data:image;base64,<%: System.Convert.ToBase64String(Model.image)%>" class="img-rounded" height="200" width="200" />
                    
                              <%} %>
                            <%} else{%>
                            <img src="../../../../Images/no-thumb.png" class="img-rounded" height="200" width="200"/>
                            <%} %>
                            <input type="file" value="Add picture" name="imagepost" />

                        </div>
                    </div>
                    <div class="form-group">
                        <%:Html.LabelFor(m=>m.Name,new{@class="col-sm-2 control-label"}) %>
                        <div class="col-sm-10">
                            <%:Html.TextBoxFor(m=>m.Name,new{@class="col-sm-2 form-control",placeholder="Package name"}) %>
                        </div>
                    </div>
                    <div class="form-group">
                        <%:Html.LabelFor(m=>m.Quantity,new{@class="col-sm-2 control-label"}) %>
                        <div class="col-sm-10">
                            <%:Html.TextBoxFor(m=>m.Quantity,new{@class="col-sm-2 form-control",placeholder="Quantity"}) %>
                        </div>
                    </div>
                    <div class="form-group">
                        <%:Html.LabelFor(m=>m.Price,new{@class="col-sm-2 control-label"}) %>
                        <div class="col-sm-10">
                            <%:Html.TextBoxFor(m=>m.Price,new{@class="col-sm-2 form-control",placeholder="Price (Rp)"}) %>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-offset-2 col-sm-10">
                            <div class="checkbox">
                              <label><%:Html.CheckBoxFor(m => m.Visible)%> Visible</label>
                            </div>              

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
    <li >Dashboard</li>
    <li >Master Packages</li>
    <li class="active">Edit</li>
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="navBar" runat="server">
    <%Html.RenderAction("login_partial","account"); %>
</asp:Content>