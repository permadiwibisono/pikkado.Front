<%@ Page Title="" Language="C#" MasterPageFile="~/Areas/Vendor/Views/Shared/Vendor.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">    
    <div id="message"></div>
    <div class="page-title">
        <span class="title">Your Orders</span>
        <div class="description">All of your order.</div>
    </div>
    <div class="row">
        <div class="col-xs-12">
            <div class="card">
                <div class="card-body no-padding">
                    <div class="modal fade" tabindex="-1" id="LargeModal" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                        <div class="modal-dialog modal-lg">
                                                    
                        </div>
                    </div>
                    <div class="modal fade" tabindex="-1" id="MediumModal" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                        <div class="modal-dialog modal-md">
                                                    
                        </div>
                    </div>
                    <div role="tabpanel">
                        <!-- Nav tabs -->
                        <ul class="nav nav-tabs" role="tablist">
                            <li role="presentation" class="active"><a href="#orderlist" aria-controls="list" role="tab" data-toggle="tab">Order List</a></li>
                            <li role="presentation" ><a href="#readylist" aria-controls="list" role="tab" data-toggle="tab">Ready to Delivery</a></li>
                            <li role="presentation" ><a href="#confirmedlist" aria-controls="list" role="tab" data-toggle="tab">Confirmed Order List</a></li>
                            <%--<li role="presentation" ><a href="#rejectedlist" aria-controls="list" role="tab" data-toggle="tab">Rejected Order List</a></li>--%>
                        </ul>
                        <!-- Tab panes -->
                        <div class="tab-content">
                            <div role="tabpanel" class="tab-pane active" id="orderlist">                        
                                <div class="card">
                                    <div class="card-header">
                                        <div class="card-title">
                                        <div class="title">Order List</div>
                                        <div class="description">You must to confirm this order, accept or reject it</div>
                                        </div>
                                    </div>
                                    <div class="card-body">
                                        <%Html.RenderAction("tab_order"); %>
                                    </div>
                                </div>
                            </div>
                            <div role="tabpanel" class="tab-pane" id="readylist">                        
                                <div class="card">
                                    <div class="card-header">
                                        <div class="card-title">
                                        <div class="title">Ready to Delivery List</div>
                                        <div class="description">Confirm to delivery to pickkado
                                            <br />
                                            <span>Notes:</span>
                                            <p>Delivery to pickkado's address: Menara Top Food 6th Floor, Jalur Sutera Barat 3, Alam Sutera - Tangerang</p>
                                        </div>
                                        </div>
                                    </div>
                                    <div class="card-body">
                                        <%Html.RenderAction("tab_ready"); %>
                                    </div>
                                </div>
                            </div>
                            <div role="tabpanel" class="tab-pane " id="confirmedlist">                        
                                <div class="card">
                                    <div class="card-header">
                                        <div class="card-title">
                                        <div class="title">Confirmed List</div>
                                        <div class="description">
                                            List of your order that have been your confirmed.
                                        </div>
                                        </div>
                                    </div>
                                    <div class="card-body">
                                        <%Html.RenderAction("tab_confirmed"); %>
                                    </div>
                                </div>
                            </div>
                            <%--<div role="tabpanel" class="tab-pane " id="rejectedlist">                        
                                <div class="card">
                                    <div class="card-header">
                                        <div class="card-title">
                                        <div class="title">Rejected List</div>
                                        <div class="description">
                                            List of your order that have been your reject.
                                        </div>
                                        </div>
                                    </div>
                                    <div class="card-body">
                                        <%Html.RenderAction("tab_rejected"); %>
                                    </div>
                                </div>
                            </div>--%>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="breadcumber" runat="server">
   <li >Dashboard</li>
   <li class="active">Order</li>
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="navBar" runat="server">
    <%Html.RenderAction("login_partial","account"); %>
</asp:Content>

<asp:Content ID="Content5" ContentPlaceHolderID="ScriptContent" runat="server">
    <script>
        function ShowMediumModal(content)
        {
            $('#MediumModal .modal-dialog').html(content);
            if(!$('#MediumModal').hasClass('in'))
                $('#MediumModal').modal();

        }
        function HideMediumModal()
        {
            $('#MediumModal').modal('hide');
        }
        function Accept(transId)
        {
            $.post('/vendor/order/acceptorder?transId=' + transId)
                .done(function (data) {
                    if (data) {
                        console.log(data);
                        if (data.IsError) {
                            var message = '<div class="alert alert-danger fadeIn animated">' +
                            '<a href="#" class="close" data-dismiss="alert">×</a>' +
                            '<strong>Error</strong> <span class="body">' + data.Message + '</span>' +
                            '</div>';
                            $('#message').html(message);
                            
                        }
                        else {
                            var message = '<div class="alert alert-success fadeIn animated">' +
                            '<a href="#" class="close" data-dismiss="alert">×</a>' +
                            '<strong>Success</strong> <span class="body">' + data.Message + '</span>' +
                            '</div>';
                            $('#message').html(message);
                            $('#orderlist table tr[data-bind="' + transId + '"').addClass('fadeOutRight');
                            setTimeout(function () {
                                $('#orderlist table tr[data-bind="' + transId + '"').remove();
                                getPartialView('/vendor/order/tab_order', '#orderlist .card-body');
                                getPartialView('/vendor/order/tab_ready', '#readylist .card-body');
                                getPartialView('/vendor/order/tab_confirmed', '#confirmedlist .card-body');
                            }, 1000);
                        }
                    }
                })
                .error(function (error) {
                    alert(error);
                });
            
        }
        function Reject(transId)
        {
            $.get('/vendor/popup/popup_reject_order/' + transId, function (data) {
                if (data) {
                    ShowMediumModal(data);
                }
            });
        }
        function getPartialView(link, view)
        {
            $.get(link, function (data) {
                if (data)
                    $(view).html(data);
            });
        }
        function ShowProductDetails(transId) {

            $.get('/vendor/popup/popup_product_details/' + transId)
                .done(function (data) {
                    if (data) {
                        ShowMediumModal(data);
                    }
                })
                .error(function (error) {
                    alert(error);
                });
        }
        function ConfirmDelivery(paymentId,transId) {

            $.get('/vendor/popup/popup_confirm_delivery?paymentId=' + paymentId+'&transId='+transId)
                .done(function (data) {
                    if (data) {
                        ShowMediumModal(data);
                    }
                })
                .error(function (error) {
                    alert(error);
                });
        }
        $('#MediumModal').on('hidden.bs.modal', function (e) {
            $("#MediumModal .modal-dialog").html('');
            // do something...
        });
        $('#LargeModal').on('hidden.bs.modal', function (e) {
            $("#LargeModal .modal-dialog").html('');
            // do something...
        });
    </script>
</asp:Content>
