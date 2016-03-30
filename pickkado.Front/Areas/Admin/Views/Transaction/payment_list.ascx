<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<pickkado.Entities.Transaction>" %>
 
<table class="datatable table table-striped" cellspacing="0" width="100%">
    <thead>
        <tr>
            <th>Email</th>
            <th>Date</th>
            <th>Type</th>
            <th>No. Rekening</th>
            <th>Atas Nama</th>
            <th>Bank</th>
            <th>Rekening Tujuan</th>
            <th>Bank</th>
            <th>No Struk</th>
            <th>Status</th>
        </tr>
    </thead>
    <tbody>
                            
        <%if(Model.TransactionPayments.Count>0){ %>
        <%foreach (var i in Model.TransactionPayments)
            {%>
          
        <tr>
        <td><%:i.user.Email %></td>
        <td><%:i.TanggalPembayaran %></td>
        <td><%:i.PaymentType %></td>
        <td><%:i.NoRekening %></td>
        <td><%:i.NamaRekening %></td>
        <td><%:i.NamaBank %></td>
        <td><%:i.NoRekeningTujuan %></td>
        <td><%:i.NamaBankTujuan %></td>
        <td><%:i.NoStrukPembayaran %></td>
        <td><%:i.StatusPembayaran %></td>
        <%} %>
        </tr>
            <%}
        else{%>
        <tr>
            <td colspan="10">
                <div class="alert alert-danger">No Record Found</div>

            </td>
        </tr>
        <%} %>
    </tbody>
</table>