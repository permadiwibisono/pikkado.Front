<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<pickkado.Front.Areas.Admin.Models.PaymentConfirmationViewModel>" %>
<div class="modal-content">
        
<% using (Html.BeginForm("popup_payment_confirmation", "transaction", new { id = ViewContext.RouteData.Values["id"] }, FormMethod.Post, new { @class = "form-horizontal", @enctype = "multipart/form-data", id = "newAttributeForm" }))
   { %>
<%: Html.AntiForgeryToken()%>
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Payment Confirmation</h4>
    </div>
    <div class="modal-body">
        <% if (ViewData.ModelState.Any(x => x.Value.Errors.Any()))
           {%>
                <div id="message" class="alert alert-danger">
                    <a href="#" class="close" data-dismiss="alert">×</a>
                    <%: Html.ValidationSummary("",new { @class = "validation-summary-custom" })%>
                </div>
            <% }%>
        <div class="container-fluid">
                <%:Html.HiddenFor(m => m.PaymentId) %>
                <%var payment = ViewBag.Payment; %>
            <div class="row">
                <label class="col-sm-4 control-label">Date</label>
                <div class="col-sm-8">
                    <input type="text" disabled value="<%:payment.TanggalPembayaran.ToShortDateString() %>" class="form-control"/> 
                </div>
            </div>
            <div class="row">
                <label class="col-sm-4 control-label">Username</label>
                <div class="col-sm-8">
                    <input type="text" disabled value="<%:payment.user.Email %>" class="form-control"/> 
                    
                </div>
            </div>
            <div class="row">
                <label class="col-sm-4 control-label">No. Rekening</label>
                <div class="col-sm-8">
                    <input type="text" disabled value="<%:payment.NoRekening %>" class="form-control"/> 
                </div>
            </div>
            <div class="row">
                <label class="col-sm-4 control-label">Nama Bank</label>
                <div class="col-sm-8">
                    <input type="text" disabled value="<%:payment.NamaBank %>" class="form-control"/>
                </div>
            </div>
            <div class="row">
                <label class="col-sm-4 control-label">No. Rekening Tujuan</label>
                <div class="col-sm-8">
                    <input type="text" disabled value="<%:payment.NoRekeningTujuan %>" class="form-control"/>
                </div>
            </div>
            <div class="row">
                <label class="col-sm-4 control-label">Transfer ke</label>
                <div class="col-sm-8">
                    <input type="text" disabled value="<%:payment.NamaBankTujuan %>" class="form-control" />
                </div>
            </div>
            <div class="row">
                <label class="col-sm-4 control-label">Total</label>
                <div class="col-sm-8">
                    <input type="text" disabled value="Rp. <%:payment.TotalDiBayar %>" class="form-control" />
                </div>
            </div>
            <div class="row" id="divKoreksiTotalBayar">        
                <%:Html.LabelFor(m => m.KoreksiTotalBayar, new { @class = "col-sm-4 control-label" })%>
                <div class="col-sm-8">
                    <%:Html.TextBoxFor(m => m.KoreksiTotalBayar, new { @class = "col-sm-4 form-control", placeholder = "Koreksi Total Bayar" })%>
                </div>
            </div> 
            <div class="row">        
                <%:Html.LabelFor(m => m.Remarks, new { @class = "col-sm-4 control-label" })%>
                <div class="col-sm-8">
                    <%:Html.TextBoxFor(m => m.Remarks, new { @class = "col-sm-4 form-control", placeholder = "Remarks" })%>
                </div>
            </div> 
            <div class="row">        
                <%:Html.LabelFor(m => m.Status, new { @class = "col-sm-4 control-label" })%>
                <%var list = new List<SelectListItem> { 
                  new SelectListItem{Text=pickkado.Front.TransactionPaymentStatus.NotValid,Value=pickkado.Front.TransactionPaymentStatus.NotValid},
                  new SelectListItem{Text=pickkado.Front.TransactionPaymentStatus.Valid,Value=pickkado.Front.TransactionPaymentStatus.Valid},
                  new SelectListItem{Text=pickkado.Front.TransactionPaymentStatus.UnderPayment,Value=pickkado.Front.TransactionPaymentStatus.UnderPayment}
                  };
                   %>
                <div class="col-sm-8">
                    <%:Html.DropDownListFor(m => m.Status,list, new { @class = "col-sm-4 form-control" })%>
                </div>
            </div>
        </div>                                                            
    </div>
    <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
        <button type="button" id="Save" class="btn btn-primary">Save</button>
    </div>
    <%}%>
</div>
<script>
    $(function () {
        alert($('#Status').val());
        if ($('#Status').val() == "UNDER PAYMENT")
        {
            $('#divKoreksiTotalBayar').show('fade');
        }
        else
            $('#divKoreksiTotalBayar').hide('fade');

        $('#Status').change(function () {
            if ($('#Status').val() == "UNDER PAYMENT") {
                $('#divKoreksiTotalBayar').show('fade');
            }
            else
                $('#divKoreksiTotalBayar').hide('fade');

        });
    });
    $('#Save').click(function () {
        //console.log($(this).parents('form'));
        var form = $(this).parents('form');
        var url = form.attr('action');
        console.log(url);
        //$('#newAttributeForm').ajaxForm(options);
        $.ajax({
            type: "POST",
            url: url,
            data: form.serialize(),
            dataType: "json",
            success: function (data) {
                console.log(data);
                if (data.IsError == true) {
                    alert(data.Message);
                    console.log(data);
                    $("#transactionPaymentDetailModal .modal-dialog").html(data.HTMLString);
                } else {
                    var message = '<div class="alert alert-success fadeIn animated">' +
                    '<a href="#" class="close" data-dismiss="alert">×</a>' +
                    '<strong>Success</strong> <span class="body">' + data.Message + '</span>' +
                    '</div>';
                    $('#message').html(message);
                    console.log(data);
                    $("#transactionPaymentDetailModal").modal('hide');
                    var row = '<tr class="fadeInLeft animated">'+
                                '<td>' + data.Obj.Date + '</td>' +
                                '<td>' + data.Obj.Username + '</td>' +
                                '<td>' + data.Obj.NoRekening + '</td>' +
                                '<td>' + data.Obj.NamaBank + '</td>' +
                                '<td>' + data.Obj.NoRekeningTujuan + '</td>' +
                                '<td>' + data.Obj.NamaBankTujuan + '</td>' +
                                '<td>Rp. ' + data.Obj.Total + '</td>' +
                                '<td>'+
                                    '<div class="btn-group">'+
                                    '<button class="btn btn-primary btn-details" name="'+data.Obj.Id+'">Details</button>'+
                                    '</div>'+
                                '</td>'+
                            '</tr>';
                    var tr = $('#paymentlist').find('.btn-confirm[name="' + data.Obj.Id + '"]').parents('tr:first');
                    if (data.Obj.Status == 'VALID')
                        $('#validpaymentlist').find('tbody').append(row);
                    else if (data.Obj.Status == 'NOT VALID')
                        $('#notvalidpaymentlist').find('tbody').append(row);
                    else if (data.Obj.Status == 'UNDER PAYMENT')
                        $('#underpaymentlist').find('tbody').append(row);
                    tr.addClass('fadeOutRight');
                    setTimeout(function () {
                        tr.remove();
                    }, 1000);
                }
            },
            error: function (err) {
                alert(err.statusText);
            }
        });

    });
</script>