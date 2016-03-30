<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<dynamic>" %>
                        

        <%var PageCount = ViewBag.PageCount; %>
        <%var NextPage = ViewBag.NextPage; %>
        <%var PrevPage = ViewBag.PrevPage; %>
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
                    <%foreach (var item in ViewBag.PaymentCheckingList)
                        {%>
                        <tr class="animated">
                            <td><%:item.TanggalPembayaran.ToShortDateString() %></td>
                            <td><%:item.user.Email %></td>
                            <td><%:item.NoRekening %></td>
                            <td><%:item.NamaBank %></td>
                            <td><%:item.NoRekeningTujuan %></td>
                            <td><%:item.NamaBankTujuan %></td>
                            <td>Rp. <%:item.TotalDiBayar %></td>
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
        <div class="col-xs-12">
            <ul class = "pager">
                
                <li class = "previous  <%:PrevPage <= 0 ? "disabled" : "" %>"   ><a href="<%:PrevPage <= 0 ?"javascript:void(0)":"javascript:goToPage('#paymentlist .contentplaceholder','"+Url.Action("tab_paymentlist")+"','#paymentlist select',"+PrevPage+");"%>"  >&larr; Older</a></li>
                <li class = "next <%: PageCount<NextPage ? "disabled" : "" %>"><a href="<%:PageCount<NextPage ?"javascript:void(0)":"javascript:goToPage('#paymentlist .contentplaceholder','"+Url.Action("tab_paymentlist")+"','#paymentlist select',"+NextPage+");"%>">Newer &rarr;</a></li>
            </ul>
        </div>
    
<script>

</script>
