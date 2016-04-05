<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site1.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="paymentTitle" ContentPlaceHolderID="TitleContent" runat="server">
    Payment Info
</asp:Content>

<asp:Content ID="Content5" ContentPlaceHolderID="breadcumb" runat="server">
    <li><a href="/">Home</a></li>
    <li>Catalog</li>
    <li><%:ViewBag.ProductName %></li>
    <li>Package & Giftcard</li>
    <li>Input your giftcard message</li>
    <li >Purchase Information </li>
    <li>Review Order</li>
    <li class="active">Your order has been received</li>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="navBar" runat="server">
    <%Html.RenderAction("login_partial","account"); %>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container-fluid title-underline">
        <span class="font-avant" style="font-size:15px">
            YOUR ORDER HAS BEEN RECEIVED
        </span>
    </div>

    <div class="container-fluid" style="padding:15px 0px;">        
        <div style="text-align:center" class="row font-helvetica">
            TERIMA KASIH, ANDA BERHASIL MELAKUKAN ORDER.
        </div>
    </div>
    <%var Transaction = (pickkado.Entities.Transaction)ViewBag.Transaction; %>
    <%if(Transaction.IsGroup) { %>
    <div class="container-fluid" >
        <div class="row font-helvetica" style="text-align:center; padding:15px 0px;">
            Untuk dapat melakukan konfirmasi pembayaran, Anda harus menunggu semua teman undangan merespon
        </div>
        <div class="row">
            <div style="max-height:250px; overflow:auto; width:600px;" class="container-fluid">
                <table class="table tableBrownNavy">
                    <tbody>
                        <%var ListPatunganInvitationStatus = (List<pickkado.Front.Models.PatunganInvitationStatusViewModel>)ViewBag.ListPatunganInvitationStatus; %>
                        <% foreach (var m in ListPatunganInvitationStatus)
			            {%>
			                <tr>
                                <td>
                                    <%:m.Name %>
                                </td>
                                <td>
                                    <strong>
                                        <%:m.Status %>
                                    </strong>
                                </td>
                                <td>
                                    <span style="float:right">
                                        <%:m.PriceToRupiah %>
                                    </span>
                                </td>
                            </tr>    
			          <%} %>
                        <%--<%for (int i = 0; i < 10; i++)
			            {%>
			                <tr>
                                <td>
                                    Name
                                </td>
                                <td>
                                    <strong>
                                        Status
                                    </strong>
                                </td>
                                <td>
                                    <span style="float:right">
                                        Nominal
                                    </span>
                                </td>
                            </tr>    
			          <%} %>--%>
                    </tbody>
                </table>
                </div>
        </div>
        <div class="row font-helvetica" style="text-align:center; margin-bottom:20px; padding:15px 0px;">
            Anda juga dapat melihat status undangan di <a href="/profile">Profile</a> Anda. <br />
        </div>
    </div>
    <%} else {%>
    <div class="container-fluid" style="padding:15px 0px;">        
        <div class="row" >
            <div class="col-md-12" >
                <div class="row border-gray" style="margin:auto; width:500px; text-align:center; padding:25px 0px 25px 0px">
                    <div class="col-md-6 font-helvetica">
                        Jumlah yang harus dibayar
                    </div>
                    <div class="col-md-6 font-helvetica">
                        Rp. <%:ViewBag.TotalHarga %>
                    </div>
                </div>    
            </div>
        </div>
    </div>
    <div class="container-fluid" style="padding:15px 0px;">
        <div class="row">
            <div class="col-lg-12" >
                <div class="row" style="margin:auto; width:230px; text-align:center">
                    <a href="#" style="text-decoration:none">
                        <button id="paymentConfirmation" type="button" class="btn btn-lg btn-block btn-login" > Payment Confirmation </button>
                    </a>
                </div>
                
            </div>
        </div>
    </div>
    <div class="container-fluid" style="padding:15px 0px;">
        <div class="row">
            Proses akan dilanjutkan setelah verifikasi pembayaran, untuk itu ikuti langkah berikut:
        </div>
        <div class="row">
            1. Transfer Jumlah yang harus dibayar ke salah satu rekening PICKKADO.
        </div>
        <div class="row" style="padding:10px">
            <%var ListRekeningPickkado = (List<pickkado.Entities.NoRekeningPickkado>)ViewBag.RekeningPickkadoes; %>
            <%for (int i = 0; i < ListRekeningPickkado.Count; i++)%>
            <%{%>
                <div class="col-md-2" style="border:1px solid #CECCCC; height:200px; margin:0px 7px; padding:15px; font-size:12px">
                    <div>
                        <div style="height:80px; text-align:center; vertical-align:middle">
                        <%if(ListRekeningPickkado[i].Bank.ToLower() == "bca") { %>    
                            <img src="../../Images/BCA.jpg" style="width:130px"/>
                        <%} else if(ListRekeningPickkado[i].Bank.ToLower() == "bni") {%>
                            <img src="../../Images/BNI.jpg" style="width:130px"/>
                        <%} else if(ListRekeningPickkado[i].Bank.ToLower() == "mandiri") {%>
                            <img src="../../Images/Mandiri.jpg" style="width:130px"/>
                        <%} else { %>
                            <img src="../../Images/no-thumb.png" style="width:130px"/>
                        <%} %>
                        </div>
                    </div>
                    <div>
                        Cab. <%:ListRekeningPickkado[i].CabangBank %>
                    </div>
                    <div>
                        No Rek. <%:ListRekeningPickkado[i].NomorRekening %>
                    </div>
                    <div>
                        a/n <%:ListRekeningPickkado[i].AtasNama %>
                    </div>
                </div>                 
            <%} %>
        </div>
        <div class="row">
            2. Setelah melakukan pembayaran harap melakukan <i style="color:#5DB194"><strong>Payment Confirmation.</strong></i> Bila tidak melakukan <i style="color:#5DB194"><strong>Payment Confirmation</strong></i> proses tidak bisa Kami lanjutkan.
        </div>
        <div class="row">
            3. Proses ini akan otomatis dibatalkan jika tidak ada konfirmasi dalam jangka waktu 2 hari.
        </div>
        <div class="row" style="margin:30px 0px 30px 0px; display:none">
            <div class="col-lg-2" style="padding-top:15px; padding-bottom:15px">
                <a href="#" style="text-decoration:none; display:none">
                    <button type="button" class="btn btn-default btn-lg btn-block btn-login"> <img src="../../images/icon/PanahBackIcon.png"/> Back</button>
                </a>
            </div>
        </div>
    </div>
    <%} %>
</asp:Content>

<asp:Content ID="scriptsContent" ContentPlaceHolderID="ScriptsSection" runat="server">
    <%: Scripts.Render("~/bundles/jqueryval") %>
    <script type="text/javascript">
        $('#paymentConfirmation').click(function () {
            ShowPopup('<%:Url.Action("paymentconfirm", "popup", new {transId=ViewContext.RouteData.Values["id"]}%>');
            
        });
    </script>
</asp:Content>