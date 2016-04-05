<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<pickkado.Front.Areas.Vendor.Models.PopupRejectOrderViewModel>" %>

<div class="modal-content">
    <% using (Html.BeginForm("popup_reject_order", "popup", FormMethod.Post, new { @class = "form-horizontal", id = "rejectForm" }))
   { %>
<%: Html.AntiForgeryToken()%>
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Are you sure to reject this order?</h4>
    </div>
    <div class="modal-body">
        <div class="card">
            <%--<div class="card-header">
                <div class="card-title">
                <div class="title">Product info</div>
                </div>
            </div>--%>
            <div class="card-body">
                <div class="container-fluid form-horizontal">
                    <% if (ViewData.ModelState.Any(x => x.Value.Errors.Any()))
                    {%>
                    <div class="alert alert-danger row fadeIn animated">
                        <a href="#" class="close" data-dismiss="alert">×</a>
                        <%: Html.ValidationSummary("", new { @class = "validation-summary-custom" })%>
                    </div>
                    <% }%>
                    <%var product = (pickkado.Front.Areas.Vendor.Models.PopupProductDetailsViewModel)ViewBag.ProductDetails; %>
                    <div class="row" style="padding:2px 0;">
                        <div class="form-group">
                            <label class="col-sm-3 control-label">
                                Product Name:
                            </label>
                            <div class="col-sm-9">
                                <input type="text" class="form-control" value="<%:product.ProductName %>"  disabled />
                            </div>
                        </div>
                    </div>
                    <div class="row" style="padding:2px 0;">
                        <div class="form-group">
                            <label class="col-sm-3 control-label">
                                Weight(gr):
                            </label>
                            <div class="col-sm-9">
                                <input type="text" class="form-control" value="<%:product.ProductWeight %>"  disabled />
                            </div>
                        </div>
                    </div>
                    <div class="row" style="padding:2px 0;">
                        <div class="form-group">
                            <label class="col-sm-3 control-label">
                                Product Description:
                            </label>
                            <div class="col-sm-9">
                                <textarea class="form-control" rows="3" disabled><%:product.ProductDescription %></textarea>
                            </div>
                        </div>
                    </div>
                    <div class="row" style="padding:2px 0;">
                        <div class="form-group">
                            <label class="col-sm-3 control-label">
                                Preview:
                            </label>
                                <div class="col-sm-4">
                                    <%if(product.Image!=null){ %>
                                    <img src="data:image;base64,<%: System.Convert.ToBase64String(product.Image)%>" class="img-thumbnail" height="200" width="200" />
                                    <%}else{ %>
                                    <img src="../../../../Images/no-thumb.png" class="img-thumbnail" height="200" width="200" />
                                    <%} %>
                                </div>
                                <div class="col-sm-5">
                                    <table class="datatable table table-striped" style="text-align:center" cellspacing="0" width="100%">
                                    <thead>
                                        <tr>
                                            <th style="text-align:center" colspan="2">Additional Info</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                            
                                        <%if(product.ProdutAttributeList.Count>0){ %>
                                        <%foreach (var i in product.ProdutAttributeList)
                                            {%>
          
                                        <tr>
                                        <td><%:i.Name %></td>
                                        <td><%:i.Value %></td>
                                        <%} %>
                                        </tr>
                                            <%}
                                        else{%>
                                        <tr>
                                            <td colspan="2">
                                                <div class="alert alert-danger">No Record Found</div>

                                            </td>
                                        </tr>
                                        <%} %>
                                    </tbody>
                                </table>
                                </div>
                            </div>
                        </div>
                    <div class="row" style="padding:2px 0;">
                        <div class="form-group">
                            <label class="col-sm-3 control-label">
                                Product Price:
                            </label>
                            <div class="col-sm-9">
                                <input type="text" class="form-control" value="<%:product.PriceToRupiah %>"  disabled />
                            </div>
                        </div>
                    </div>
                    <div class="row" style="padding:2px 0;">
                        <div class="form-group">
                            <label class="col-sm-3 control-label">
                                Discount:
                            </label>
                            <div class="col-sm-9">
                                <input type="text" class="form-control" value="<%:product.DiscountProductToRupiah %>"  disabled />
                            </div>
                        </div>
                    </div>
                    <div class="row" style="padding:2px 0;">
                        <div class="form-group">
                            <label class="col-sm-3 control-label">
                                Total:
                            </label>
                            <div class="col-sm-9">
                                <input type="text" class="form-control" value="<%:product.TotalToRupiah %>"  disabled />
                            </div>
                        </div>
                    </div>
                    <div class="row" style="padding:2px 0;">
                        <div class="form-group">
                            <label class="col-sm-3 control-label">
                                Remarks:
                            </label>
                            <div class="col-sm-9">
                                <%:Html.HiddenFor(m=>m.Id) %>
                                <%:Html.TextAreaFor(m=>m.Remarks,new{@class="form-control",rows=3}) %>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>                                                 
    </div>
    <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
        <button type="button" id="Save" class="btn btn-primary">Save</button>
    </div>
    <%} %>
</div>
<script>
    $('#Save').click(function () {
        $.post($('#rejectForm').attr('action'), $('#rejectForm').serialize())
            .done(function (data) {
                if (data.IsError) {
                    if (data.HtmlString)
                    {
                        console.log(data.HtmlString);
                        $("#MediumModal .modal-dialog").html(data.HtmlString);
                    }
                    else
                    {
                        var message = '<div class="alert alert-danger fadeIn animated">' +
                        '<a href="#" class="close" data-dismiss="alert">×</a>' +
                        '<strong>Error</strong> <span class="body">' + data.Message + '</span>' +
                        '</div>';
                        $('#message').html(message);
                        HideMediumModal();
                    }
                }
                else {
                    var message = '<div class="alert alert-success fadeIn animated">' +
                    '<a href="#" class="close" data-dismiss="alert">×</a>' +
                    '<strong>Success</strong> <span class="body">' + data.Message + '</span>' +
                    '</div>';
                    $('#message').html(message);
                    $('#orderlist table tr[data-bind="' + $('#Id').val() + '"').addClass('fadeOutRight');
                    setTimeout(function () {
                        $('#orderlist table tr[data-bind="' + $('#Id').val() + '"').remove();
                        getPartialView('/vendor/order/tab_order', '#orderlist .card-body');
                        getPartialView('/vendor/order/tab_confirmed', '#confirmedlist .card-body');
                    }, 1000);
                    HideMediumModal();
                }
            });

    });
</script>