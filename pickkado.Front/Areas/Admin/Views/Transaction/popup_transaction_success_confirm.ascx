<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<pickkado.Front.Areas.Admin.Models.TransactionSuccessConfirmViewModel>" %>


<div class="modal-content">
        
<% using (Html.BeginForm("popup_transaction_success_confirm", "transaction", new { id = ViewContext.RouteData.Values["id"] }, FormMethod.Post, new { @class = "form-horizontal", @enctype = "multipart/form-data", id = "newAttributeForm" }))
   { %>
<%: Html.AntiForgeryToken()%>
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Confirm to success</h4>
    </div>
    <div class="modal-body">
        <%:Html.HiddenFor(m=>m.TransactionId) %>
        <h5>Are you sure <%:ViewBag.TransactionId %> confirm to success?</h5>                                                           
    </div>
    <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
        <button type="button" id="Save" class="btn btn-primary">Ok</button>
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
                    var tr = $('#deliverprocesslist').find('.btn-confirm-success[name="' + data.Obj.Id + '"]').parents('tr:first');
                    console.log(tr);
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