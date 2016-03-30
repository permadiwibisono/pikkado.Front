<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<List<pickkado.Entities.Transaction>>" %>

<div style="padding: 50px; margin-left: 120px">
    <div class="container-fluid title-underline">
        <span class="font-avant" style="font-size: 15px">
            Pembelian yang Sedang Dalam Proses
        </span>
    </div>
    <%var userLogin = (pickkado.Entities.User)TempData["UserLogin"]; %>
    <%var onProcessModel = Model.Where(a => (a.Status == pickkado.Front.TransactionStatus.OnBuying ||
                            a.Status == pickkado.Front.TransactionStatus.OnDelivering ||
                            a.Status == pickkado.Front.TransactionStatus.CompletedAdmin) &&
                            ((!a.IsGroup && a.UserId == userLogin.Id) || (a.IsGroup && a.TransactionMemberGroups.Where(b => b.UserId == userLogin.Id && b.IsAccept && b.IsResponse).ToList().Count > 0))).ToList(); %>
    <%if (onProcessModel.Count > 0)
      { %>
        <div class="container-fluid" style="padding: 15px 0px;">
        <div style="max-height: 2500px; overflow: auto">
            <%foreach (var m in onProcessModel) %>
            <%{ %>
                    
                    <div>
                <div style="border: 1px solid #363737; height:120px; padding: 10px; background-color: white">
                    <div class="col-md-2">
                        <%if (m.ProductImage == null)
                          { %>
                        <div class="square">
                            <img src="../../../../Images/no-thumb.png" style="height: 100px; display: block; margin: 0 auto" />
                        </div>
                        <%}
                          else
                          {%>
                        <div class="square">
                            <img src="data:image;base64,<%:System.Convert.ToBase64String(m.ProductImage) %>" style="height: 100px; display: block; margin: 0 auto;" />
                        </div>
                        <%} %>
                    </div>
                    <div class="col-md-8">
                        <div style="font-size: 15px; text-transform: uppercase">
                            <%:m.ProductName %>
                        </div>
                        <table>
                            <tr>
                                <td style="width: 200px">Tanggal Transaksi
                                </td>
                                <td>:</td>
                                <td style="padding-left: 10px">
                                    <%:m.TransDate.ToString("dd/MM/yyyy") %>
                                </td>
                            </tr>
                            <tr>
                                <td>Total
                                </td>
                                <td>:</td>
                                <td style="padding-left: 10px">
                                    <%: m.GetTotalPrice() %>
                                </td>
                            </tr>
                            <%if (m.IsGroup)
                              { %>
                            <tr>
                                <td>Total yang harus dibayar
                                </td>
                                <td>:</td>
                                <td style="padding-left: 10px;">
                                    <%:m.TransactionMemberGroups.Where(a => a.UserId == userLogin.Id).ToList()[0].Price %>
                                </td>
                            </tr>
                            <%} %>
                            <tr>
                                <td>Status
                                </td>
                                <td>:</td>
                                <td style="padding-left: 10px;">
                                    <%:m.Status %>
                                </td>
                            </tr>
                        </table>
                    </div>
                    
                    <div style="float: right; padding-top: 65px; ">
                        <button id="show<%:m.Id %>" class="btn btn-link" style="text-decoration:none; color:#333333; outline:none" data-toggle="collapse" data-target="#div<%:m.Id %>" onclick="toggleExpandCollapse('show<%:m.Id %>', 'div<%:m.Id %>')">Tampilkan <span class="glyphicon glyphicon-chevron-down"></span></button>
                    </div>
                </div>
                <div id="div<%:m.Id %>" class="collapse" >
                    <div>
                        <div>
                            <table style="width: 100%; height: 100%">
                                <tr>
                                    <td style="border: 1px solid #363737; width: 50%; padding: 10px; text-align: left; vertical-align: top">
                                        <table>
                                            <tr>
                                                <td style="width: 170px">Transaction Id
                                                </td>
                                                <td>:</td>
                                                <td style="padding-left: 10px">
                                                    <%:m.Id %>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="width: 150px">Nama Penerima
                                                </td>
                                                <td>:</td>
                                                <td style="padding-left: 10px">
                                                    <%:m.ReceiveName %>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="width: 150px">Phone Number
                                                </td>
                                                <td>:</td>
                                                <td style="padding-left: 10px">
                                                    <%:userLogin.PhoneNumber %>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="width: 150px"></td>
                                                <td></td>
                                                <td style="padding-left: 10px">
                                                    <table>
                                                        <tr>
                                                            <td style="text-align: center; width:150px">
                                                                <%if(m.PackageImage == null) { %>
                                                                    <div class="square">
                                                                        <img src="../../../../Images/no-thumb.png" class="img-circle" style="float: left; height:100px; width:100px; margin-right: 10px;" />
                                                                    </div>
                                                                <%} else { %>
                                                                    <div class="square">
                                                                        <img src="data:image;base64,<%:System.Convert.ToBase64String(m.PackageImage) %>" class="img-circle" style="float: left; height:100px; width:100px; margin-right: 10px;" />
                                                                    </div>
                                                                <%} %>
                                                            </td>
                                                            <td style="text-align: center; width:150px">
                                                                <%if(m.GreetingCardImage == null) { %>
                                                                    <div class="square">
                                                                        <img src="../../../../Images/no-thumb.png" class="img-circle" style="float: left; height:100px; width:100px; margin-right: 10px;" />
                                                                    </div>
                                                                <%} else { %>
                                                                    <div class="square">
                                                                        <img src="data:image;base64,<%:System.Convert.ToBase64String(m.GreetingCardImage) %>" class="img-circle" style="float: left; height:100px; width:100px; margin-right: 10px;" />
                                                                    </div>
                                                                <%} %>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="text-align: center; width:150px">
                                                                <span>
                                                                    <%:Html.DisplayFor(a => m.PackageName)%> 
                                                                </span>
                                                                
                                                            </td>
                                                            <td style="text-align: center; width:150px">
                                                                <span>
                                                                    <%:Html.DisplayFor(a => m.GreetingCardName) %>
                                                                </span>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                    <td style="border: 1px solid #363737; width: 50%; padding: 10px; text-align: left; vertical-align: top">
                                        <table>
                                            <tr>
                                                <td style="width: 200px">City 
                                                </td>
                                                <td>:</td>
                                                <td style="padding-left: 10px">
                                                    <%:m.City %>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="width: 200px">Kecamatan
                                                </td>
                                                <td>:</td>
                                                <td style="padding-left: 10px">
                                                    <%:m.Kecamatan %>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="width: 200px">Kelurahan
                                                </td>
                                                <td>:</td>
                                                <td style="padding-left: 10px">
                                                    <%:m.Kelurahan %>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="width: 200px; vertical-align: top">Address
                                                </td>
                                                <td style="vertical-align: top">:</td>
                                                <td style="padding-left: 10px;">
                                                    <%:m.DestinationAddress %>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="width: 200px; vertical-align: top">No. RESI
                                                </td>
                                                <td style="vertical-align: top">:</td>
                                                <td style="padding-left: 10px;">
                                                    <%:m.ResiNumber %>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div style="border: 1px solid #363737; padding: 10px">
                            <table style="width: 100%; height: 100%">
                                <tr>
                                    <td style="width: 50%; padding: 10px; text-align: left; vertical-align: top">
                                        <table>
                                            <tr>
                                                <td style="width: 150px">Harga Barang
                                                </td>
                                                <td>:</td>
                                                <td style="padding-left: 10px">
                                                    <%:m.ProductPrice %>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="width: 150px">Harga Package
                                                </td>
                                                <td>:</td>
                                                <td style="padding-left: 10px">
                                                    <%:m.PackagePrice %>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="width: 150px">Harga Giftcard
                                                </td>
                                                <td>:</td>
                                                <td style="padding-left: 10px">
                                                    <%:m.GreetingCardPrice %>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                    <td style="width: 50%; padding: 10px; text-align: left; vertical-align: top">
                                        <table>
                                            <tr>
                                                <td style="width: 200px">Ongkir
                                                </td>
                                                <td>:</td>
                                                <td style="padding-left: 10px">
                                                    <%:m.ShippingFee %>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="width: 200px">Service
                                                </td>
                                                <td>:</td>
                                                <td style="padding-left: 10px">
                                                    <%:m.ServiceFee %>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="width: 200px">Discount Voucher
                                                </td>
                                                <td>:</td>
                                                <td style="padding-left: 10px">
                                                    <%:m.DiscountVoucherPrice %>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>

                        </div>
                    </div>
                    <div>
                        <table>
                            <tr>
                                <%--<td style="padding: 15px 15px 15px 0px; width:150px">
                                    <button id="<%:m.Id %>" type="button" class="btn btn-default btn-lg btn-block btn-login" onclick="confirm_onClick('<%:m.Id %>')">Konfirmasi </button> 
                                </td>--%>
                                <%if(m.Status == pickkado.Front.TransactionStatus.CompletedAdmin&&m.UserId==userLogin.Id ){ %>
                                <td style="padding: 15px;padding-left:0px;">
                                    <button id="confirmDestination" type="button" class="btn btn-default btn-lg btn-block btn-login" onclick="confirmDestination_onClick('<%:m.Id %>')">Konfirmasi Penerimaan Kado</button> 
                                </td>
                                <%} %>
                                <%if(m.IsGroup) { %>
                                <td style="padding: 15px 15px 15px 0px;">
                                    <button id="Button1" type="button" class="btn btn-default btn-lg btn-block btn-login" onclick="detailPatungan_onClick('<%:m.Id %>')">Detail Patungan </button> 
                                </td>
                                <td style="padding: 15px 0px 15px 0px;">
                                    <button id="Button2" type="button" class="btn btn-default btn-lg btn-block btn-login" onclick="detailGiftcard_onClick('<%:m.Id %>')">Detail Giftcard </button> 
                                </td>
                                <%} %>
                            </tr>
                        </table>
                    </div>
                    
                    

                </div>

            </div>
                    
            <% } %>
        </div>
    </div>
    <% } else {%>
        <div style="background-color:#F5F7F6; text-align:center; padding:20px; margin-top:5px" class="font-avant">
            Tidak ada pembelian yang sedang dalam proses
        </div>
    <% } %>
</div>

<script type="text/javascript">
    
    function confirmDestination_onClick(transId) {
        $.ajax({
            type: "POST",
            url: '<%:Url.Action("index", "profile")%>',
            data: $.param({ "transId": transId }) + '&' + $.param({ "status": true }),
            success: function (result) {
                location.reload();
            }, error: function (err) {
                alert(err.statusText);
            }
        });
    }
</script>
