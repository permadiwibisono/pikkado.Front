<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<pickkado.Entities.Transaction>" %>
                                

<div class="row" style="padding:2px 0;">
    <div class="form-group">
        <label class="col-sm-2 control-label">
                STATUS:
            </label>
            <div class="col-sm-10">
                <%:Html.TextBoxFor(m=>m.Status,new{@class="form-control", disabled="disabled"}) %>
            </div>
        </div>
    </div>
<div class="row" style="padding:2px 0;">
    <div class="form-group">
        <label class="col-sm-2 control-label">
                Transaction Id:
            </label>
            <div class="col-sm-10">
                <%:Html.TextBoxFor(m=>m.Id,new{@class="form-control", disabled="disabled"}) %>
            </div>
        </div>
    </div>
<div class="row" style="padding:2px 0;">
    <div class="form-group">
        <label class="col-sm-2 control-label">
            Transaction Date:
        </label>
        <div class="col-sm-10">
                <%:Html.TextBoxFor(m=>m.TransDate,new{@class="form-control", disabled="disabled"}) %>
        </div>
    </div>
</div>
<div class="row" style="padding:2px 0;">
    <div class="form-group">
        <label class="col-sm-2 control-label">
            Type:
        </label>
        <div class="col-sm-10">
                <%:Html.TextBoxFor(m=>m.TransactionType,new{@class="form-control", disabled="disabled"}) %>
        </div>
    </div>
</div>
<div class="row" style="padding:2px 0;">
    <div class="form-group">
        <label class="col-sm-2 control-label">
            Is Group:
        </label>
        <div class="col-sm-10">
                <%:Html.CheckBoxFor(m=>m.IsGroup,new{ disabled="disabled"}) %>
        </div>
    </div>
</div>
<div class="row" style="padding:2px 0;">
    <div class="form-group">
        <label class="col-sm-2 control-label">
            Group Member Count:
        </label>
        <div class="col-sm-10">
                <%:Html.TextBoxFor(m=>m.GroupCount,new{@class="form-control", disabled="disabled"}) %>
        </div>
    </div>
</div>
<div class="row" style="padding:2px 0;">
    <div class="form-group">
        <label class="col-sm-2 control-label">
            Product Price:
        </label>
        <div class="col-sm-10">
            <input type="text" value="Rp. <%:Model.ProductPrice %>"class="form-control" disabled="disabled" />
        </div>
    </div>
</div>
<div class="row" style="padding:2px 0;">
    <div class="form-group">
        <label class="col-sm-2 control-label">
            Package Price:
        </label>
        <div class="col-sm-10">
            <input type="text" value="Rp. <%:Model.PackagePrice %>"class="form-control" disabled="disabled" />
        </div>
    </div>
</div>
<div class="row" style="padding:2px 0;">
    <div class="form-group">
        <label class="col-sm-2 control-label">
            Gift Card Price:
        </label>
        <div class="col-sm-10">
            <input type="text" value="Rp. <%:Model.GreetingCardPrice %>"class="form-control" disabled="disabled" />
        </div>
    </div>
</div>
<div class="row" style="padding:2px 0;">
    <div class="form-group">
        <label class="col-sm-2 control-label">
            Shipping Fee:
        </label>
        <div class="col-sm-10">
            <input type="text" value="Rp. <%:Model.ShippingFee %>"class="form-control" disabled="disabled" />
        </div>
    </div>
</div>
<div class="row" style="padding:2px 0;">
    <div class="form-group">
        <label class="col-sm-2 control-label">
            Service Fee:
        </label>
        <div class="col-sm-10">
            <input type="text" value="Rp. <%:Model.ServiceFee %>"class="form-control" disabled="disabled" />
        </div>
    </div>
</div>
<div class="row" style="padding:2px 0;">
    <div class="form-group">
        <label class="col-sm-2 control-label">
            Total:
        </label>
        <div class="col-sm-10">
            <%var jumlah = Model.GetTotalPrice(); %>
            <input type="text" value="Rp. <%:jumlah %>" class="form-control" disabled="disabled" />
        </div>
    </div>
</div>
