<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<pickkado.Entities.Transaction>" %>


<table class="datatable table table-striped" cellspacing="0" width="100%">
    <thead>
        <tr>
            <th>Email</th>
            <th>Price</th>
            <th>Join</th>
            <th>Confirmed</th>
        </tr>
    </thead>
    <tbody>
                            
        <%if(Model.TransactionMemberGroups.Count>0){ %>
        <%foreach (var i in Model.TransactionMemberGroups)
            {%>
          
        <tr>
        <td><%:i.Email %></td>
        <td><%:i.Price %></td>
        <td><input type="checkbox" disabled <%:i.IsAccept?"checked":"" %>/> </td>
        <td><input type="checkbox" disabled <%:i.IsResponse?"checked":"" %>/> </td>
        <%} %>
        </tr>
            <%}
        else{%>
        <tr>
            <td colspan="4">
                <div class="alert alert-danger">No Record Found</div>

            </td>
        </tr>
        <%} %>
    </tbody>
</table>