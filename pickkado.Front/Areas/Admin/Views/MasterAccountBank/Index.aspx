<%@ Page Title="" Language="C#" MasterPageFile="~/Areas/Admin/Views/Shared/Admin.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<div>
    <div class="page-title">
        <span class="title">Account Bank</span>
        <a href="<%:Url.Action("edit","masteraccountbank") %>" class="btn btn-primary"><span class="icon fa fa-plus"></span> New</a>
        <div class="description">This is master of your account bank. Manage here to show in your front end</div>
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
                        <th>Bank</th>
                        <th>Atas Nama</th>
                        <th>No. Rekening</th>
                        <th>Updated by</th>
                        <th>Updated date</th>
                         <th></th>
                         <th></th>
                      </tr>
                    </thead>
                    <tbody>
                        <%if(((List<pickkado.Entities.NoRekeningPickkado>)ViewBag.List).Count>0){ %>
                        <%foreach (var i in (List<pickkado.Entities.NoRekeningPickkado>)ViewBag.List)
                          {%>
          
                      <tr>
                        <td><%:i.Bank %></td>
                        <td><%:i.AtasNama %></td>
                        <td><%:i.NomorRekening %></td>
                        <td><%:i.UpdatedBy %></td>
                        <td><%:i.UpdatedDate %></td>
                        <td>
                            <a href="<%:Url.Action("edit","masteraccountbank",new{id=i.Id}) %>" class="btn btn-primary"><span class="icon fa fa-edit"></span> Edit</a>
                        </td>
                        <%using (Html.BeginForm("delete", "masteraccountbank", new { id = i.Id }, FormMethod.Post,new {id="F"+i.Id }))
                              {%>
                        <td><button type="submit" data-confirm="Are you sure?" data-confirm-title="Warning" form="F<%:i.Id%>" data-target="dataConfirmModal" class="btn btn-default"><span class="icon fa fa-trash"></span> Delete</button></td>
            
                        <%} %>
                      </tr>
                          <%}
                      } else{%>
                        <tr>
                            <td colspan="7">
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
   <li >Dashboard</li>
   <li class="active">Master Account Bank</li>
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="navBar" runat="server">
    <%Html.RenderAction("login_partial","account"); %>
</asp:Content>