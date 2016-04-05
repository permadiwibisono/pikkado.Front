<%@ Page Title="" Language="C#" MasterPageFile="~/Areas/Admin/Views/Shared/Admin.Master" Inherits="System.Web.Mvc.ViewPage<pickkado.Front.Areas.Admin.Models.AllTransactionFilterViewModel>" %>

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
            <%var pagination = ViewBag.Pagination; %>
                <div class="card-body">
                    <div class="modal fade" tabindex="-1" id="transactionDetailModal" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                        <div class="modal-dialog modal-lg">
                                                    
                        </div>
                    </div>
                    <div style="padding:10px">
                        <%using (Html.BeginForm("all","transaction",FormMethod.Post,new{@class="form-inline"})){
                            %>
                            <div class="row">
                                <div class="form-group">
                                    <label class="control-label">Status</label>
                                    <%var list = new List<SelectListItem>()
                                        {
                                            new SelectListItem{
                                            Text="INVITATION GROUP",
                                            Value="INVITATION GROUP",
                                            Selected=Model.Status=="INVITATION GROUP"?true:false
                                            },
                                            new SelectListItem{
                                            Text="UNCONFIRM PAYMENT",
                                            Value="UNCONFIRM PAYMENT",
                                            Selected=Model.Status=="UNCONFIRM PAYMENT"?true:false
                                            },
                                            new SelectListItem{
                                            Text="PAYMENT CHECKING",
                                            Value="PAYMENT CHECKING",
                                            Selected=Model.Status=="PAYMENT CHECKING"?true:false
                                            },
                                            new SelectListItem{
                                            Text="UNDER PAYMENT",
                                            Value="UNDER PAYMENT",
                                            Selected=Model.Status=="UNDER PAYMENT"?true:false
                                            },
                                            new SelectListItem{
                                            Text="INVENTORY CHECKING",
                                            Value="INVENTORY CHECKING",
                                            Selected=Model.Status=="INVENTORY CHECKING"?true:false
                                            },
                                            new SelectListItem{
                                            Text="ON BUYING",
                                            Value="ON BUYING",
                                            Selected=Model.Status=="ON BUYING"?true:false
                                            },
                                            new SelectListItem{
                                            Text="ON DELIVERING",
                                            Value="ON DELIVERING",
                                            Selected=Model.Status=="ON DELIVERING"?true:false
                                            },
                                            new SelectListItem{
                                            Text="COMPLETED BY ADMIN",
                                            Value="COMPLETED BY ADMIN",
                                            Selected=Model.Status=="COMPLETED BY ADMIN"?true:false
                                            },
                                            new SelectListItem{
                                            Text="COMPLETED BY USER",
                                            Value="COMPLETED BY USER",
                                            Selected=Model.Status=="COMPLETED BY USER"?true:false
                                            },
                                            new SelectListItem{
                                            Text="REFUND",
                                            Value="REFUND",
                                            Selected=Model.Status=="REFUND"?true:false
                                            },
                                            new SelectListItem{
                                            Text="CANCEL",
                                            Value="CANCEL",
                                            Selected=Model.Status=="CANCEL"?true:false
                                            },
                                            new SelectListItem{
                                            Text="All",
                                            Value="All",
                                            Selected=Model.Status=="All"?true:false
                                            },
                                        }; %>
                                    <%:Html.DropDownListFor(m => m.Status, list, new {@class="form-control" })%>
                                </div>

                                <div class="form-group">
                                    <label class="control-label">Sort by</label>
                                    <%var list2 = new List<SelectListItem>{
                                    new SelectListItem{
                                        Text="Newest Transaction",
                                        Value="0",
                                        Selected=Model.SortBy=="0"?true:false
                                    },
                                    new SelectListItem{
                                        Text="Older Transaction",
                                        Value="1",
                                        Selected=Model.SortBy=="1"?true:false
                                    },
                                    new SelectListItem{
                                        Text="Lowest Price",
                                        Value="2",
                                        Selected=Model.SortBy=="2"?true:false
                                    },
                                    new SelectListItem{
                                        Text="Highest Price",
                                        Value="3",
                                        Selected=Model.SortBy=="3"?true:false
                                    },
                                    new SelectListItem{
                                        Text="Closest Deadline",
                                        Value="4",
                                        Selected=Model.SortBy=="4"?true:false
                                    },
                                    new SelectListItem{
                                        Text="Longest Deadline",
                                        Value="5",
                                        Selected=Model.SortBy=="5"?true:false
                                    },
                                    }; %>
                                <%:Html.DropDownListFor(m => m.SortBy, list2, new {@class="form-control" })%>
                                </div>
                                <div class="form-group">
                                    <button class="btn btn-primary" type="submit" >Search</button>
                                </div>
                                                
                            </div>
                                                
                            <%} %>
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
                                        <td style="vertical-align:middle"><%:item.Id %></td>
                                        <td style="vertical-align:middle"><%:item.Date %></td>
                                        <td style="vertical-align:middle"><%:item.Email %></td>
                                        <td style="vertical-align:middle"><%:item.Deadline.ToShortDateString() %></td>
                                        <td style="vertical-align:middle"><input type="checkbox" disabled <%:item.IsGroup?"checked":"" %> /></td>
                                        <td style="vertical-align:middle">Rp. <%:item.TotalTransfered %></td>
                                        <td style="vertical-align:middle">Rp. <%:item.Total %></td>
                                        <td style="vertical-align:middle"><%:item.Status %></td>
                                    <td style="vertical-align:middle">
                                        <button class="btn btn-primary" onclick="ShowTransactionDetail('<%:item.Id %>');">Details</button>
                                    </td>
                                    </tr>
                                    <%} %>                   
                        </tbody>
                    </table>
                    <div class="col-xs-12">
                        <div class="row">                                                
                            <span class="text-center col-xs-12 pager-show">
                                Show <span class="pager-show-from"><%:pagination.StartIndex()+1>pagination.DataCount?pagination.DataCount:pagination.StartIndex()+1 %></span>
                                    to <span class="pager-show-to"> <%:pagination.EndIndex()%></span>
                                    of <span class="pager-show-count"><%:pagination.DataCount %></span>
                                <span class="pager-show-msg"></span>
                            </span>
                        </div>
                        <ul class = "pager">
                            <li class = "previous  <%:pagination.PrevPage() <= 0 ? "disabled" : "" %>"   ><a  href = "<%:pagination.PrevPage()  <= 0 ?"#":pagination.PrevPageLink %>">&larr; Older</a></li>
                            <li class = "next <%: pagination.PageCount()<pagination.NextPage() ? "disabled" : "" %>"><a href = "<%:pagination.PageCount()<pagination.NextPage() ?"#":pagination.NextPageLink %>">Newer &rarr;</a></li>
                        </ul>
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
        function ShowTransactionDetail(id) {
            $.get('/admin/transaction/popup_detail_transaction/' + id,
            function (data) {
                $("#transactionDetailModal .modal-dialog").html(data);
                $('#transactionDetailModal').modal({ show: true });
            });
        }
        $('#transactionDetailModal').on('hidden.bs.modal', function (e) {
            $("#transactionDetailModal .modal-dialog").html('');
            // do something...
        });
    </script>
</asp:Content>
