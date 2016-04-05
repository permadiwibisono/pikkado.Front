<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<dynamic>" %>

<table class="datatable table table-striped fadeInUp animated" cellspacing="0" width="100%">
    <thead>
        <tr>
            <th>Id</th>
            <th>Product Name</th>
            <th>Batas Confirm</th>
            <th>Price</th>
            <th></th>
        </tr>
    </thead>
    <tbody>
        <%for (int i = 0; i < 5; i++) {
            %>
          <tr class="animated">
              <td style="vertical-align:middle">i0001</td>
              <td style="vertical-align:middle;max-width:250px">Nike Sport XL</td>
              <td style="vertical-align:middle">25 Desember 2016</td>
              <td style="vertical-align:middle">Rp. 3.000.000</td>
              <td>
                  <button class="btn btn-primary">Details</button>
              </td>
          </tr>
          <%} %>
    </tbody>
</table>