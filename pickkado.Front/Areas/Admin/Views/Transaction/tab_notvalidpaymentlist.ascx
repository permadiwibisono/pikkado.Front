<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<dynamic>" %>
                        

        <%var pagination = ViewBag.Pagination; %>
        <table class="datatable table table-striped fadeInUp animated" cellspacing="0" width="100%">
            <thead>
                <tr>
                    <th>Date</th>
                    <th>Username</th>
                    <th>No Rekening</th>
                    <th>Bank</th>
                    <th>No Rekening Tujuan</th>
                    <th>Transfer ke</th>
                    <th>Total</th>
                    <th></th>
                </tr>
            </thead>
            <tbody>
                    <%foreach (var item in ViewBag.NotValidPaymentList)
                        {%>
                        <tr>
                            <td style="vertical-align:middle"><%:item.TanggalPembayaran.ToShortDateString() %></td>
                            <td style="vertical-align:middle"><%:item.user.Email %></td>
                            <td style="vertical-align:middle"><%:item.NoRekening %></td>
                            <td style="vertical-align:middle"><%:item.NamaBank %></td>
                            <td style="vertical-align:middle"><%:item.NoRekeningTujuan %></td>
                            <td style="vertical-align:middle"><%:item.NamaBankTujuan %></td>
                            <td style="vertical-align:middle">Rp. <%:item.TotalDiBayar %></td>
                        <td style="vertical-align:middle">
                        <div class="btn-group">
                            <button class="btn btn-primary btn-details" name="<%:item.Id %>">Details</button>
                        </div>
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
                <li class = "previous  <%:pagination.PrevPage() <= 0 ? "disabled" : "" %>"   ><a href="<%:pagination.PrevPage() <= 0 ?"javascript:void(0)":pagination.PrevPageLink%>"  >&larr; Older</a></li>
                <li class = "next <%: pagination.PageCount()<pagination.NextPage() ? "disabled" : "" %>"><a href="<%:pagination.PageCount()<pagination.NextPage() ?"javascript:void(0)":pagination.NextPageLink%>">Newer &rarr;</a></li>
            </ul>
            <%--<ul class = "pager">                
                <li class = "previous  <%:PrevPage <= 0 ? "disabled" : "" %>"   ><a href="<%:PrevPage <= 0 ?"javascript:void(0)":"javascript:goToPage('#notvalidpaymentlist .contentplaceholder','"+Url.Action("tab_notvalidpaymentlist")+"','#notvalidpaymentlist select',"+PrevPage+");"%>"  >&larr; Older</a></li>
                <li class = "next <%: PageCount<NextPage ? "disabled" : "" %>"><a href="<%:PageCount<NextPage ?"javascript:void(0)":"javascript:goToPage('#notvalidpaymentlist .contentplaceholder','"+Url.Action("tab_notvalidpaymentlist")+"','#notvalidpaymentlist select',"+NextPage+");"%>">Newer &rarr;</a></li>
            </ul>--%>
        </div>
