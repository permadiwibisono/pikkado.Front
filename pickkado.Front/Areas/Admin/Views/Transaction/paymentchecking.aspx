<%@ Page Title="" Language="C#" MasterPageFile="~/Areas/Admin/Views/Shared/Admin.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content5" ContentPlaceHolderID="navBar" runat="server">
    <%Html.RenderAction("login_partial","account"); %>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">    
    <div id="message">

    </div>
    <div class="page-title">
        <span class="title">Payment Checking</span>
        <div class="description">List of your transaction, please check it</div>
    </div>
    <div class="row">
        <div class="col-xs-12">
            <div class="card">
                <div class="card-body no-padding">
                    <div class="modal fade" tabindex="-1" id="transactionPaymentDetailModal" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                        <div class="modal-dialog modal-md">
                                                    
                        </div>
                    </div>
                    <div role="tabpanel">
                        <!-- Nav tabs -->
                        <ul class="nav nav-tabs" role="tablist">
                            <li role="presentation" class="active"><a href="#paymentlist" aria-controls="list" role="tab" data-toggle="tab">Payment List</a></li>
                            <li role="presentation" ><a href="#underpaymentlist" aria-controls="list" role="tab" data-toggle="tab">Under Payment List</a></li>
                            <li role="presentation" ><a href="#validpaymentlist" aria-controls="list" role="tab" data-toggle="tab">Valid Payment List</a></li>
                            <li role="presentation" ><a href="#notvalidpaymentlist" aria-controls="list" role="tab" data-toggle="tab">Not Valid Payment List</a></li>
                        </ul>
                        <!-- Tab panes -->
                        <div class="tab-content">
                            <div role="tabpanel" class="tab-pane active" id="paymentlist">
                                <div class="card">
                                    <div class="card-header">
                                        <div class="card-title">
                                        <div class="title">Payment List</div>
                                        <div class="description">Show all transaction that have been purchase by your customer you must check it</div>
                                        </div>
                                    </div>
                                    <div class="card-body">
                                        <div class="row">
                                            <div class="col-xs-1">
                                                <label class="control-label">Bank</label>
                                            </div>
                                            <div class="col-xs-2">
                                                <select class="form-control" onchange="filter('#paymentlist .contentplaceholder','<%:Url.Action("tab_paymentlist") %>',this.value);">
                                                    <option>BCA</option>
                                                    <option>BRI</option>
                                                    <option>Mandiri</option>
                                                    <option selected>All</option>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="contentplaceholder">

                                            <%Html.RenderAction("tab_paymentlist"); %>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div role="tabpanel" class="tab-pane" id="underpaymentlist">
                                <div class="card">
                                    <div class="card-header">
                                        <div class="card-title">
                                        <div class="title">Under Payment List</div>
                                        <div class="description">Show all transaction that under payment</div>
                                        </div>
                                    </div>
                                    <div class="card-body">
                                        <div class="row">
                                            <div class="col-xs-1">
                                                <label class="control-label">Bank</label>
                                            </div>
                                            <div class="col-xs-2">
                                                <select class="form-control"  onchange="filter('#underpaymentlist .contentplaceholder','<%:Url.Action("tab_underpaymentlist") %>',this.value);">
                                                    <option>BCA</option>
                                                    <option>BRI</option>
                                                    <option>Mandiri</option>
                                                    <option selected>All</option>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="contentplaceholder">
                                        <%Html.RenderAction("tab_underpaymentlist"); %>

                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div role="tabpanel" class="tab-pane" id="validpaymentlist"> 
                                <div class="card">
                                    <div class="card-header">
                                        <div class="card-title">
                                        <div class="title">Valid Payment List</div>
                                        <div class="description">Show all transaction that valid payment</div>
                                        </div>
                                    </div>
                                    <div class="card-body">
                                        <div class="row">
                                            <div class="col-xs-1">
                                                <label class="control-label">Bank</label>
                                            </div>
                                            <div class="col-xs-2">
                                                <select class="form-control" onchange="filter('#validpaymentlist .contentplaceholder','<%:Url.Action("tab_validpaymentlist") %>',this.value);">
                                                    <option>BCA</option>
                                                    <option>BRI</option>
                                                    <option>Mandiri</option>
                                                    <option selected>All</option>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="contentplaceholder">
                                            <%Html.RenderAction("tab_validpaymentlist"); %>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div role="tabpanel" class="tab-pane" id="notvalidpaymentlist">
                                <div class="card">
                                    <div class="card-header">
                                        <div class="card-title">
                                        <div class="title">Not Valid Payment List</div>
                                        <div class="description">Show all transaction that not valid payment</div>
                                        </div>
                                    </div>
                                    <div class="card-body">
                                        <div class="row">
                                            <div class="col-xs-1">
                                                <label class="control-label">Bank</label>
                                            </div>
                                            <div class="col-xs-2">
                                                <select class="form-control" onchange="filter('#notvalidpaymentlist .contentplaceholder','<%:Url.Action("tab_notvalidpaymentlist") %>',this.value);">
                                                    <option>BCA</option>
                                                    <option>BRI</option>
                                                    <option>Mandiri</option>
                                                    <option selected>All</option>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="contentplaceholder">
                                            <%Html.RenderAction("tab_notvalidpaymentlist"); %>

                                        </div>
                                    </div>
                                </div>
                            </div>
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
   <li class="active">Payment Checking</li>
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ScriptContent" runat="server">
    <script>
        function filter(placeholder, link, val) {
            //alert('a');
            $.get(link + '?bank=' + val)
                .done(function (data) {
                    $(placeholder).html(data);
                });
        }
        function goToPage(placeholder, link, filterBank, page) {
            //alert('a');
            $.get(link + '?page=' + page + '&bank=' + $(filterBank).val())
                .done(function (data) {
                    $(placeholder).html(data);
                });
        }
        $(document).on('click', '.btn-details', function () {
            $.get('/admin/transaction/popup_detail_transaction_payment/' + $(this).attr('name'),
            function (data) {
                $("#transactionPaymentDetailModal .modal-dialog").html(data);
                $('#transactionPaymentDetailModal').modal({ show: true });
            });

        });
        $(document).on('click', '.btn-confirm', function () {
            $.get('/admin/transaction/popup_payment_confirmation/' + $(this).attr('name'),
            function (data) {
                $("#transactionPaymentDetailModal .modal-dialog").html(data);
                $('#transactionPaymentDetailModal').modal({ show: true });
            });

        });
        $('#transactionPaymentDetailModal').on('hidden.bs.modal', function (e) {
            $("#transactionPaymentDetailModal .modal-dialog").html('');
            // do something...
        });
    </script>
</asp:Content>
