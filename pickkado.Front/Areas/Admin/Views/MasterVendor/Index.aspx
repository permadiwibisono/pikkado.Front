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
        <span class="title">Vendor List</span>
        <a href="<%:Url.Action("edit","mastervendor") %>" class="btn btn-primary"><span class="icon fa fa-plus"></span> New</a>
        <div class="description">Vendor store with their location and contact</div>
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
                            <th>Kota</th>
                            <th>Phone number</th>
                            <th>Web address</th>
                            <th>Updated by</th>
                            <th>Updated date</th>
                              <th></th>
                              <th></th>
                          </tr>
                        </thead>
                        <tfoot>
                          <tr>
                            <th>Name</th>
                            <th>Kota</th>
                            <th>Phone number</th>
                            <th>Web address</th>
                            <th>Updated by</th>
                            <th>Updated date</th>
                              <th></th>
                              <th></th>
                          </tr>
                        </tfoot>
                        <tbody>
                            <%if(((List<pickkado.Entities.Store>)ViewBag.List).Count>0){ %>
                            <%foreach (var i in (List<pickkado.Entities.Store>)ViewBag.List) {%>
                          <tr>
                            <td><%:i.Name %></td>
                            <td><%:i.Kota %></td>
                            <td><%:i.PhoneNumber %></td>
                            <td>
                                <%if(!string.IsNullOrEmpty(i.WebAddress)) { %>
                                    <a href='<%:i.WebAddress %>' target="_blank">Visit</a>
                                <%} else { %>
                                    -
                                <%} %>
                            </td>
                            <td><%:i.UpdatedBy %></td>
                            <td><%:i.UpdatedDate %></td>
                            <td>
                                <a href="<%:Url.Action("edit","mastervendor",new{id=i.Id}) %>" class="btn btn-primary"><span class="icon fa fa-edit"></span> Edit</a>
                            </td>
                                <%using (Html.BeginForm("delete", "mastervendor", new {id=i.Id }, FormMethod.Post)) {%>
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
    <li class="active">Master Vendor</li>
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="navBar" runat="server">
    <%Html.RenderAction("login_partial","account"); %>
</asp:Content>