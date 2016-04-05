<%@ Page Title="" Language="C#" MasterPageFile="~/Areas/Admin/Views/Shared/Admin.Master" Inherits="System.Web.Mvc.ViewPage<pickkado.Front.Areas.Admin.Models.HomeViewModel>" %>

<asp:Content ContentPlaceHolderID="breadcumber" runat="server">
   <li class="active">Dashboard</li>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">    
        <div class="row ">
            <div class="col-lg-3 col-md-6 col-sm-6 col-xs-12">
                <a href="#" class="">
                    <div class="card blue summary-inline fadeIn animated">
                        <div class="card-body">
                            <i class="icon fa fa-user-plus fa-4x"></i>
                            <div class="content">
                                <div class="title"><%:Model.NewUserMonth %></div>
                                <div class="sub-title">New User in This Month</div>
                            </div>
                            <div class="clear-both"></div>
                        </div>
                    </div>
                </a>
            </div>
            <div class="col-lg-3 col-md-6 col-sm-6 col-xs-12">
                <a href="#">
                    <div class="card blue summary-inline fadeIn animated">
                        <div class="card-body">
                            <i class="icon fa fa-user fa-4x"></i>
                            <div class="content">
                                <div class="title"><%:Model.TotalUser %></div>
                                <div class="sub-title">Users Registered</div>
                            </div>
                            <div class="clear-both"></div>
                        </div>
                    </div>
                </a>
            </div>
            <div class="col-lg-3 col-md-6 col-sm-6 col-xs-12">
                <a href="#">
                    <div class="card blue summary-inline fadeIn animated">
                        <div class="card-body">
                            <i class="icon fa fa-heart fa-4x"></i>
                            <div class="content">
                                <div class="title"><%:Model.NewVendorMonth %></div>
                                <div class="sub-title">New Vendor in This Month</div>
                            </div>
                            <div class="clear-both"></div>
                        </div>
                    </div>
                </a>
            </div>
            <div class="col-lg-3 col-md-6 col-sm-6 col-xs-12">
                <a href="#">
                    <div class="card blue summary-inline fadeIn animated">
                        <div class="card-body">
                            <i class="icon fa fa-user-secret fa-4x"></i>
                            <div class="content">
                                <div class="title"><%:Model.TotalVendor %></div>
                                <div class="sub-title">Vendor Registered</div>
                            </div>
                            <div class="clear-both"></div>
                        </div>
                    </div>
                </a>
            </div>
            <div class="col-lg-3 col-md-6 col-sm-6 col-xs-12">
                <a href="#">
                    <div class="card green summary-inline fadeIn animated">
                        <div class="card-body">
                            <i class="icon fa fa-shopping-bag fa-4x"></i>
                            <div class="content">
                                <div class="title"><%:Model.TotalProductPopular %></div>
                                <div class="sub-title"><%:Model.ProductNamePopular %></div>
                            </div>
                            <div class="clear-both"></div>
                        </div>
                    </div>
                </a>
            </div>
            <div class="col-lg-3 col-md-6 col-sm-6 col-xs-12">
                <a href="#">
                    <div class="card green summary-inline fadeIn animated">
                        <div class="card-body">
                            <i class="icon fa fa-tags fa-4x"></i>
                            <div class="content">
                                <div class="title"><%:Model.TotalProduct %></div>
                                <div class="sub-title">Total Products</div>
                            </div>
                            <div class="clear-both"></div>
                        </div>
                    </div>
                </a>
            </div>
            <div class="col-lg-3 col-md-6 col-sm-6 col-xs-12">
                <a href="#">
                    <div class="card green summary-inline fadeIn animated">
                        <div class="card-body">
                            <i class="icon fa fa-gift fa-4x"></i>
                            <div class="content">
                                <div class="title"><%:Model.TotalPackage %></div>
                                <div class="sub-title">Total Package</div>
                            </div>
                            <div class="clear-both"></div>
                        </div>
                    </div>
                </a>
            </div>
            <div class="col-lg-3 col-md-6 col-sm-6 col-xs-12">
                <a href="#">
                    <div class="card green summary-inline fadeIn animated">
                        <div class="card-body">
                            <i class="icon fa fa-credit-card fa-4x"></i>
                            <div class="content">
                                <div class="title"><%:Model.TotalGiftcard %></div>
                                <div class="sub-title">Total Giftcard</div>
                            </div>
                            <div class="clear-both"></div>
                        </div>
                    </div>
                </a>
            </div>
            <div class="col-lg-3 col-md-6 col-sm-6 col-xs-12">
                <a href="#">
                    <div class="card red summary-inline fadeIn animated">
                        <div class="card-body">
                            <i class="icon fa fa-plus-circle fa-4x"></i>
                            <div class="content">
                                <div class="title"><%:Model.NewOrderToday %></div>
                                <div class="sub-title">New Order Today</div>
                            </div>
                            <div class="clear-both"></div>
                        </div>
                    </div>
                </a>
            </div>
            <div class="col-lg-3 col-md-6 col-sm-6 col-xs-12">
                <a href="#">
                    <div class="card red summary-inline fadeIn animated">
                        <div class="card-body">
                            <i class="icon fa fa-shopping-cart fa-4x"></i>
                            <div class="content">
                                <div class="title"><%:Model.TotalOrder %></div>
                                <div class="sub-title">Total Orders</div>
                            </div>
                            <div class="clear-both"></div>
                        </div>
                    </div>
                </a>
            </div>
            <div class="col-lg-3 col-md-6 col-sm-6 col-xs-12">
                <a href="#">
                    <div class="card red summary-inline fadeIn animated">
                        <div class="card-body">
                            <i class="icon fa fa-plus-square fa-4x"></i>
                            <div class="content">
                                <div class="title"><%:Model.NewPatunganToday %></div>
                                <div class="sub-title">New Patungan Today</div>
                            </div>
                            <div class="clear-both"></div>
                        </div>
                    </div>
                </a>
            </div>
            <div class="col-lg-3 col-md-6 col-sm-6 col-xs-12">
                <a href="#">
                    <div class="card red summary-inline fadeIn animated">
                        <div class="card-body">
                            <i class="icon fa fa-users fa-4x"></i>
                            <div class="content">
                                <div class="title"><%:Model.TotalPatungan %></div>
                                <div class="sub-title">Total Patungan</div>
                            </div>
                            <div class="clear-both"></div>
                        </div>
                    </div>
                </a>
            </div>
            <div class="col-md-6 col-sm-6 col-xs-12">
                <a href="#">
                    <div class="card green summary-inline fadeIn animated">
                        <div class="card-body">
                            <i class="icon fa fa-thumbs-up fa-4x"></i>
                            <div class="content">
                                <div class="title"><%:Model.Income %></div>
                                <div class="sub-title">Income</div>
                            </div>
                            <div class="clear-both"></div>
                        </div>
                    </div>
                </a>
            </div>
            <div class=" col-md-6 col-sm-6 col-xs-12">
                <a href="#">
                    <div class="card red summary-inline fadeIn animated">
                        <div class="card-body">
                            <i class="icon fa fa-thumbs-down fa-4x"></i>
                            <div class="content">
                                <div class="title"><%:Model.Outcome %></div>
                                <div class="sub-title">Outcome</div>
                            </div>
                            <div class="clear-both"></div>
                        </div>
                    </div>
                </a>
            </div>
            <div class="col-lg-3 col-md-6 col-sm-6 col-xs-12">
                <a href="#">
                    <div class="card yellow summary-inline fadeIn animated">
                        <div class="card-body">
                            <i class="icon fa fa-money fa-4x"></i>
                            <div class="content">
                                <div class="title"><%:Model.OnPaymentChecking %></div>
                                <div class="sub-title">On Payment Checking</div>
                            </div>
                            <div class="clear-both"></div>
                        </div>
                    </div>
                </a>
            </div>
            <div class="col-lg-3 col-md-6 col-sm-6 col-xs-12">
                <a href="#">
                    <div class="card yellow summary-inline fadeIn animated">
                        <div class="card-body">
                            <i class="icon fa fa-truck fa-4x"></i>
                            <div class="content">
                                <div class="title"><%:Model.OnProccess %></div>
                                <div class="sub-title">On Process</div>
                            </div>
                            <div class="clear-both"></div>
                        </div>
                    </div>
                </a>
            </div>
            <div class="col-lg-3 col-md-6 col-sm-6 col-xs-12">
                <a href="#">
                    <div class="card yellow summary-inline fadeIn animated">
                        <div class="card-body">
                            <i class="icon fa fa-ban fa-4x"></i>
                            <div class="content">
                                <div class="title"><%:Model.OnCancelled %></div>
                                <div class="sub-title">On Canceled</div>
                            </div>
                            <div class="clear-both"></div>
                        </div>
                    </div>
                </a>
            </div>
            <div class="col-lg-3 col-md-6 col-sm-6 col-xs-12">
                <a href="#">
                    <div class="card yellow summary-inline fadeIn animated">
                        <div class="card-body">
                            <i class="icon fa fa-check fa-4x"></i>
                            <div class="content">
                                <div class="title"><%:Model.OnSuccess %></div>
                                <div class="sub-title">On Success</div>
                            </div>
                            <div class="clear-both"></div>
                        </div>
                    </div>
                </a>
            </div>
        </div>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="navBar" runat="server">
    <%Html.RenderAction("login_partial","account"); %>
</asp:Content>
