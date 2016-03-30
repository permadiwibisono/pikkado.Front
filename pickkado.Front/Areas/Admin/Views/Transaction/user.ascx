<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<pickkado.Entities.Transaction>" %>
<div class="row" style="padding:2px 0;">
    <div class="form-group">
        <label class="col-sm-2 control-label">
                Buyer Info:
            </label>
            <div class="col-sm-10">
                
            </div>
        </div>
    </div>
<div class="row" style="padding:2px 0;">
    <div class="form-group">
        <label class="col-sm-2 control-label">
                Name:
            </label>
            <div class="col-sm-10">
            <input type="text" value="<%:Model.User.FirstName+ ' '+Model.User.LastName %>"class="form-control" disabled="disabled" />
            </div>
        </div>
    </div>
<div class="row" style="padding:2px 0;">
    <div class="form-group">
        <label class="col-sm-2 control-label">
                Email:
            </label>
            <div class="col-sm-10">
            <input type="text" value="<%:Model.UserName %>"class="form-control" disabled="disabled" />
            </div>
        </div>
    </div>
<div class="row" style="padding:2px 0;">
    <div class="form-group">
        <label class="col-sm-2 control-label">
                Active Phone Number:
            </label>
            <div class="col-sm-10">
            <input type="text" value="<%:Model.User.PhoneNumber %>"class="form-control" disabled="disabled" />
            </div>
        </div>
    </div>
<div class="row" style="padding:2px 0;">
    <div class="form-group">
        <label class="col-sm-2 control-label">
            To:
        </label>
        <div class="col-sm-10">
        </div>
    </div>
</div>
<div class="row" style="padding:2px 0;">
    <div class="form-group">
        <label class="col-sm-2 control-label">
            Receiver Name:
        </label>
        <div class="col-sm-10">
                <%:Html.TextBoxFor(m=>m.ReceiveName,new{@class="form-control", disabled="disabled"}) %>
        </div>
    </div>
</div>
<div class="row" style="padding:2px 0;">
    <div class="form-group">
        <label class="col-sm-2 control-label">
            Address:
        </label>
        <div class="col-sm-10">
                <%:Html.TextAreaFor(m=>m.DestinationAddress,new{@class="form-control",rows=3, disabled="disabled"}) %>
        </div>
    </div>
</div>
<div class="row" style="padding:2px 0;">
    <div class="form-group">
        <label class="col-sm-2 control-label">
            Kabupaten/Kota:
        </label>
        <div class="col-sm-10">
                <%:Html.TextBoxFor(m=>m.City,new{@class="form-control", disabled="disabled"}) %>
        </div>
    </div>
</div>
<div class="row" style="padding:2px 0;">
    <div class="form-group">
        <label class="col-sm-2 control-label">
            Kecamatan:
        </label>
        <div class="col-sm-10">
                <%:Html.TextBoxFor(m=>m.Kecamatan,new{@class="form-control", disabled="disabled"}) %>
        </div>
    </div>
</div>
<div class="row" style="padding:2px 0;">
    <div class="form-group">
        <label class="col-sm-2 control-label">
            Kelurahan:
        </label>
        <div class="col-sm-10">
                <%:Html.TextBoxFor(m=>m.Kelurahan,new{@class="form-control", disabled="disabled"}) %>
        </div>
    </div>
</div>
<div class="row" style="padding:2px 0;">
    <div class="form-group">
        <label class="col-sm-2 control-label">
            Received Date:
        </label>
        <div class="col-sm-10">
            <input type="text" value="<%:Model.TanggalKirim.ToShortDateString() %>"class="form-control" disabled="disabled" />
                
        </div>
    </div>
</div>
<div class="row" style="padding:2px 0;">
    <div class="form-group">
        <label class="col-sm-2 control-label">
            No. Resi:
        </label>
        <div class="col-sm-10">
            <input type="text" value="<%:Model.ResiNumber %>"class="form-control" disabled="disabled" />
                
        </div>
    </div>
</div>