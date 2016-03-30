<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site1.Master" Inherits="System.Web.Mvc.ViewPage<pickkado.Front.Models.PurchaseInformationViewModel>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Purchase Information
</asp:Content>

<asp:Content ID="Content5" ContentPlaceHolderID="breadcumb" runat="server">
    <li><a href="/">Home</a></li>
    <li>Catalog</li>
    <li ><%:ViewBag.ProductName %></li>
    <li>Package & Giftcard</li>
    <li ><a href="<%:ViewBag.LinkBack %>">Input your giftcard message</a> </li>
    <li class="active">Purchase Information</li>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container-fluid">
        <div class="container-fluid title-underline">
            <span class="font-avant">
                Purchase Information
            </span>
        </div>

    <% using (Html.BeginForm())
       { %>
    <%: Html.AntiForgeryToken()%>
        <% if (ViewData.ModelState.Any(x => x.Value.Errors.Any()))
           {%>
                <div id="message" class="alert alert-danger form-message">
                    <a href="#" class="close" data-dismiss="alert">×</a>
                    <%: Html.ValidationSummary("",new { @class = "validation-summary-custom" })%>
                </div>
            <% }%>
        <div class="container-fluid" style="padding:15px 0px;">
            <div class="row">
                <div class="col-lg-12">
                    <div class="form-group form-group-md">
                        <%:Html.TextBoxFor(m=>m.ReceiverName,new{placeholder="RECEIVER NAME*",@class="form-control"}) %>
                    </div>
                </div>
                <div class="col-lg-12">
                    <div class="form-group form-group-md">
                        <%:Html.TextBoxFor(m=>m.DeliveryAddress,new{placeholder="DELIVERY ADDRESS*",@class="form-control"}) %>
                    </div>
                </div>
                <div class="col-lg-12">
                    <div class="form-group form-group-md postalcode">
                        <%Html.RenderPartial("postal_code",Model); %>
                        <%--<div class="col-lg-4">
                            <select id="Kota" name="Kota" class="selectpicker form-control" title="Pilih Kab/Kota...">

                            </select>

                        </div>
                        <div class="col-lg-4">
                            <%:Html.TextBoxFor(m=>m.Kecamatan, new {@class="form-control",placeholder="KECAMATAN"}) %>

                        </div>
                        <div class="col-lg-4">
                            <%:Html.TextBoxFor(m=>m.Kelurahan, new {@class="form-control",placeholder="KELURAHAN"}) %>

                        </div>--%>
                    </div>
                </div>
                <div class="col-lg-12">
                    <div class="form-group form-group-md" style="padding:10px 0px">
                        <%:Html.TextBoxFor(m=>m.PhoneNumber,new{placeholder="YOUR ACTIVE PHONE NUMBER*",@class="form-control"}) %>
                    </div>
                </div>
                <div class="col-lg-12">
                    <div class="form-group form-group-md" id="formTimeReceived">
                        <label class="col-lg-3 control-label" for="formTimeReceived">SEND DATE</label> 
                        
                        <div class="col-lg-3"> 
                            <%
                                var DateList = new List<SelectListItem>();
                                for (int i = 0; i < 32; i++)
                                {
                                    DateList.Add(new SelectListItem
                                    {
                                        Text = i == 0 ? "DATE*" : (i).ToString(),
                                        Value = i.ToString(),
                                        Selected = true
                                    });
                                }
                                var MonthList = new List<SelectListItem>();
                                MonthList.Add(new SelectListItem { Text = "MONTH*", Value = "0", Selected = true });
                                MonthList.Add(new SelectListItem { Text = "January", Value = "1", Selected = false });
                                MonthList.Add(new SelectListItem { Text = "February", Value = "2", Selected = false });
                                MonthList.Add(new SelectListItem { Text = "March", Value = "3", Selected = false });
                                MonthList.Add(new SelectListItem { Text = "April", Value = "4", Selected = false });
                                MonthList.Add(new SelectListItem { Text = "May", Value = "5", Selected = false });
                                MonthList.Add(new SelectListItem { Text = "Juny", Value = "6", Selected = false });
                                MonthList.Add(new SelectListItem { Text = "July", Value = "7", Selected = false });
                                MonthList.Add(new SelectListItem { Text = "August", Value = "8", Selected = false });
                                MonthList.Add(new SelectListItem { Text = "September", Value = "9", Selected = false });
                                MonthList.Add(new SelectListItem { Text = "October", Value = "10", Selected = false });
                                MonthList.Add(new SelectListItem { Text = "November", Value = "11", Selected = false });
                                MonthList.Add(new SelectListItem { Text = "December", Value = "12", Selected = false });
                                var YearList = new List<SelectListItem>();
                                YearList.Add(new SelectListItem { Text = "YEAR*", Value = "0", Selected = true });
                                YearList.Add(new SelectListItem { Text = "2016", Value = "2016", Selected = false });
                                YearList.Add(new SelectListItem { Text = "2017", Value = "2017", Selected = false });
                                YearList.Add(new SelectListItem { Text = "2018", Value = "2018", Selected = false });
                               %>
                            <%:Html.DropDownListFor(m=>m.DateReceive,DateList,new{@class="selectpicker form-control"}) %> 
                        </div>
                        <div class="col-lg-3">  
                            <%:Html.DropDownListFor(m=>m.MonthReceive,MonthList,new{@class="selectpicker form-control"}) %>  
                        </div>
                        <div class="col-lg-3">
                            <%:Html.DropDownListFor(m=>m.YearReceive,YearList,new{@class="selectpicker form-control"}) %>  
                        </div>
                    </div>
                </div>
            </div>
            <div class="container-fluid title-underline" style="padding:15px 0px;">
            </div>
            <div style="padding:15px 0px;">
                <div class="row">
                    <div class="row-height">
                    <div class="col-md-2 col-height">
                        <div class="form-group form-group-md">
                            <label class="control-label">Harga Barang</label> 
                            <%:Html.TextBoxFor(m => m.ProductPrice, new {@class="form-control",disabled="disabled",style="text-align:right;" })%>
                            <%:Html.HiddenFor(m=>m.ProductPrice) %>
                            <%--<input type="text" class="form-control" name="ProductPrice" value="<%:Model.ProductPrice %>" disabled style="text-align:right" />--%>
                        </div>
                    </div>
                    <div class="col-md-1 col-height col-bottom" style="text-align:center;">
                        <h4 style="padding-bottom:10px;">+</h4>
                    </div>
                    <div class="col-md-2 col-height">
                        <div class="form-group form-group-md">
                            <label class="control-label">Harga Package</label> 
                            <%:Html.TextBoxFor(m => m.PackagePrice, new {@class="form-control",disabled="disabled",style="text-align:right;" })%>
                            <%:Html.HiddenFor(m=>m.PackagePrice) %>
                            <%--<input type="text" class="form-control" name="PackagePrice" value="<%:Model.PackagePrice %>" disabled style="text-align:right" />--%>
                        </div>
                    </div>
                    <div class="col-md-1 col-height col-bottom" style="text-align:center">
                        <h4 style="padding-bottom:10px;">+</h4>
                    </div>
                    <div class="col-md-2 col-height">
                        <div class="form-group form-group-md">
                            <label class="control-label">Harga Giftcard</label> 
                            <%:Html.TextBoxFor(m => m.GiftcardPrice, new {@class="form-control",disabled="disabled",style="text-align:right;" })%>
                            <%:Html.HiddenFor(m=>m.GiftcardPrice) %>
                            <%--<input type="text" class="form-control" name="GiftcardPrice" value="<%:Model.GiftcardPrice %>" disabled style="text-align:right" />--%>
                        </div>
                    </div>
                    <div class="col-md-offset-1 col-md-1 col-height col-bottom" style="text-align:center">
                        <h4 style="padding-bottom:10px;">=</h4>
                    </div>
                    <div class="col-md-2 col-height col-bottom" >
                        <div class="form-group form-group-md">
                            <%:Html.TextBoxFor(m => m.SubTotal, new {@class="form-control",disabled="disabled",style="text-align:right;" })%>
                            <%:Html.HiddenFor(m=>m.SubTotal) %>
                            <%--<input type="text" class="form-control" value="<%:Model.SubTotal %>" disabled style="text-align:right;" />--%>
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
                        <div class="col-xs-6 col-lg-offset-3 col-lg-5">
                            <div class="input-group">
                                <span class="input-group-addon">
                                <input type="checkbox" aria-label="...">
                                </span>
                                <select class="form-control">
                                    <option>
                                        VOUCHER ID (Enter your voucher id if you have)*
                                    </option>
                                </select>
                            </div>
                        </div>
                        <div class="col-xs-6 col-lg-offset-2 col-lg-2">
                            <div class="form-group form-group-md">
                                <input type="text" id="VoucherPrice" class="form-control" value="Rp. 0" disabled style="text-align:right" />
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="row-height">
                        <div class="col-lg-offset-8 col-lg-4" style="border-bottom:1px solid #cecccc;margin-bottom:10px;"></div>
                    </div>
                </div>
                <div class="row">
                    <div class="row-height">
                        <div class="col-lg-8 col-height col-middle">
                        </div>
                        <div class="col-lg-offset-8 col-lg-2 col-height col-middle">
                            Jumlah
                        </div>
                        <div class="col-lg-2 col-height">
                            <div class="form-group form-group-md col-height">
                                <input type="text" class="form-control" id="jumlah" value="" disabled style="text-align:right" />
                            </div>
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
                            <div class="form-group form-group-md col-height">
                                <input type="text" id="ServiceFee" class="form-control" value="Rp. 30.000" disabled style="text-align:right" />
                            </div>
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
                                <%:Html.TextBoxFor(m => m.NamaKurir, new {@class="form-control",disabled="disabled"})%>
                                <%:Html.HiddenFor(m=>m.NamaKurir) %>
                            </div>
                        </div>
                        <div class="col-lg-2 col-height ">
                            <div class="form-group form-group-md">
                                <label class="control-label">Jenis Pengiriman</label> 
                                <select class="selectpicker form-control" title="Jenis Pengiriman..." name="JenisPaket" id="JenisPaket">
                                    <option value="REG" <%:Model.JenisPaket!=null&&Model.JenisPaket=="REG"?"selected":"" %>>Reguler</option>
                                    <option value="YES" <%:Model.JenisPaket!=null&&Model.JenisPaket=="YES"?"selected":"" %>>YES</option>
                                </select>
                            </div>
                        </div>
                        <div class="col-lg-2  col-height ">
                            <div class="form-group form-group-md">
                                <label class="control-label">Asuransi</label>
                                <select class="selectpicker form-control" title="Asuransi..." name="AsuransiPaket">
                                    <option selected>No</option>
                                    <option disabled>Yes</option>
                                </select> 
                            </div>
                        </div>
                        <div class="col-lg-2 col-height col-middle">Biaya Kirim</div>
                        <div class="col-lg-2  col-height">
                            <div class="form-group form-group-md">
                                <label class="control-label"></label>
                                <%:Html.TextBoxFor(m => m.BiayaKirim, new {@class="form-control",disabled="disabled",style="text-align:right" })%>
                                <%:Html.HiddenFor(m=>m.BiayaKirim) %>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="row-height">
                        <div class="col-lg-offset-8 col-lg-4" style="border-bottom:1px solid #cecccc;margin-bottom:10px;"></div>
                    </div>
                </div>
                <div class="row">
                    <div class="row-height"> 
                        <div class="col-lg-8"></div>               
                        <div class="col-lg-2 col-height col-middle">
                            TOTAL
                        </div>
                        <div class="col-lg-2 col-height col-middle">
                            <div class="form-group form-group-md col-height">
                                <%:Html.TextBoxFor(m => m.Total, new {@class="form-control",disabled="disabled",style="text-align:right" })%>
                                <%:Html.HiddenFor(m=>m.Total) %>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="container-fluid title-underline" style="padding:15px 0px;">
            </div>
            <div class="row">
                <div class="col-lg-12">
                    <h4>Bayar patungan dengan teman-teman anda ? 
                        <span style="margin:0px 10px 0px 20px" data-toggle="collapse" data-target="#divPatungan">
                            <%:Html.CheckBoxFor(a => a.IsPatungan)%>
                            <%:Html.HiddenFor(a=>a.IsPatungan, new {id="hiddenIsPatungan" }) %>
                        </span>
                        Ya
                        <%--<input type="checkbox" style="margin:0px 10px 0px 20px" data-toggle="collapse" data-target="#divPatungan" name="IsPatungan"/>Ya--%>
                    </h4>
                </div>
            </div>
            <div id="divPatungan" class="collapse">
                <div class="row">
                    <div class="col-lg-6">
                        <div class="form-group form-group-md">
                            <label style="padding:5px">Title</label>
                            <%:Html.TextBoxFor(m => m.PatunganTitle, new { placeholder = "Peristiwa apa yang terjadi contoh ulang tahun*", @class = "form-control" })%>
                        </div>
                    </div>
                    <div class="col-lg-6">
                        <div class="form-group form-group-md">
                            <label style="padding:5px">Penerima Kado</label>
                            <%:Html.TextBoxFor(m=>m.PatunganPenerimaKado,new{placeholder="Kado ini ditujukan untuk..*",@class="form-control"}) %>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-12">
                        <div class="form-group form-group-md">
                            <label style="padding:5px">Deskripsi</label>
                            <%:Html.TextAreaFor(m=>m.PatunganDeskripsi,new{placeholder="Apa yang ingin dikatakan pada teman-temanmu*",@class="form-control"}) %>
                        </div>
                    </div>
                </div>
                <div class="row" style="padding:10px 0px">
                    <div class="col-lg-12">
                        MASUKKAN DATA TEMAN-TEMAN ANDA
                    </div>
                </div>
                <div style="width:100%">
                    <table id="tableInvite" class="table" >
                        <tbody id="inviteContent">
                         <%if(Model!=null&&Model.PatunganFriends!=null){
                           for (int i = 0; i < Model.PatunganFriends.Count; i++)
                          {%> 
                            <tr>
                                <td>
                                    <%:Html.TextBox("PatunganFriends["+i+"].Name",Model.PatunganFriends[i].Name,new{@class="form-control",style="width:100%",placeholder="NAMA"} )%>
                                </td>
                                <td>
                                    <%:Html.TextBox("PatunganFriends["+i+"].Email",Model.PatunganFriends[i].Email,new{@class="form-control",style="width:100%",placeholder="EMAIL"} )%>
                                </td>
                                <td style="vertical-align:middle">
                                    <%if (i > 1) {%>
                                        <button type="button" style="background-color:transparent; background-repeat:no-repeat; border:none" onclick="removeRow(this)">
                                            <span class="glyphicon glyphicon-remove-sign" aria-hidden="true" style="font-size:20px; color:#C4021A"></span>
                                        </button>
                                    <%} %>
                                </td>
                            </tr>
                            
                          <%}
                    } %>
                        </tbody>
                        <tfoot>
                            <tr>
                                <td></td>
                                <td></td>
                                <td><div class="btn btn-default" style="background-color:#DAD1C6; color:white" onclick="addRow()"> <span class="glyphicon glyphicon-plus"></span> <strong>Add More</strong></div></td>
                            </tr>
                        </tfoot>
                    </table>
                </div>
                <div class="row" style="padding:10px 0px">
                    <div class="col-lg-6">
                        TOTAL
                    </div>
                    <div class="col-lg-6">
                        <label id="totalHargaInvite">250000</label>
                    </div>
                </div>
                <div class="row" style="padding:10px 0px">
                    <div class="col-lg-6">
                        JUMLAH YANG HARUS DIBAYAR PERORANG
                    </div>
                    <div class="col-lg-6">
                        <label id="totalHargaPerorang">125000</label>
                    </div>
                </div>
            </div>
        </div>
        <div class="container-fluid" style="padding:15px 0px;">            
            <div class="row" style="margin:30px 0px;">
                <div class="col-xm-2 col-sm-2 col-md-2 col-lg-2">
                    <a href="<%:(string)ViewBag.LinkBack %>" class="btn btn-block btn-lg btn-login">
                        <img src="../../Images/icon/PanahBackIcon.png" class="lefticon" />
                        Back
                    </a>                    
                </div>
                <div class="col-xm-offset-7 col-xm-3 col-sm-offset-7 col-sm-3 col-md-offset-7 col-md-3 col-lg-offset-7 col-lg-3">
                    <button type="submit" class="btn btn-block btn-lg btn-login">
                        Confirm
                    </button>                    
                </div>
            </div>
        </div>
        <%} %>
    </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="navBar" runat="server">
    <%Html.RenderAction("login_partial","account"); %>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ScriptsSection" runat="server">
    <script src="../../Scripts/convert-rupiah.js"></script>
    <script>
        $(function () {
            return $('.selectpicker').selectpicker({
                style: 'btn-default',
                size: 8,
                liveSearch: "true"
            });
        });
       
        $(document).ready(function () {
            if ($('#IsPatungan').prop("checked") == true) {
                $('#divPatungan').addClass("in");
            }
            //$.get("/payment/GetCity").done(function (data) {
            //    console.log(data);
            //});
            //$.getJSON("//localhost:8080/api/ongkir/city.php", function (data) {
            //    alert(data);
            //});
            //$.ajax({
            //    type: "GET",
            //    url: "http://localhost:8080/api/ongkir/city.php",
            //    dataType: "json"
            //}).done(function (data) {
            //    if (data.rajaongkir.status.code == 200)
            //    {
            //        //alert(data.rajaongkir.results.length);
            //        var list = data.rajaongkir.results;
            //        var ddl = $('#Kota');
            //        alert(ddl.val());
            //        for (var i = 0; i < list.length; i++)
            //        {
            //            var row = '<option value="'+list[i].city_id+'/'+list[i].city_name+'">'+list[i].city_name+', '+list[i].province+'</option>';
            //            ddl.append(row);
            //        }
            //        $('#Kota.selectpicker').selectpicker('refresh');
            //    }
            //    console.log(data);
            //});
            $('#JenisPaket').change(function () {
                var getValues = $('#ddlCity').val();
                var service = $(this).val();
                if (getValues != "") {
                    //var value = getValues.split('/');
                    Cost(getValues, 1000, service);
                }
            });
            function Cost(id, berat, serviceType)
            {
                //alert('function cost '+id);
                $.ajax({
                    type: "GET",
                    url: 'http://localhost:8081/api/ongkir/cost.php?destination=' + id + '&weight=' + berat + '&courier=jne&service=' + serviceType,
                    dataType: "json"
                }).done(function (data) {
                    if (data.rajaongkir.status.code == 200) {
                        var results = data.rajaongkir.results;
                        if (results.length > 0)
                        {
                            if (results[0].costs.length > 0) {
                                console.log(results[0].costs[0].cost[0].value);
                                $('input[name="BiayaKirim"]').val(convertToRupiah(results[0].costs[0].cost[0].value));
                                calculate();
                            }
                        }
                    }
                    else
                        alert(data.rajaongkir.status.description);
                });
            }
            //$.ajax({
            //    type: "GET",
            //    url: 'http://localhost:8080/api/ongkir/city.php',
            //    contentType: 'application/x-www-form-urlencoded',
            //    crossDomain: true,
            //    beforeSend: function (request)
            //    {
            //        request.setRequestHeader("Access-Control-Allow-Origin", "*");
            //    },
            //    success: function (result) {
            //        console.log(result);
            //    },
            //    error: function (err) {
            //        alert(err.statusText);
            //    }
            //});
            calculate();
            var count = $('#tableInvite tbody tr').length;
            if (count == 0) {
                var row = '<tr><td>\
                                <input type="text" class="form-control" placeholder="NAMA" style="width:100%" name="PatunganFriends[0].Name"/>\
                            </td>\
                            <td>\
                                <input type="text" class="form-control" placeholder="EMAIL" style="width:100%" name="PatunganFriends[0].Email"/>\
                            </td>\
                            <td style="vertical-align:middle">\
                            </td></tr>';
                $('#tableInvite tbody').append(row);
            }
            splitBill();
        });
        function calculate() {
            var jumlah = convertToAngka($('#SubTotal').val()) - convertToAngka($('#VoucherPrice').val());
            var total = jumlah + convertToAngka($('#ServiceFee').val()) + convertToAngka($('#BiayaKirim').val());
            $('#jumlah').val(convertToRupiah(jumlah));
            $('input[name=Total]').val(convertToRupiah(total));
            $('#totalHargaInvite').html(convertToRupiah(total));

        };
        function addRow() {
            var tr = document.createElement('tr');

            var lastRow = $('#tableInvite tbody tr:last');
            var canAddRow = true;
            cannotAddRow = lastRow.children().find('input[type="text"]').each(function () {
                if ($(this).val() == "") {
                    alert("Please fulfill your friend's name and email before.");
                    canAddRow = false;
                    return false;
                }
            });
            if (canAddRow) {
                //div.className = "row";
                var table = document.getElementById('tableInvite');
                tr.innerHTML =
                                '<td>\
                                <input type="text" class="form-control" placeholder="NAMA" style="width:100%" name="PatunganFriends[' + (table.rows.length - 1) + '].Name"/>\
                            </td>\
                            <td>\
                                <input type="text" class="form-control" placeholder="EMAIL" style="width:100%" name="PatunganFriends[' + (table.rows.length - 1) + '].Email"/>\
                            </td>\
                            <td style="vertical-align:middle">\
                                <button type="button" style="background-color:transparent; background-repeat:no-repeat; border:none" onclick="removeRow(this)">\
                                    <span class="glyphicon glyphicon-remove-sign" aria-hidden="true" style="font-size:20px; color:#C4021A"></span>\
                                </button>\
                            </td>';

                document.getElementById('inviteContent').appendChild(tr);

                splitBill();
            }
        }

        function removeRow(input) {
            var table = document.getElementById('tableInvite');

            var rowIndex = input.parentNode.parentNode.rowIndex;
            if (rowIndex + 1 != table.rows.length - 1) {
                //alert('a');
                for (var i = rowIndex + 1; i < table.rows.length - 1; i++) {
                    table.rows[i].cells[0].getElementsByTagName('input')[0].name = 'PatunganFriends[' + (i - 1) + '].Name'
                    table.rows[i].cells[1].getElementsByTagName('input')[0].name = 'PatunganFriends[' + (i - 1) + '].Email'
                }
            }

            document.getElementById('inviteContent').removeChild(input.parentNode.parentNode);

            splitBill();
        }

        function splitBill() {
            var total = convertToAngka(totalHargaInvite.innerHTML);
            var tableLength = document.getElementById('tableInvite').rows.length;
            totalHargaPerorang.innerHTML = convertToRupiah(Math.ceil(total / tableLength));
        }
    </script>
</asp:Content>
