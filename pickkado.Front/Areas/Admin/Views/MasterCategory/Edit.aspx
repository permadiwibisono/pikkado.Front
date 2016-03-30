<%@ Page Title="" Language="C#" MasterPageFile="~/Areas/Admin/Views/Shared/Admin.Master" Inherits="System.Web.Mvc.ViewPage<pickkado.Front.Areas.Admin.Models.MasterCategoryViewModel>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div >
        <div class="page-title">
            <div class="title">Edit</div>
            <%using (Html.BeginForm("delete", "mastercategory", new { id = ViewContext.RouteData.Values["id"] }, FormMethod.Post, new { id = "F"+ViewContext.RouteData.Values["id"] }))
              {%>
            <button type="submit" class="btn btn-default" data-confirm="Are you sure?" data-confirm-title="Warning" form="F<%:ViewContext.RouteData.Values["id"]%>" data-target="dataConfirmModal"><span class="icon fa fa-trash"></span> Delete</button> 
            <%} %>
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
        <%using (Html.BeginForm("edit", "mastercategory", FormMethod.Post, new { @class="form-horizontal" }))
          {%>
        <div class="row">
            <div class="col-xs-12">
                <div class="card">
                    <div class="card-header">
                        <div class="card-title">
                            
                         <div class="title"><%:ViewContext.RouteData.Values["id"]%></div>
                        </div>
                    </div>
                    <div class="card-body">
                        <div class="form-group">
                            <%:Html.LabelFor(m => m.Name, new { @class = "col-sm-2 control-label" })%>
                            <div class="col-sm-10">
                                <%:Html.TextBoxFor(m => m.Name, new { @class = "col-sm-2 form-control", placeholder = "Category name" })%>
                            </div>
                        </div>
                        <div class="form-group">
                            <%:Html.LabelFor(m => m.ImageUrl, new { @class = "col-sm-2 control-label" })%>
                            <div class="col-sm-10">
                                <%:Html.TextBoxFor(m => m.ImageUrl, new { @class = "col-sm-2 form-control", placeholder = "Image's url" })%>
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
                            <div class="col-xs-offset-2 col-lg-1">
                                <a href="<%:Url.Action("index")%>" class="btn btn-default"><span class="icon fa fa-arrow-left"></span> Back</a>   

                            </div>
                            <div class="col-lg-1">
                                <button type="submit" class="btn btn-primary"><span class="icon fa fa-plus"></span> Save</button>   

                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </div>
        <%} %>
    </div>
   


</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="breadcumber" runat="server">
   <li >Dashboard</li>
   <li >Master Categories</li>
   <li class="active">Edit</li>
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="navBar" runat="server">
    <%Html.RenderAction("login_partial","account"); %>
</asp:Content>