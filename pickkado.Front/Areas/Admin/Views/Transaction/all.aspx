<%@ Page Title="" Language="C#" MasterPageFile="~/Areas/Admin/Views/Shared/Admin.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content5" ContentPlaceHolderID="navBar" runat="server">
    <%Html.RenderAction("login_partial","account"); %>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    
    <div class="page-title">
        <span class="title">All Transaction</span>
        <div class="description">List of your transaction, please check it</div>
    </div>
    <div class="row">
        <div class="col-xs-12">
            <div class="card">
                <div class="card-body no-padding">
                    <div role="tabpanel">
                        <!-- Nav tabs -->
                        <ul class="nav nav-tabs" role="tablist">
                            <li role="presentation" class="active"><a href="#list" aria-controls="list" role="tab" data-toggle="tab">List</a></li>
                        </ul>
                        <%var PageCount = ViewBag.PageCount; %>
                        <%var NextPage = ViewBag.NextPage; %>
                        <%var PrevPage = ViewBag.PrevPage; %>
                        <!-- Tab panes -->
                        <div class="tab-content">
                            <div role="tabpanel" class="tab-pane active" id="list">                        
                                <div class="card">
                                    <div class="card-header">
                                        <div class="card-title">
                                        <div class="title">List</div>
                                        </div>
                                    </div>
                                    <div class="card-body">
                                        <div class="modal fade" tabindex="-1" id="transactionDetailModal" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                                            <div class="modal-dialog modal-lg">
                                                    
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-xs-1">
                                                <label class="control-label">Status</label>
                                            </div>
                                            <div class="col-xs-3">
                                                <select class="form-control">
                                                    <option>INVITATION GROUP</option>
                                                    <option>UNCONFIRM PAYMENT</option>
                                                    <option>PAYMENT CHECKING</option>
                                                    <option>UNDER PAYMENT</option>
                                                    <option>INVENTORY CHECKING</option>
                                                    <option>ON PROCESS</option>
                                                    <option>ON DELIVERING</option>
                                                    <option>CANCEL</option>
                                                    <option>REFUND</option>
                                                    <option>SUCCESS</option>
                                                    <option selected>All</option>
                                                </select>
                                            </div>
                                            <div class="col-xs-3">
                                                <a class="btn btn-default" style="margin-top:0px;">Search</a>
                                            </div>
                                        </div>
                                        <table class="datatable table table-striped fadeInUp animated" cellspacing="0" width="100%">
                                            <thead>
                                                <tr>
                                                    <th>TransactionId</th>
                                                    <th>Date</th>
                                                    <th>Email</th>
                                                    <th>Deadline</th>
                                                    <th>Is Group</th>
                                                    <th>Total Transfered</th>
                                                    <th>Total</th>
                                                    <th>Status</th>
                                                    <th></th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                    <%foreach (var item in ViewBag.List)
                                                      {%>
                                                      <tr>
                                                          <td><%:item.Id %></td>
                                                          <td><%:item.Date %></td>
                                                          <td><%:item.Email %></td>
                                                          <td><%:item.Deadline.ToShortDateString() %></td>
                                                          <td><input type="checkbox" disabled <%:item.IsGroup?"checked":"" %> /></td>
                                                          <td>Rp. <%:item.TotalTransfered %></td>
                                                          <td>Rp. <%:item.Total %></td>
                                                          <td><%:item.Status %></td>
                                                        <td>
                                                            <button class="btn btn-primary btn-details" id="<%:item.Id %>">Details</button>
                                                        </td>
                                                      </tr>
                                                      <%} %>                   
                                            </tbody>
                                        </table>
                                        <div class="col-xs-12">
                                            <ul class = "pager">
                                               <li class = "previous  <%:PrevPage <= 0 ? "disabled" : "" %>"   ><a  href = "<%:PrevPage <= 0 ?"#":Url.Action("all",new{page=PrevPage}) %>">&larr; Older</a></li>
                                               <li class = "next <%: PageCount<NextPage ? "disabled" : "" %>"><a href = "<%:PageCount<NextPage ?"#":Url.Action("all",new{page=NextPage}) %>">Newer &rarr;</a></li>
                                            </ul>
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
   <li class="active">All Transaction</li>
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ScriptContent" runat="server">
    <script>
        $('.btn-details').click(function () {
            $.get('/admin/transaction/popup_detail_transaction/'+$(this).attr('id'),
            function (data) {
                $("#transactionDetailModal .modal-dialog").html(data);
                $('#transactionDetailModal').modal({ show: true });
            });
        });
        $('#transactionDetailModal').on('hidden.bs.modal', function (e) {
            $("#transactionDetailModal .modal-dialog").html('');
            // do something...
        });
    </script>
</asp:Content>
