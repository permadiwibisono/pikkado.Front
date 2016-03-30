<%@ Page Title="" Language="C#" MasterPageFile="~/Areas/Admin/Views/Shared/Admin.Master" Inherits="System.Web.Mvc.ViewPage<pickkado.Entities.Transaction>" %>

<asp:Content ID="Content5" ContentPlaceHolderID="navBar" runat="server">
    <%Html.RenderAction("login_partial","account"); %>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="page-title">
        <span class="title">Transaction</span>
        <div class="description">List of your transaction, please check it</div>
    </div>
    <div class="row">
        <div class="col-xs-12">
            <div class="card">
                <div class="card-body no-padding">
                    <div role="tabpanel">
                        <!-- Nav tabs -->
                        <ul class="nav nav-tabs" role="tablist">
                            <li role="presentation" class="<%:ViewBag.Tab=="list"?"active":"" %>"><a href="#list" aria-controls="list" role="tab" data-toggle="tab">List</a></li>
                            <li role="presentation" class="<%:ViewBag.Tab=="header"?"active":"" %>"><a href="#header" aria-expanded="true" aria-controls="profile" role="tab" data-toggle="tab">Header</a></li>
                            <li role="presentation"><a href="#userinfo" aria-controls="user" role="tab" data-toggle="tab">User info</a></li>
                            <li role="presentation"><a href="#product" aria-controls="product" role="tab" data-toggle="tab">Product info</a></li>
                            <li role="presentation"><a href="#package" aria-controls="package" role="tab" data-toggle="tab">Package info</a></li>
                            <li role="presentation"><a href="#vendor" aria-controls="vendor" role="tab" data-toggle="tab">Vendor info</a></li>
                            <li role="presentation"><a href="#payment" aria-controls="payment" role="tab" data-toggle="tab">Payment List</a></li>
                        </ul>
                        <!-- Tab panes -->
                        <div class="tab-content">
                            <div role="tabpanel" class="tab-pane <%:ViewBag.Tab=="list"?" active":"" %>" id="list">                        
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
                                                    <th>TransactionId</th>
                                                    <th>Date</th>
                                                    <th>Type</th>
                                                    <th>Username</th>
                                                    <th>Deadline</th>
                                                    <th>Total</th>
                                                    <th>Status</th>
                                                    <th></th>
                                                </tr>
                                            </thead>
                                            <tbody>
                            
                                                <%if(((List<pickkado.Entities.Transaction>)ViewBag.List).Count>0){ %>
                                                <%foreach (var i in (List<pickkado.Entities.Transaction>)ViewBag.List)
                                                    {%>
          
                                                <tr>
                                                <td><%:i.Id %></td>
                                                <td><%:i.TransDate %></td>
                                                <td><%:i.TransactionType %></td>
                                                <td><%:i.UserName %></td>
                                                <td><%:i.TanggalKirim.ToShortDateString() %></td>
                                                    <%var jumlah=i.ProductPrice+i.PackagePrice+i.GreetingCardPrice+i.ShippingFee+i.ServiceFee; %>
                                                <td>Rp. <%:jumlah %></td>
                                                <td><%:i.Status %></td>
                                                <td>
                                                    <a href="<%:Url.Action("","transaction",new{id=i.Id}) %>" class="link "><span class="icon fa fa-edit"></span> Details</a>
                                                </td>
                                                <%} %>
                                                </tr>
                                                    <%}
                                                else{%>
                                                <tr>
                                                    <td colspan="8">
                                                        <div class="alert alert-danger">No Record Found</div>

                                                    </td>
                                                </tr>
                                                <%} %>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                            <div role="tabpanel" class="tab-pane <%:ViewBag.Tab=="header"?" active":"" %>" id="header">
                                <div class="card">
                                    <div class="card-header">
                                        <div class="card-title">
                                        <div class="title">Header</div>
                                        </div>
                                    </div>
                                    <div class="card-body">
                                        <div class="container-fluid form-horizontal">
                                            <%if(Model!=null){ %>                                            
                                                <%Html.RenderPartial("header", Model); %>
                                            <%} %>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div role="tabpanel" class="tab-pane" id="userinfo">
                                <div class="card">
                                    <div class="card-header">
                                        <div class="card-title">
                                        <div class="title">User info</div>
                                        </div>
                                    </div>
                                    <div class="card-body">
                                        <div class="container-fluid form-horizontal">
                                            <%if(Model!=null){ %>                                            
                                                <%Html.RenderPartial("user", Model); %>
                                            <%} %>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div role="tabpanel" class="tab-pane" id="product">
                                <div class="card">
                                    <div class="card-header">
                                        <div class="card-title">
                                        <div class="title">Product info</div>
                                        </div>
                                    </div>
                                    <div class="card-body">
                                        <div class="container-fluid form-horizontal">
                                            <%if(Model!=null){ %>                                            
                                                <%Html.RenderPartial("product", Model); %>
                                            <%} %>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div role="tabpanel" class="tab-pane" id="package">
                                <div class="card">
                                    <div class="card-header">
                                        <div class="card-title">
                                        <div class="title">Package info</div>
                                        </div>
                                    </div>
                                    <div class="card-body">
                                        <div class="container-fluid form-horizontal">
                                            <%if(Model!=null){ %>                                            
                                                <%Html.RenderPartial("package", Model); %>
                                            <%} %>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div role="tabpanel" class="tab-pane" id="vendor">
                                <div class="card">
                                    <div class="card-header">
                                        <div class="card-title">
                                        <div class="title">Vendor info</div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div role="tabpanel" class="tab-pane" id="payment">
                                <div class="card">
                                    <div class="card-header">
                                        <div class="card-title">
                                        <div class="title">Payment list</div>
                                        </div>
                                    </div>
                                    <div class="card-body">
                                        <div class="container-fluid form-horizontal">
                                            <%if(Model!=null){ %>                                            
                                                <%Html.RenderPartial("payment_list", Model); %>
                                            <%} %>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
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
   <li class="active">Transaction</li>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ScriptContent" runat="server">
</asp:Content>
