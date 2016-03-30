<%@ Page Title="" Language="C#" MasterPageFile="~/Areas/Admin/Views/Shared/Admin.Master" Inherits="System.Web.Mvc.ViewPage<pickkado.Front.Areas.Admin.Models.MasterVoucherViewModel>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <% using (Html.BeginForm("edit", "mastervoucher", new { id = ViewContext.RouteData.Values["id"] == null ? "" : ViewContext.RouteData.Values["id"] }, FormMethod.Post, new { @class="form-horizontal" }))
       { %>
    <%: Html.AntiForgeryToken()%>
    

    <div class="page-title">
        <div class="title">
            Edit
        </div>
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
                <div class="card-header"></div>
                <div class="card-body">
                    <div class="form-group">
                        <%:Html.LabelFor(m=>m.VoucherId,new{@class="col-sm-2 control-label"}) %>
                        <div class="col-sm-10">
                            <%if (ViewContext.RouteData.Values["id"] != null)
                              {%>
                                 <%:Html.TextBoxFor(m => m.VoucherId, new { @class = "col-sm-2 form-control", placeholder = "Voucher id",disabled="disabled" })%>
                              <%}
                              else
                              {%>
                                  <%:Html.TextBoxFor(m => m.VoucherId, new { @class = "col-sm-2 form-control", placeholder = "Voucher id" })%>
                              <%}
                                %>
                        </div>
                    </div>
                    <div class="form-group">
                        <%:Html.LabelFor(m=>m.Name,new{@class="col-sm-2 control-label"}) %>
                        <div class="col-sm-10">
                            <%:Html.TextBoxFor(m=>m.Name,new{@class="form-control",placeholder="Voucher name"}) %>
                        </div>
                    </div>
                    <div class="form-group">
                        <%:Html.LabelFor(m=>m.VoucherType,new{@class="col-sm-2 control-label"}) %>
                        <div class="col-sm-4">
                            <select name="VoucherType" class="selectpicker" title="Choose your voucher type...">
                                <%if(Model!=null) {%>
                                <option <%:Model.VoucherType=="Nominal"?"selected":"" %>>Nominal</option>
                                <option <%:Model.VoucherType=="Percentage"?"selected":"" %>>Percentage</option>
                                <%}else{ %>
                                <option >Nominal</option>
                                <option >Percentage</option>
                                <%} %>
                            </select>
                            <%--<%:Html.TextBoxFor(m=>m.VoucherType,new{@class="col-sm-2 form-control",placeholder=""}) %>--%>
                        </div>
                        <%:Html.LabelFor(m=>m.VoucherDiscount,new{@class="col-sm-2 control-label"}) %>
                        <div class="col-sm-4">
                            <%:Html.TextBoxFor(m=>m.VoucherDiscount,new{@class="form-control",placeholder="Voucher disc"}) %>
                        </div>
                    </div>
                    <div class="form-group">
                        <%:Html.LabelFor(m=>m.Quantity,new{@class="col-sm-2 control-label"}) %>
                        <div class="col-sm-4">
                            <%:Html.TextBoxFor(m=>m.Quantity,new{@class="col-sm-2 form-control",placeholder="Qty"}) %>
                        </div>
                        <div class="col-sm-2">
                            <div class="checkbox3 checkbox-round">
                                <input data-val="true" data-val-required="The Limit by Quantity field is required." id="IsLimitQty" name="IsLimitQty" value="true" type="checkbox"/>
                                <label for="IsLimitQty">Limit by quantity?</label>
                            </div>
                            <input name="IsLimitQty" value="false" type="hidden"/>
                        </div>
                    </div>
                    <div class="form-group ">
                        <%:Html.LabelFor(m=>m.FromDate,new{@class="col-sm-2 control-label"}) %>
                        <div class="col-sm-4 date">
                            <%:Html.TextBoxFor(m=>m.FromDate,new{@class="datepicker form-control",placeholder="From date to valid this voucher"}) %>
                        </div>
                        <%:Html.LabelFor(m=>m.ToDate,new{@class="col-sm-1 control-label"}) %>
                        <div class="col-sm-5 date">
                            <%:Html.TextBoxFor(m=>m.ToDate,new{@class="datepicker form-control",placeholder="To date to valid this voucher"}) %>
                        </div>
                    </div>
                    <div class="form-group">
                        <%:Html.LabelFor(m=>m.MinTransaction,new{@class="col-sm-2 control-label"}) %>
                        <div class="col-sm-10">
                            <%:Html.TextBoxFor(m=>m.MinTransaction,new{@class="form-control",placeholder="Minimum transaction (Rp)"}) %>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-xs-offset-2 col-lg-1">
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
    <%} %>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="../../../../Content/bootstrap/css/datepicker.css" />
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="breadcumber" runat="server">
   <li >Dashboard</li>
   <li >Master Vouchers</li>
   <li class="active">Edit</li>
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ScriptContent" runat="server">
<script src="../../../../Scripts/bootstrap/bootstrap-datepicker.js"></script>
<script>
    $('.datepicker').datepicker({
        format: 'dd/mm/yyyy'
    }).on('changeDate', function () {
        $(".datepicker").datepicker('hide');
    });
</script>
</asp:Content>

<asp:Content ID="Content5" ContentPlaceHolderID="navBar" runat="server">
    <%Html.RenderAction("login_partial","account"); %>
</asp:Content>