<%@ Page Title="" Language="C#" MasterPageFile="~/Areas/Vendor/Views/Shared/Vendor.Master" Inherits="System.Web.Mvc.ViewPage<pickkado.Front.Areas.Vendor.Models.ProfileViewModel>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <% using (Html.BeginForm("", "account", FormMethod.Post, new { @enctype = "multipart/form-data",@class="form-horizontal" }))
       { %>
    <%: Html.AntiForgeryToken()%> 
    <div class="page-title">
        <span class="title">Your Profile</span>
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
                </div>
                <div class="card-body">
                    <div class="form-group">
                        <div class="col-lg-offset-2 col-lg-1">
                            
                        </div>
                    </div>
                    <div class="form-group">
                        <%:Html.LabelFor(m=>m.Name,new{@class="col-sm-2 control-label"}) %>
                        <div class="col-sm-10">
                            <%:Html.TextBoxFor(m=>m.Name,new{@class="col-sm-2 form-control",placeholder="(Required)"}) %>
                        </div>
                    </div>
                    <div class="form-group">
                        <%:Html.LabelFor(m=>m.Address,new{@class="col-sm-2 control-label"}) %>
                        <div class="col-sm-10">
                            <%:Html.TextAreaFor(m=>m.Address,new{@class="col-sm-2 form-control",placeholder="(Required)",row="3"}) %>
                        </div>
                    </div>
                    <div class="form-group">
                        <%:Html.LabelFor(m=>m.Kelurahan,new{@class="col-sm-2 control-label"}) %>
                        <div class="col-sm-10">
                            <%:Html.TextBoxFor(m=>m.Kelurahan,new{@class="col-sm-2 form-control",placeholder="Leave it blank if empty"}) %>
                        </div>
                    </div>
                    <div class="form-group">
                        <%:Html.LabelFor(m=>m.Kecamatan,new{@class="col-sm-2 control-label"}) %>
                        <div class="col-sm-10">
                            <%:Html.TextBoxFor(m=>m.Kecamatan,new{@class="col-sm-2 form-control",placeholder="Leave it blank if empty"}) %>
                        </div>
                    </div>
                    <div class="form-group">
                        <%:Html.LabelFor(m=>m.Kota,new{@class="col-sm-2 control-label"}) %>
                        <div class="col-sm-10">
                            <%:Html.TextBoxFor(m=>m.Kota, new{@class="col-sm-2 form-control"}) %>
                        </div>
                    </div>
                    <div class="form-group">
                        <%:Html.LabelFor(m=>m.PhoneNumber,new{@class="col-sm-2 control-label"}) %>
                        <div class="col-sm-10">
                            <%:Html.TextBoxFor(m=>m.PhoneNumber,new{@class="col-sm-2 form-control",placeholder="(Required)"}) %>
                        </div>
                    </div>
                    <div class="form-group">
                        <%:Html.LabelFor(m=>m.WebAddress,new{@class="col-sm-2 control-label"}) %>
                        <div class="col-sm-10">
                            <%:Html.TextBoxFor(m=>m.WebAddress,new{@class="col-sm-2 form-control",placeholder="Add Http:// first. example : Http://www.facebook.com. Leave it blank if empty."}) %>
                        </div>
                    </div>
                    <div class="form-group">
                        <%:Html.LabelFor(m=>m.Email,new{@class="col-sm-2 control-label"}) %>
                        <div class="col-sm-10">
                            <%:Html.HiddenFor(m=>m.Email) %>
                            <%:Html.TextBoxFor(m=>m.Email,new{@class="col-sm-2 form-control",disabled="disabled", placeholder="(Required)"}) %>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">Change password</label>
                    </div>
                    <div class="form-group">
                        <%:Html.LabelFor(m=>m.CurrentPassword,new{@class="col-sm-2 control-label"}) %>
                        <div class="col-sm-10">
                            <%:Html.PasswordFor(m=>m.CurrentPassword,new{@class="col-sm-2 form-control",placeholder="Current password"}) %>
                        </div>
                    </div>
                    <div class="form-group">
                        <%:Html.LabelFor(m=>m.NewPassword,new{@class="col-sm-2 control-label"}) %>
                        <div class="col-sm-10">
                            <%:Html.PasswordFor(m=>m.NewPassword,new{@class="col-sm-2 form-control",placeholder="New password"}) %>
                        </div>
                    </div>
                    <div class="form-group">
                        <%:Html.LabelFor(m=>m.ConfirmPassword,new{@class="col-sm-2 control-label"}) %>
                        <div class="col-sm-10">
                            <%:Html.PasswordFor(m=>m.ConfirmPassword,new{@class="col-sm-2 form-control",placeholder="Confirm password"}) %>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-lg-2"></div>
                        <div class="col-lg-1">
                            <a href="<%:Url.Action("","home") %>" class="btn btn-default"><span class="icon fa fa-arrow-left"></span> Back</a>   

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


</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="breadcumber" runat="server">
   <li >Dashboard</li>
   <li class="active">Profile</li>
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="navBar" runat="server">
    <%Html.RenderAction("login_partial","account"); %>
</asp:Content>

<asp:Content ID="Content5" ContentPlaceHolderID="ScriptContent" runat="server">
</asp:Content>
