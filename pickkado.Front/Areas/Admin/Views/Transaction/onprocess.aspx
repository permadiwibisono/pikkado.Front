<%@ Page Title="" Language="C#" MasterPageFile="~/Areas/Admin/Views/Shared/Admin.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content5" ContentPlaceHolderID="navBar" runat="server">
    <%Html.RenderAction("login_partial","account"); %>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div id="message"></div>
    <div class="page-title">
        <span class="title">On-Process Transaction</span>
        <div class="description"></div>
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
                            <li role="presentation" class="active"><a href="#list" aria-controls="list" role="tab" data-toggle="tab">List</a></li>
                            <li role="presentation" ><a href="#deliverprocesslist" aria-controls="list" role="tab" data-toggle="tab">Delivering Process</a></li>
                        </ul>
                        <!-- Tab panes -->
                        <div class="tab-content">
                            <div role="tabpanel" class="tab-pane active" id="list">                        
                                <div class="card">
                                    <div class="card-header">
                                        <div class="card-title">
                                        <div class="title">List</div>
                                        <div class="description">After your order have been received, you must to press the button confirm to start delivering process</div>
                                        </div>
                                    </div>
                                    <div class="card-body">
                                        <table class="datatable table table-striped fadeInUp animated" cellspacing="0" width="100%">
                                            <thead>
                                                <tr>
                                                    <th>Id</th>
                                                    <th>Email</th>
                                                    <th>Deadline</th>
                                                    <th>Address</th>
                                                    <th>Total</th>
                                                    <th></th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                    <%foreach (var item in ViewBag.List)
                                                      {%>
                                                      <tr class="animated">
                                                          <td><%:item.Id %></td>
                                                          <td><%:item.Email %></td>
                                                          <td><%:item.Deadline.ToShortDateString() %></td>
                                                        <td><%:item.Address %></td>
                                                          <td>Rp. <%:item.Total %></td>
                                                        <td>
                                                            <div class="btn-group">
                                                                <button class="btn btn-success btn-confirm" name="<%:item.Id %>">Confirm</button>
                                                                <button class="btn btn-primary btn-details" name="<%:item.Id %>">Details</button>
                                                            </div>
                                                            
                                                        </td>
                                                      </tr>
                                                      <%} %>                      
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                            <div role="tabpanel" class="tab-pane" id="deliverprocesslist">                        
                                <div class="card">
                                    <div class="card-header">
                                        <div class="card-title">
                                        <div class="title">Delivering Process</div>
                                        <div class="description">Show all transaction are on the way </div>
                                        </div>
                                    </div>
                                    <div class="card-body">
                                        <table class="datatable table table-striped fadeInUp animated" cellspacing="0" width="100%">
                                            <thead>
                                                <tr>
                                                    <th>Id</th>
                                                    <th>Email</th>
                                                    <th>Deadline</th>
                                                    <th>Address</th>
                                                    <th>No. Resi</th>
                                                    <th></th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                    <%foreach (var item in ViewBag.DeliveringList)
                                                      {%>
                                                      <tr class="animated">
                                                          <td><%:item.Id %></td>
                                                          <td><%:item.Email %></td>
                                                          <td><%:item.Deadline.ToShortDateString() %></td>
                                                          <td><%:item.Address %></td>
                                                          <td><%:item.ResiNumber %></td>
                                                        <td>
                                                            <div class="btn-group">
                                                                <button class="btn btn-success btn-confirm-success" name="<%:item.Id %>">Confirm</button>
                                                                <button class="btn btn-primary btn-details" name="<%:item.Id %>">Details</button>
                                                            </div>
                                                            
                                                        </td>
                                                      </tr>
                                                      <%} %>                      
                                            </tbody>
                                        </table>
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
   <li class="active">On-Process Transaction</li>
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ScriptContent" runat="server">        
        <script>
            $(document).on('click', '.btn-details', function () {
                $.get('/admin/transaction/popup_detail_transaction/' + $(this).attr('name'),
                function (data) {
                    //$("#transactionDetailModal .modal-dialog").html(data);
                    $('#transactionDetailModal').modal({ show: true });
                });

            });
            $(document).on('click', '.btn-confirm', function () {
                $.get('/admin/transaction/popup_product_delivery/' + $(this).attr('name'),
                function (data) {
                    $("#MediumModal .modal-dialog").html(data);
                    $('#MediumModal').modal({ show: true });
                });

            });
            $(document).on('click', '.btn-confirm-success', function () {
                $.get('/admin/transaction/popup_transaction_success_confirm/' + $(this).attr('name'),
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
