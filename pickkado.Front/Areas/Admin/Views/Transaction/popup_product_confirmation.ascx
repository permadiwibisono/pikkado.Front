<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<pickkado.Front.Areas.Admin.Models.ProductConfirmationViewModel>" %>

<div class="modal-content">
        
<% using (Html.BeginForm("popup_product_confirmation", "transaction", new { id = ViewContext.RouteData.Values["id"] }, FormMethod.Post, new { @class = "form-horizontal", @enctype = "multipart/form-data", id = "newAttributeForm" }))
   { %>
<%: Html.AntiForgeryToken()%>
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Product Purchase</h4>
    </div>
    <div class="modal-body">
        <div class="container-fluid">
                <%:Html.HiddenFor(m => m.TransactionId) %>
                <%var trans = ViewBag.Transaction; %>
            <div class="row">
                <label class="col-sm-4 control-label">Id</label>
                <div class="col-sm-8">
                    <input type="text" disabled value="<%:trans.Id %>" class="form-control"/> 
                </div>
            </div>
            <div class="row">
                <label class="col-sm-4 control-label">Username</label>
                <div class="col-sm-8">
                    <input type="text" disabled value="<%:trans.Email %>" class="form-control"/> 
                    
                </div>
            </div>
            <div class="row">
                <label class="col-sm-4 control-label">Product Name</label>
                <div class="col-sm-8">
                    <input type="text" disabled value="<%:trans.ProductName %>" class="form-control"/> 
                </div>
            </div>
            <div class="row">
                <label class="col-sm-4 control-label">Total</label>
                <div class="col-sm-8">
                    <input type="text" disabled value="<%:trans.Total %>" class="form-control"/>
                </div>
            </div>
            <div class="row">        
                <%:Html.LabelFor(m => m.Price, new { @class = "col-sm-4 control-label" })%>
                <div class="col-sm-8">
                    <%:Html.TextBoxFor(m => m.Price, new { @class = "col-sm-4 form-control", placeholder = "Masukkan harga barang jika berbeda" })%>
                </div>
            </div> 
            <div class="row">        
                <%:Html.LabelFor(m => m.OngkosKirim, new { @class = "col-sm-4 control-label" })%>
                <div class="col-sm-8">
                    <%:Html.TextBoxFor(m => m.OngkosKirim, new { @class = "col-sm-4 form-control", placeholder = "Masukkan ongkos kirim jika perlu" })%>
                </div>
            </div> 
            <div class="row">        
                <%:Html.LabelFor(m => m.ResiNumber, new { @class = "col-sm-4 control-label" })%>
                <div class="col-sm-8">
                    <%:Html.TextBoxFor(m => m.ResiNumber, new { @class = "col-sm-4 form-control", placeholder = "Masukkan nomor resi jika perlu" })%>
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
                    $("#MediumModal .modal-dialog").html(data.HTMLString);
                } else {
                    var message = '<div class="alert alert-success fadeIn animated">' +
                    '<a href="#" class="close" data-dismiss="alert">×</a>' +
                    '<strong>Success</strong> <span class="body">' + data.Message + '</span>' +
                    '</div>';
                    $('#message').html(message);
                    console.log(data);
                    $("#MediumModal").modal('hide');
                    var tr = $('#waitinglist').find('.btn-confirm[name="' + data.Obj.Id + '"]').parents('tr:first');
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