<%@ Page Title="" Language="C#" MasterPageFile="~/Areas/Admin/Views/Shared/Admin.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div >
        <%if(!string.IsNullOrEmpty(ViewBag.Success)){%>                               
            <div id="message" class="alert alert-success fadeIn animated">
                <a href="#" class="close" data-dismiss="alert">×</a>
                <strong>Success</strong> <%:ViewBag.Success%>
            </div>
        <%} %>
        <%if(!string.IsNullOrEmpty(ViewBag.Error)){%>                               
            <div id="Div1" class="alert alert-danger fadeIn animated">
                <a href="#" class="close" data-dismiss="alert">×</a>
                <strong>Error</strong> <%:ViewBag.Error%>
            </div>
        <%} %>
        <div class="page-title">
            <span class="title">Product List</span>
            <a href="<%:Url.Action("edit","masterproduct") %>" class="btn btn-primary"><span class="icon fa fa-plus"></span> New</a>
            <div class="description">Pickkado product</div>
        </div>
        <div class="row">
        <div class="col-xs-12">
            <div class="card">                
                <div class="card-header">
                    <div class="card-title">
                    <div class="title">List</div>
                    </div>
                </div>
                <div class="card-body">
                    <table class="datatable table table-striped fadeInUp animated" cellspacing="0" width="100%">
                        <thead>
                          <tr>
                            <th>Name</th>
                            <th>Category</th>
                            <th>Price</th>
                            <th>Updated by</th>
                            <th>Updated date</th>
                              <th></th>
                              <th></th>
                          </tr>
                        </thead>
                        <tfoot>
                          <tr>
                            <th>Name</th>
                            <th>Category</th>
                            <th>Price</th>
                            <th>Updated by</th>
                            <th>Updated date</th>
                              <th></th>
                              <th></th>
                          </tr>
                        </tfoot>
                        <tbody>
                            <%if(((List<pickkado.Entities.Product>)ViewBag.List).Count>0){ %>
                            <%foreach (var i in (List<pickkado.Entities.Product>)ViewBag.List)
                              {%>
                          <tr>
                            <td><%:i.Name %></td>
                            <td><%:i.Categories %></td>
                            <td><%:i.Price %></td>
                            <td><%:i.UpdatedBy %></td>
                            <td><%:i.UpdatedDate %></td>
                            <td>
                                <a href="<%:Url.Action("edit","masterproduct",new{id=i.Id}) %>" class="btn btn-primary"><span class="icon fa fa-edit"></span> Edit</a>
                            </td>
                                <%using (Html.BeginForm("delete", "masterproduct", new {id=i.Id }, FormMethod.Post)) {%>
                            <td><button type="submit" class="btn btn-default"><span class="icon fa fa-trash"></span> Delete</button></td>
                                <%} %>
                          </tr>
                            <%}
                          } else {%>
                            <tr>
                                <td colspan="4">
                                    <div class="alert alert-danger">No Record Found</div>
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
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="breadcumber" runat="server">
    <li>Dashboard</li>
    <li class="active">Master Product</li>
</asp:Content>
