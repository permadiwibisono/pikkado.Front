<%@ Page Title="" Language="C#" MasterPageFile="~/Areas/Vendor/Views/Shared/Vendor.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    
    <div class="page-title">
        <span class="title">My Products</span>
        <a href="<%:Url.Action("new","product") %>" class="btn btn-primary"><span class="icon fa fa-plus"></span> New</a>
        <div class="description"></div>
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
                    <table class="datatable table table-striped fadeInUp animated">
                    <thead>
                      <tr>
                        <th>Name</th>
                        <th>Category</th>
                        <th>Weight (gr)</th>
                        <th>Gender</th>
                        <th>Price</th>
                         <th></th>
                      </tr>
                    </thead>
                    <tbody>
                        <%if(ViewBag.List.Count>0){ %>
                        <%foreach (var i in ViewBag.List)
                          {%>
          
                      <tr>
                        <td><%:i.Name %></td>
                        <td><%:i.CategoryName %></td>
                        <td><%:i.Weight %></td>
                        <td><%:i.Gender %></td>
                        <td>Rp. <%:i.Price %></td>
                        <td>
                            <%using (Html.BeginForm("delete", "product", new { id = i.Id }, FormMethod.Post,new {id="F"+i.Id }))
                            {} %>
                            <div class="btn-group">                                
                                <a href="<%:Url.Action("edit","product",new{id=i.Id}) %>" class="btn btn-primary"><span class="icon fa fa-edit"></span> </a>
                                <button type="submit" data-confirm="Are you sure?" data-confirm-title="Warning" form="F<%:i.Id%>" data-target="dataConfirmModal" class="btn btn-default"><span class="icon fa fa-trash"></span></button>
                            </div>
                        </td>                                  
                      </tr>
                          <%}
                      } else{%>
                        <tr>
                            <td colspan="6">
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

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="breadcumber" runat="server">
   <li >Dashboard</li>
   <li class="active">My Products</li>
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ScriptContent" runat="server">
</asp:Content>
