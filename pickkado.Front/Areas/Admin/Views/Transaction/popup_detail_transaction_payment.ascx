<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<pickkado.Entities.TransactionPayment>" %>


<div class="modal-content">
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Transaction Payment Detail</h4>
    </div>
    <div class="modal-body"> 
        <div class="container-fluid form-horizontal">
        <div class="row" style="padding:2px 0;">
            <div class="form-group">
                <label class="col-sm-4 control-label">
                    Ditransfer oleh:
                </label>
                <div class="col-sm-8">
                        <%:Html.TextBoxFor(m=>m.user.FirstName,new{@class="form-control", disabled="disabled"}) %>
                </div>
            </div>
        </div>    
        <div class="row" style="padding:2px 0;">
            <div class="form-group">
                <label class="col-sm-4 control-label">
                    Tanggal Pembayaran:
                </label>
                <div class="col-sm-8">
                        <%:Html.TextBoxFor(m=>m.TanggalPembayaran,new{@class="form-control", disabled="disabled"}) %>
                </div>
            </div>
        </div>
        <div class="row" style="padding:2px 0;">
            <div class="form-group">
                <label class="col-sm-4 control-label">
                    No. Rekening:
                </label>
                <div class="col-sm-8">
                        <%:Html.TextBoxFor(m=>m.NoRekening,new{@class="form-control", disabled="disabled"}) %>
                </div>
            </div>
        </div>
        <div class="row" style="padding:2px 0;">
            <div class="form-group">
                <label class="col-sm-4 control-label">
                    Nama Rekening:
                </label>
                <div class="col-sm-8">
                        <%:Html.TextBoxFor(m=>m.NamaRekening,new{@class="form-control", disabled="disabled"}) %>
                </div>
            </div>
        </div>
        <div class="row" style="padding:2px 0;">
            <div class="form-group">
                <label class="col-sm-4 control-label">
                    Nama Bank:
                </label>
                <div class="col-sm-8">
                        <%:Html.TextBoxFor(m=>m.NamaBank,new{@class="form-control", disabled="disabled"}) %>
                </div>
            </div>
        </div>
        <div class="row" style="padding:2px 0;">
            <div class="form-group">
                <label class="col-sm-4 control-label">
                    Cabang Bank:
                </label>
                <div class="col-sm-8">
                        <%:Html.TextBoxFor(m=>m.CabangBank,new{@class="form-control", disabled="disabled"}) %>
                </div>
            </div>
        </div>
        <div class="row" style="padding:2px 0;">
            <div class="form-group">
                <label class="col-sm-4 control-label">
                    No. Rekening Tujuan:
                </label>
                <div class="col-sm-8">
                        <%:Html.TextBoxFor(m=>m.NoRekeningTujuan,new{@class="form-control", disabled="disabled"}) %>
                </div>
            </div>
        </div>
        <div class="row" style="padding:2px 0;">
            <div class="form-group">
                <label class="col-sm-4 control-label">
                    Nama Rekening Tujuan:
                </label>
                <div class="col-sm-8">
                        <%:Html.TextBoxFor(m=>m.NamaRekeningTujuan,new{@class="form-control", disabled="disabled"}) %>
                </div>
            </div>
        </div>
        <div class="row" style="padding:2px 0;">
            <div class="form-group">
                <label class="col-sm-4 control-label">
                    Nama Bank Tujuan:
                </label>
                <div class="col-sm-8">
                        <%:Html.TextBoxFor(m=>m.NamaBankTujuan,new{@class="form-control", disabled="disabled"}) %>
                </div>
            </div>
        </div>
        <div class="row" style="padding:2px 0;">
            <div class="form-group">
                <label class="col-sm-4 control-label">
                    Cabang Bank Tujuan:
                </label>
                <div class="col-sm-8">
                        <%:Html.TextBoxFor(m=>m.CabangBankTujuan,new{@class="form-control", disabled="disabled"}) %>
                </div>
            </div>
        </div>
        <div class="row" style="padding:2px 0;">
            <div class="form-group">
                <label class="col-sm-4 control-label">
                    Total Transfer:
                </label>
                <div class="col-sm-8">
                        <%:Html.TextBoxFor(m=>m.TotalDiBayar,new{@class="form-control", disabled="disabled"}) %>
                </div>
            </div>
        </div>
        <div class="row" style="padding:2px 0;">
            <div class="form-group">
                <label class="col-sm-4 control-label">
                    Remarks:
                </label>
                <div class="col-sm-8">
                        <%:Html.TextAreaFor(m=>m.Remarks,new{row="3",@class="form-control", disabled="disabled"}) %>
                </div>
            </div>
        </div>
        <div class="row" style="padding:2px 0;">
            <div class="form-group">
                <label class="col-sm-4 control-label">
                    Total Transfer:
                </label>
                <div class="col-sm-8">
                        <%:Html.TextBoxFor(m=>m.TotalDiBayar,new{@class="form-control", disabled="disabled"}) %>
                </div>
            </div>
        </div>
        <div class="row" style="padding:2px 0;">
            <div class="form-group">
                <label class="col-sm-4 control-label">
                    No. Struk Pembayaran:
                </label>
                <div class="col-sm-8">
                        <%:Html.TextBoxFor(m=>m.NoStrukPembayaran,new{@class="form-control", disabled="disabled"}) %>
                </div>
            </div>
        </div>
        <div class="row" style="padding:2px 0;">
            <div class="form-group">
                <label class="col-sm-4 control-label">
                    Status:
                </label>
                <div class="col-sm-8">
                        <%:Html.TextBoxFor(m=>m.StatusPembayaran,new{@class="form-control", disabled="disabled"}) %>
                </div>
            </div>
        </div>
        <div class="row" style="padding:2px 0;">
            <div class="form-group">
                <label class="col-sm-4 control-label">
                    Preview Struk:
                </label>
                    <div class="col-sm-8">
                        <%if(Model.BuktiPembayaran!=null){ %>
                        <img src="data:image;base64,<%: System.Convert.ToBase64String(Model.BuktiPembayaran)%>" class="img-thumbnail" height="200" width="200" />
                        <%}else{ %>
                        <img src="../../../../Images/no-thumb.png" class="img-thumbnail" height="200" width="200" />
                        <%} %>
                    </div>
                </div>
            </div>

        </div>    
    </div>
    <div class="modal-footer">
    </div>
</div>