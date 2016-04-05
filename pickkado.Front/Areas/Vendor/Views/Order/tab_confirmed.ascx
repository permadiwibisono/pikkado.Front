<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<dynamic>" %>

<table class="datatable table table-striped fadeInUp animated" cellspacing="0" width="100%">
    <thead>
        <tr>
            <th>Id</th>
            <th>Product Name</th>
            <th>Batas Confirm</th>
            <th>Price</th>
            <th>No. Resi</th>
            <th>Remarks</th>
            <th>Status</th>
            <th></th>
        </tr>
    </thead>
    <tbody>
        <%foreach (var item in (List<pickkado.Front.Areas.Vendor.Models.OrderViewModel>)ViewBag.List) {
            %>
          <tr class="animated" data-bind="<%:item.Id%>">
              <td style="vertical-align:middle"><%:item.Id %></td>
              <td style="vertical-align:middle;max-width:150px"><%:item.ProductName %></td>
              <td style="vertical-align:middle"><%:item.BatasWaktu.ToString("dd MMM yyyy") %></td>
              <td style="vertical-align:middle"><%:item.Price %></td>
              <td style="vertical-align:middle;"><%:item.NoResi %></td>
              <td style="vertical-align:middle;max-width:150px"><%:item.Remarks %></td>              
              <td style="vertical-align:middle">
                 
                  <%:item.Status %></td>
              <td>
                  <button class="btn btn-primary" type="button" onclick="ShowProductDetails('<%:item.Id %>');">Details</button>
              </td>
          </tr>
          <%} %>
    </tbody>
</table>