<%@ Page Title="" Language="C#" MasterPageFile="~/Areas/Admin/Views/Shared/Admin.Master" Inherits="System.Web.Mvc.ViewPage<pickkado.Front.Areas.Admin.Models.ProfileViewModel>" %>

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
                        <%:Html.LabelFor(m=>m.FirstName,new{@class="col-sm-2 control-label"}) %>
                        <div class="col-sm-10">
                            <%:Html.TextBoxFor(m=>m.FirstName,new{@class="col-sm-2 form-control",placeholder="First name"}) %>
                        </div>
                    </div>
                    <div class="form-group">
                        <%:Html.LabelFor(m=>m.Lastname,new{@class="col-sm-2 control-label"}) %>
                        <div class="col-sm-10">
                            <%:Html.TextBoxFor(m=>m.Lastname,new{@class="col-sm-2 form-control",placeholder="Last name"}) %>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">Birth place and date</label>
                        <%--<%:Html.LabelFor(m=>m.Birthplace,new{@class="col-sm-2 control-label"}) %>--%>
                        <div class="col-sm-5">
                            <%:Html.TextBoxFor(m=>m.Birthplace,new{@class="col-sm-2 form-control",placeholder="Birth place"}) %>
                        </div>
                        <div class="col-sm-5">
                            <%:Html.TextBoxFor(m=>m.Birthdate,new{@class="datepicker col-sm-2 form-control",placeholder="Birth place"}) %>
                        </div>
                    </div>
                    <div class="form-group">
                        <%:Html.LabelFor(m=>m.Gender,new{@class="col-sm-2 control-label"}) %>
                        <div class="col-sm-10">
                            <label for="radioPria">
                                <input type="radio" id="radioPria" value="0" <%:Model.Gender!=null&&Model.Gender==0?"checked":"" %> name="Gender"/>
                                Pria
                            </label>
                            <label for="radioWanita">
                                <input type="radio" id="radioWanita" value="0" <%:Model.Gender!=null&&Model.Gender==1?"checked":"" %> name="Gender"/>
                                Wanita
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <%:Html.LabelFor(m=>m.PhoneNumber,new{@class="col-sm-2 control-label"}) %>
                        <div class="col-sm-10">
                            <%:Html.TextBoxFor(m=>m.PhoneNumber,new{@class="col-sm-2 form-control",placeholder="Phone number"}) %>
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
    <link rel="stylesheet" href="../../../../Content/bootstrap/css/datepicker.css" />
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="breadcumber" runat="server">
   <li >Dashboard</li>
   <li class="active">Profile</li>
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="navBar" runat="server">
    <%Html.RenderAction("login_partial","account"); %>
</asp:Content>

<asp:Content ID="Content5" ContentPlaceHolderID="ScriptContent" runat="server">
<script src="../../../../Scripts/bootstrap/bootstrap-datepicker.js"></script>
    <script>

        $('.datepicker').datepicker({
            format: 'dd/mm/yyyy'
        }).on('changeDate', function () {
            $(".datepicker").datepicker('hide');
        });
    </script>
</asp:Content>
