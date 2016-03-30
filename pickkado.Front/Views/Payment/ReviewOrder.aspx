<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site1.Master" Inherits="System.Web.Mvc.ViewPage<pickkado.Front.Models.TransactionModel>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Review Order
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="breadcumb" runat="server">
    <li><a href="/">Home</a></li>
    <li>Catalog</li>
    <li ><%:ViewBag.ProductName %></li>
    <li>Package & Giftcard</li>
    <li>Input your giftcard message</li>
    <li ><a href="<%:ViewBag.LinkBack %>">Purchase Information</a> </li>
    <li class="active">Review Order</li>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container-fluid title-underline">
        <span class="font-avant">
            Review Order
        </span>
    </div>
    <%using (Html.BeginForm()){ %>
        <%: Html.AntiForgeryToken()%>
    <div class="container-fluid" style="padding:15px 0px;">
        <div class="row">
            <div class=" col-md-4 col-lg-4">
                <div class="thumbnail">
                    
                <% var imageNotFound = false;%>
                <%if(Model.TransactionType==pickkado.Front.TransactionType.Order) {%>
                    <%if(Model.orderInfo.imageByte!=null) { %>                        
                        <img class="img-responsive" src="data:image;base64,<%: System.Convert.ToBase64String(Model.orderInfo.imageByte)%>"  />
                    <%} else
                      {
                          imageNotFound = true;
                      }%>
                <%}else if(Model.TransactionType=="CATALOG"){ %>
                    <%if(Model.productInfo.Image!=null) { %>                        
                        <img class="img-responsive" src="data:image;base64,<%: System.Convert.ToBase64String(Model.productInfo.Image)%>"  />
                    <%} else
                      {
                          imageNotFound = true;
                      }%>
                <%}
                    if (imageNotFound)
                    { %>
                    <img src="../../Images/no-thumb.png" class="img-responsive" style="height:100%;width:100%;"/>
                        
                 <%   } 
                  
                 %>
                </div>
                <div class="container-fluid">
                    <table class="table table-responsive table-striped">
                        <thead>
                            <tr>
                                <td colspan="2" style="text-align:center">
                                    Additional Info
                                </td>
                            </tr>
                        </thead>
                        <tbody>
                            <%foreach (var item in ViewBag.AdditionalInfo) { %>
                            <tr>
                                <td><%:item.master.Name %></td>
                                <td><%:item.Value %></td>
                            </tr>
                            <%} %>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="col-md-8 col-lg-8">
                <h3><%:Model.productInfo.Name %> </h3>
            </div>
            <div class="col-md-8 col-lg-8">
                <div class="container-fluid border-white" style="padding:10px; ">
                    
                    <div class="form-group" style="padding:10px 0px;">
                        <div class="col-md-3 col-lg-3" style="padding:5px 10px; ">
                            Transaction Id
                        </div>
                        <div class="col-md-9 col-lg-9 border-white" style="padding:5px 10px; ">
                            <%:Model.TransactionId %>
                        </div>

                    </div>
                    <div class="form-group" style="padding:15px 0px;">
                        <div class="col-md-3 col-lg-3" style="padding:5px 10px; ">
                            Order date
                        </div>
                        <div class="col-md-9 col-lg-9 border-white" style="padding:5px 10px; ">
                            <%:Model.TransactionDate %>
                        </div>                        
                    </div>
                    <div class="form-group" style="padding:15px 0px;">
                        <div class="col-md-3 col-lg-3" style="padding:5px 10px; ">
                            Received Date
                        </div>
                        <div class="col-md-9 col-lg-9 border-white" style="padding:5px 10px; ">
                            <%:(DateTime.Parse(Model.purchaseInfo.DateReceive.ToString() +'/'+ Model.purchaseInfo.MonthReceive.ToString() +'/'+ Model.purchaseInfo.YearReceive.ToString())).ToShortDateString() %>
                        </div>                        
                    </div>
                    <div class="form-group" style="padding:15px 0px;">
                        <div class="col-md-3 col-lg-3" style="padding:5px 10px; ">
                            Nama penerima
                        </div>
                        <div class="col-md-9 col-lg-9 border-white" style="padding:5px 10px; ">
                            <%:Model.purchaseInfo.ReceiverName %>
                        </div>                        
                    </div>
                    <div class="form-group" style="padding:15px 0px;">
                        <div class="col-md-3 col-lg-3" style="padding:5px 10px; ">
                            Number phone
                        </div>
                        <div class="col-md-9 col-lg-9 border-white" style="padding:5px 10px; ">
                            <%:Model.purchaseInfo.PhoneNumber %>
                        </div>                        
                    </div>
                    <div class="form-group" style="padding:15px 0px;">
                        <div class="col-md-3 col-lg-3" style="padding:5px 10px; ">
                            Address
                        </div>
                        <div class="col-md-9 col-lg-9 border-white" style="padding:5px 10px; ">
                            <%:Model.purchaseInfo.DeliveryAddress %>
                        </div>                        
                    </div>
                    <div class="form-group" style="padding:15px 0px;">
                        <div class="col-md-3 col-lg-3" style="padding:5px 10px; ">
                            City
                        </div>
                        <div class="col-md-9 col-lg-9 border-white" style="padding:5px 10px; ">
                            <%:Model.purchaseInfo.postalcode.City %>
                            <%--<%:Model.purchaseInfo.Kota %>--%>
                        </div>                        
                    </div>
                    <div class="form-group" style="padding:15px 0px;">
                        <div class="col-md-3 col-lg-3" style="padding:5px 10px; ">
                            Kecamatan
                        </div>
                        <div class="col-md-9 col-lg-9 border-white" style="padding:5px 10px; ">
                            <%:Model.purchaseInfo.postalcode.Kecamatan %>
                            <%--<%:Model.purchaseInfo.Kecamatan %>--%>
                        </div>                        
                    </div>
                    <div class="form-group" style="padding:15px 0px;">
                        <div class="col-md-3 col-lg-3" style="padding:5px 10px; ">
                            Kelurahan
                        </div>
                        <div class="col-md-9 col-lg-9 border-white" style="padding:5px 10px; ">
                            <%:Model.purchaseInfo.postalcode.Kelurahan %>
                            <%--<%:Model.purchaseInfo.Kelurahan %>--%>
                        </div>                        
                    </div>
                    <div class="form-group" style="padding:15px 0px;">
                        <div class="col-md-offset-3 col-md-9 col-lg-offset-3 col-lg-9" style="padding:15px 10px; ">
                            
                            <div class="col-md-3 col-lg-3" style="text-align:center">
                                <%if(Model.packageInfo.package.Image!=null) {%>
                                <img class="img-circle" src="data:image;base64,<%: System.Convert.ToBase64String(Model.packageInfo.package.Image)%>" style="height:80px; width:80px" />
                                <%}else{ %>
                                <img src="../../Images/no-thumb.png" class="img-circle" height="80" width="80"/>
                                <%} %>
                                <label class="control-label">Package</label>
                            </div>
                            <div class="col-md-3 col-lg-3" style="text-align:center;">
                                <%if(Model.packageInfo.giftcard.Image!=null) {%>
                                <img class="img-circle" src="data:image;base64,<%: System.Convert.ToBase64String(Model.packageInfo.giftcard.Image)%>" style="height:80px; width:80px" />
                                <%}else{ %>
                                <img src="../../Images/no-thumb.png" class="img-circle" height="80" width="80"/>
                                <%} %>
                                <label class="control-label" >Giftcard</label>
                            </div>
                        </div>                        
                    </div>
                </div>
            </div>
            <div class="col-md-12 col-lg-12 " style="padding-top:10px">
                <div class="container-fluid border-white" style="padding:20px; ">
                    <div class="row">
                        <div class="row-height">
                            <div class="col-lg-2 col-height">
                                <div class="form-group form-group-md">
                                    <label class="control-label">Harga Barang</label>
                                    <%--<%var price=Model.TransactionType=="ORDER"?Model.orderInfo.Price:0 ; %>--%>
                                    <%var price = Model.purchaseInfo.ProductPrice; %>
                                    <div class="border-white" style="padding:7px 7px; width:100%; text-align:right"><%:price %></div> 
                                </div>
                            </div>
                            <div class="col-md-1 col-height col-bottom" style="text-align:center;">
                                <h4 style="padding-bottom:10px;">+</h4>
                            </div>
                            <div class="col-lg-2 col-height">
                                <div class="form-group form-group-md">
                                    <label class="control-label">Package</label> 
                                    <%var packagePrice=Model.purchaseInfo.PackagePrice; %>
                                    <div class="border-white" style="padding:7px 7px;width:100%; text-align:right "><%:packagePrice %></div> 
                                </div>
                            </div>
                            <div class="col-md-1 col-height col-bottom" style="text-align:center">
                                <h4 style="padding-bottom:10px;">+</h4>
                            </div>
                            <div class="col-lg-2 col-height">
                                <div class="form-group form-group-md">
                                    <label class="control-label">Giftcard</label> 
                                    <%var giftCardPrice = Model.purchaseInfo.GiftcardPrice; %>
                                    <div class="border-white" style="padding:7px 7px;width:100%; text-align:right "><%:giftCardPrice %></div> 
                                </div>
                            </div>
                            <div class="col-md-offset-1 col-md-1 col-height col-bottom" style="text-align:center">
                                <h4 style="padding-bottom:10px;">=</h4>
                            </div>
                            <div class="col-md-2 col-height col-bottom" >
                                <div class="form-group form-group-md">
                                    <%--<% float jumlah = price + packagePrice + giftCardPrice; %>--%>
                                    <div class="border-white" style="padding:7px 7px; text-align:right "><%:Model.purchaseInfo.SubTotal %></div> 
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="row-height">
                            <div class="col-lg-offset-10 col-lg-2" style="text-align:center">
                                <h4>-</h4>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="row-height">
                            <div class="col-lg-8 col-height col-middle">
                            </div>
                            <div class="col-lg-2 col-height col-middle">
                                Voucher
                            </div>
                            <div class="col-lg-2 col-height col-middle">
                                <div class="border-white" style="padding:7px 7px; width:100%; text-align:right ">Rp. 0</div>                                 
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="row-height">
                            <div class="col-lg-offset-8 col-lg-4" style="margin-top:10px;margin-bottom:10px;">
                                <div style="border-bottom:1px solid #cecccc;">
                                </div>
                            </div>

                        </div>
                    </div>
                    <div class="row">
                        <div class="row-height">
                            <div class="col-lg-8"></div>
                            <div class="col-lg-8 col-height col-middle">
                            </div>
                            <div class="col-lg-2 col-height col-middle">
                                SUB TOTAL
                            </div>
                            <div class="col-lg-2 col-height">
                                <div class="border-white" style="padding:7px 7px; width:100%; text-align:right "><%:Model.purchaseInfo.SubTotal %></div> 
                                
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="row-height">
                            <div class="col-lg-offset-10 col-lg-2" style="text-align:center">
                                <h4 >+</h4>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="row-height">
                            <div class="col-lg-8"></div>
                                <div class="col-lg-2 col-height col-middle">
                                    Service Fee
                                </div>
                                <div class="col-lg-2 col-height col-middle">
                                        <%var serviceFee = "Rp. 30.000"; %>
                                        <div class="border-white" style="padding:7px 7px;width:100%; text-align:right  "><%:serviceFee %></div> 
                                </div>
                            </div>
                        </div>
                    <div class="row">
                        <div class="row-height">
                            <div class="col-lg-offset-10 col-lg-2" style="text-align:center">
                                <h4 >+</h4>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="row-height">
                            <div class="col-lg-2"></div>
                            <div class="col-lg-2 col-height ">
                                <div class="form-group form-group-md">
                                    <label class="control-label">Kurir</label>
                                    <div class="border-white" style="padding:7px 7px;width:100%;"><%:Model.purchaseInfo.NamaKurir %></div>
                                </div>
                            </div>
                            <div class="col-lg-2 col-height ">
                                <div class="form-group form-group-md">
                                    <label class="control-label">Jenis Pengiriman</label>
                                    <div class="border-white" style="padding:7px 7px;width:100%;"><%:Model.purchaseInfo.JenisPaket %></div>
                                </div>
                            </div>
                            <div class="col-lg-2  col-height ">
                                <div class="form-group form-group-md">
                                    <label class="control-label">Asuransi</label>
                                    <div class="border-white" style="padding:7px 7px;width:100%;"><%:Model.purchaseInfo.AsuransiPaket %></div>
                                </div>
                            </div>
                            <div class="col-lg-2 col-height col-middle">Biaya Kirim</div>
                            <div class="col-lg-2  col-height">
                                <label class="control-label"></label>
                                <div class="border-white" style="padding:7px 7px;width:100%;text-align:right; "><%:Model.purchaseInfo.BiayaKirim %></div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="row-height">                            
                            <div class="col-lg-offset-8 col-lg-4" style="margin-top:10px;margin-bottom:10px;">
                                <div style="border-bottom:1px solid #cecccc;">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="row-height"> 
                            <div class="col-lg-8"></div>               
                            <div class="col-lg-2 col-height col-middle">
                                TOTAL
                            </div>
                            <div class="col-lg-2 col-height col-middle">
                                <div class="border-white" style="padding:7px 7px;width:100%;text-align:right; "><%:Model.purchaseInfo.Total %></div>
                                
                            </div>
                        </div>
                    </div>
                    <%if (Model.purchaseInfo.IsPatungan) { %>
                    <div class="container-fluid" style="border:1px solid #cecccc; margin:50px 25px"></div>
                    <div class="container-fluid">
                        <div class="row"style="padding:10px">
                            <div class="col-xs-4" >TOTAL</div>
                            <div class="col-xs-4"><%:Model.purchaseInfo.Total %></div>
                        </div>
                        <div class="row" style="padding:10px">
                            <div class="col-xs-4" >JUMLAH ORANG</div>
                            <div class="col-xs-4" >
                                <div class="border-white" style="padding:7px 7px;width:100%; "><%:ViewBag.JumlahPatungan %></div>
                                <div style="font-size:12px; color:#aaaaaa">*Termasuk anda</div>
                            </div>
                        </div>
                        <div class="row"style="padding:10px">
                            <div class="col-xs-4" >JUMLAH YANG HARUS DIBAYAR PERORANG</div>
                            <div class="col-xs-4"><%:ViewBag.TotalPerorangan %></div>
                        </div>
                        <div class="col-xs-12" style="padding:10px">EMAIL TEMAN - TEMAN ANDA</div>
                        <div class="row" style="padding:10px; padding-bottom:50px">
                            <div class="col-xs-8">
                                <table class="table table-bordered">
                                    <tbody>
                                        <%foreach (var item in Model.purchaseInfo.PatunganFriends) { %>
                                        <tr>
                                            <td style="width:50%"><%:item.Name %></td>
                                            <td><%:item.Email %></td>
                                        </tr>
                                        <%} %>
                                    </tbody>
                                </table>

                            </div>
                        </div>
                    </div>
                      
                      <%} %>
                </div>
            </div>
        </div>
    </div>
    <div class="container-fluid" style=" padding:15px 0px;">            
        <div class="row" style="margin:30px 0px;">
            <div class="col-xm-2 col-sm-2 col-md-2 col-lg-2">
                <a href="<%:(string)ViewBag.LinkBack %>" class="btn btn-block btn-lg btn-login">
                    <img src="../../Images/icon/PanahBackIcon.png" class="lefticon" />
                    Back
                </a>                    
            </div>
            <div class="col-xm-offset-7 col-xm-3 col-sm-offset-7 col-sm-3 col-md-offset-7 col-md-3 col-lg-offset-7 col-lg-3">
                
                <%if(Request.IsAuthenticated){ %>
                <button class="btn btn-block btn-lg btn-login" type="submit">
                    Next
                    <img src="../../Images/icon/PanahNextIcon.png" class="righticon" />
                </button>       
                <%}else{ %>      
                    <a class="btn btn-block btn-lg btn-login" id="btnAuthorize">
                        Next
                        <img src="../../Images/icon/PanahNextIcon.png" class="righticon" />
                    </a>        
                <%} %>      
            </div>
        </div>
    </div>
    <%} %>
    <script>

    </script>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="navBar" runat="server">
    <%Html.RenderAction("login_partial","account"); %>
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ScriptsSection" runat="server">
    <script>
    </script>
</asp:Content>
