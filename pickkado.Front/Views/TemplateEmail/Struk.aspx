<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<!DOCTYPE html>

<html>
<head id="Head1" runat="server">
    <meta name="viewport" content="width=device-width" />
    <title>Struk</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" >
</head>
<body style="color:black; font-size:15px;">
<font face="Helvetica, Arial, sans-serif">

<div class="container-fluid" style="padding:0;">
    <div style="width:600px; margin:auto;">
        
        <div style="background-color:#5db194; width:100%;" >
            <div style="width:300px; margin:auto;">
                <img src="http://pickkado.somee.com/Images/icon/brand.png" style="width:300px;" />

            </div>
        </div>
    
    <div style="background-color: #ece8d4; padding:30px;">
            <strong>Hai user,</strong>
                <br />
                <br />
                <p>Terima kasih telah melakukan pemesanan kado di pickkado.com. Berikut detail transaksinya: 
                </p>
                <br />
            <table style="width:100%;margin-bottom:10px" >
                <tr>
                    <td style="padding:5px; font-weight:bold;">No. Transaksi</td>
                    <td style="padding:5px; font-weight:bold;">TR0001</td>
                </tr>
                <tr>
                    <td style="padding:5px">Product</td>
                    <td style="padding:5px">Nike mercurial</td>
                </tr>
                <tr>
                    <td style="padding:5px">Tanggal Pengiriman</td>
                    <td style="padding:5px">20 Agustus 2016</td>
                </tr>
                <tr>
                    <td style="padding:5px">Patungan</td>
                    <td style="padding:5px">Tidak</td>
                </tr>
            </table>
            <table style="width:100%;" >
                <thead>
                    <tr>
                        <td colspan="2" style="text-align:center;padding:5px"><strong>Informasi Tagihan</strong></td>
                    </tr>
                </thead>
                <tr style="border-top:1px solid rgba(255, 255, 255,1)">
                    <td style="padding:5px">Total Product</td>
                    <td style="padding:5px; text-align:right;font-size:15px;font-weight:bold"> Rp. 100.000</td>
                </tr>
                <tr style="border-top:1px solid rgba(255, 255, 255,1)">
                    <td style="padding:5px">Total Giftcard</td>
                    <td style="padding:5px; text-align:right;font-size:15px;font-weight:bold"> Rp. 10.000</td>
                </tr>
                <tr style="border-top:1px solid rgba(255, 255, 255,1)">
                    <td style="padding:5px">Total Package</td>
                    <td style="padding:5px; text-align:right;font-size:15px;font-weight:bold"> Rp. 50.000</td>
                </tr>
                <tr style="border-top:1px solid rgba(255, 255, 255,1)">
                    <td style="padding:5px">Ongkos Kirim</td>
                    <td style="padding:5px; text-align:right;font-size:15px;font-weight:bold"> Rp. 11.000</td>
                </tr>
                <tr style="border-top:1px solid rgba(255, 255, 255,1)">
                    <td style="padding:5px">Service Fee</td>
                    <td style="padding:5px; text-align:right;font-size:15px;font-weight:bold"> Rp. 30.000</td>
                </tr>
                <tr style="border-top:1px solid rgba(255, 255, 255,1)">
                    <td style="padding:5px; text-align:right;font-size:18px;font-weight:bold">TOTAL</td>
                    <td style="padding:5px; text-align:right;font-size:18px;font-weight:bold"> Rp. 201.000</td>
                </tr>
            </table>
            <p style="margin-top:10px;">
                Silahkan lakukan konfirmasi pembayaran pada halaman unconfirm payment di profil Anda paling lambat tanggal <strong>20 Agustus 2016</strong>
                jika melewati batas tersebut transaksi akan otomatis dibatalkan.
            </p>
            <p>
                Catatan: Sebelum melakukan konfirmasi pembayaran, pastikan Anda sudah melakukan pembayaran ke salah satu rekening Pickkado.
            </p>
            <br/>
            <div style="margin:30px 0px;">
                <strong>Terima Kasih,</strong>
                <br/>
                <br/>
                <p>pickkado's Team</p>
            </div>
            <div style="border-top:1px solid gray;padding:10px 0px; font-size:12px">
                Untuk melakukan konfirmasi pembayaran anda dapat lihat pada halaman <span style="color:#5db194; font-weight:bold">Unconfirm Payment</span> pada profil anda.<br />                
                Lihat sejarah transaksi anda pada halaman <span style="color:#5db194; font-weight:bold">History Purhcase</span> pada profil anda.<br />
            </div>
        </div>
        <footer>
            Sent from pickkado.com
        </footer>
    </div>
</div>
</body>
</html>

