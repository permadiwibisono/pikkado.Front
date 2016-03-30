<%@ Page Title="" Language="C#" MasterPageFile="~/Areas/Admin/Views/Shared/Admin.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    
    <%if(!string.IsNullOrEmpty(ViewBag.Success)){%>                               
        <div id="message" class="alert alert-success fadeIn animated">
            <a href="#" class="close" data-dismiss="alert">×</a>
            <strong>Success</strong> <%:ViewBag.Success%>
        </div>
    <%} %>
    <%if(!string.IsNullOrEmpty(ViewBag.Error)){%>                               
        <div id="message" class="alert alert-danger fadeIn animated">
            <a href="#" class="close" data-dismiss="alert">×</a>
            <strong>Error</strong> <%:ViewBag.Error%>
        </div>
    <%} %>
    <div class="page-title">
        <span class="title">Voucher</span>
        <a href="<%:Url.Action("edit","mastervoucher") %>" class="btn btn-primary"><span class="icon fa fa-plus"></span> New</a>
        <div class="description">This is master of your vouchers. Manage here to show in your front end</div>
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
                    <table class="datatable table table-striped" cellspacing="0" width="100%">
                        <thead>
                          <tr>
                            <th>Voucher Id</th>
                            <th>Name</th>
                            <th>Type</th>
                            <th>Voucher Discount</th>
                            <th>From Date</th>
                            <th>To Date</th>
                            <th>Min Transaction</th>
                            <th></th>
                            <th></th>
                          </tr>
                        </thead>
                        <tbody>
                            <%if(((List<pickkado.Entities.VoucherMaster>)ViewBag.List).Count>0){ %>
                            <%foreach (var i in (List<pickkado.Entities.VoucherMaster>)ViewBag.List)
                              {%>
          
                          <tr>
                            <td><%:i.Id %></td>
                            <td><%:i.Name %></td>
                            <td><%:i.VoucherType %></td>
                            <td><%:i.VoucherDiscount %></td>
                            <td><%:i.FromDate.ToShortDateString() %></td>
                            <td><%:i.ToDate.ToShortDateString() %></td>
                            <td><%:i.MinTransaction %></td>
                            <td>
                                <a href="<%:Url.Action("edit","mastervoucher",new{id=i.Id}) %>" class="btn btn-primary"><span class="icon fa fa-edit"></span> Edit</a>
                            </td>
                            <%using (Html.BeginForm("delete", "mastervoucher", new {id=i.Id }, FormMethod.Post))
                                  {%>
                            <td><button type="submit" class="btn btn-default"><span class="icon fa fa-trash"></span> Delete</button></td>
            
                            <%} %>
                          </tr>
                              <%}
                          } else{%>
                            <tr>
                                <td colspan="9">
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
   <li class="active">Master Vouchers</li>
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ScriptContent" runat="server">
</asp:Content>

<asp:Content ID="Content5" ContentPlaceHolderID="navBar" runat="server">
    <%Html.RenderAction("login_partial","account"); %>
</asp:Content>