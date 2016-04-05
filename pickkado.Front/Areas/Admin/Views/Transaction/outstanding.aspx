<%@ Page Title="" Language="C#" MasterPageFile="~/Areas/Admin/Views/Shared/Admin.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content5" ContentPlaceHolderID="navBar" runat="server">
    <%Html.RenderAction("login_partial","account"); %>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div id="message"></div>
    <div class="page-title">
        <span class="title">Outstanding Transaction</span>
        <div class="description">List of your outstanding transaction from your vendor, please check it</div>
    </div>
    <div class="row">
        <div class="col-xs-12">
            <div class="card">
                <div class="card-body no-padding">
                    <div class="modal fade" tabindex="-1" id="transactionDetailModal" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
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
                            <li role="presentation" class="active"><a href="#waitinglist" aria-controls="list" role="tab" data-toggle="tab">Waiting</a></li>
                        </ul>
                        <!-- Tab panes -->
                        <div class="tab-content">
                            <div role="tabpanel" class="tab-pane active" id="waitinglist">                        
                                <div class="card">
                                    <div class="card-header">
                                        <div class="card-title">
                                        <div class="title">Waiting List</div>
                                        <div class="description">Show all transaction with status inventory checking, if you have found the product press button confirm to continue next step</div>
                                        </div>
                                    </div>
                                    <div class="card-body">
                                        <%Html.RenderAction("tab_waitingprocess"); %>
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
   <li class="active">Outstanding Transaction</li>
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ScriptContent" runat="server">
    <script>
        $(document).on('click', '.btn-details', function () {
            $.get('/admin/transaction/popup_detail_transaction/' + $(this).attr('name'),
            function (data) {
                $("#transactionDetailModal .modal-dialog").html(data);
                $('#transactionDetailModal').modal({ show: true });
            });

        });
        $(document).on('click', '.btn-confirm', function () {
            $.get('/admin/transaction/popup_product_confirmation/' + $(this).attr('name'),
            function (data) {
                $("#MediumModal .modal-dialog").html(data);
                $('#MediumModal').modal({ show: true });
            });

        });
        $('#transactionDetailModal').on('hidden.bs.modal', function (e) {
            $("#transactionDetailModal .modal-dialog").html('');
            // do something...
        });
        $('#MediumModal').on('hidden.bs.modal', function (e) {
            $("#MediumModal .modal-dialog").html('');
            // do something...
        });
    </script>
</asp:Content>
