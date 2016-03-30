﻿<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<pickkado.Front.Models.DetailPatunganViewModel>" %>

<div style="position: fixed; background-color: rgba(10,10,10,0.6); top: 0; bottom: 0; width: 100%; height: 100%; left: 0; right: 0; z-index: 1100;">
    <div style="position: relative; width: 820px; height: 560px; background-color: white; margin: auto; transform: translateY(-50%); top: 50%;">
        <img src="../../Images/icon/close.png" style="position: absolute; top: -14px; right: -14px; cursor: pointer" id="btn-close" />

        <div style="width: auto; height: auto; padding: 20px">
            <div class="container-fluid title-underline" style="margin-bottom:40px">
                <span class="font-avant" style="font-size: 15px">
                    Detail Patungan
                </span>
            </div>
            <div class="container-fluid" style="margin-bottom:30px; ">
                <div class="row" style="margin-bottom:20px">
                    <div class="col-md-6">
                        <div style="border:1px solid #CECCCC; padding:15px 10px;" >    
                            BATAS WAKTU PELUNASAN : <%:Model.BatasWaktuPelunasan.ToString("dd MMMM yyyy") %>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div style="border:1px solid #CECCCC; padding:15px 10px">
                            TOTAL PEMBAYARAN : Rp <%:Model.TotalPembayaran %>
                        </div>
                    </div>
                </div>
                <div class="row" style="background-color:#5DB194; color:white; margin:0px; padding:15px 0px">
                    <div class="col-md-6">
                        <strong >
                            PEMBAYARAN YANG TERKUMPUL : 
                        </strong>
                    </div>
                    <div class="col-md-6">
                        <strong style="padding:0px 15px">
                            Rp <%:Model.PembayaranYangTerkumpul %>
                        </strong>
                    </div>
                </div>
            </div>
            <div class="container-fluid">
                <div class="font-avant" style="font-size: 18px; padding-left:10px; margin-bottom:10px">
                    Status Pembayaran
                </div>
                <div style="max-height:250px; overflow:auto">
                <table class="table tableBrownNavy">
                    <tbody>
                        <%for (int i = 0; i < Model.StatusPembayaran.Count; i++)
			            {%>
			                <tr>
                                <td>
                                    <%:Model.StatusPembayaran[i].Name %>
                                </td>
                                <td>
                                    <strong>
                                        <%:Model.StatusPembayaran[i].Status %>
                                    </strong>
                                </td>
                                <td>
                                    <span style="float:right">
                                        Rp <%:Model.StatusPembayaran[i].JumlahPembayaran %>
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
        </div>
    </div>
</div>


<script>
    $('#btn-close').click(function () {
        $("#popup").html('');
    });
</script>