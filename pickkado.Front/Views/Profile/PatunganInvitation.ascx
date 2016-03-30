<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<dynamic>" %>

<div style="padding: 50px; margin-left: 120px">


    <div class="container-fluid title-underline">
        <span></span>
    </div>
    <div style="max-height: 2500px; overflow: auto">
        <%var userLogin = (pickkado.Entities.User)TempData["UserLogin"]; %>
        
        <%var InvitationList = (List<pickkado.Front.Models.PatunganInvitationViewModel>)TempData["PatunganInvitationList"]; %>
        <%if(InvitationList.Count > 0) { %>
            <%foreach (var m in InvitationList)
            { %>
                <div>
                    <div style="border: 1px solid #363737; height: 120px; padding: 10px; background-color: white">
                        <div style="width:120px; height:100px; float:left;">
                            <%if(m.UserImage == null) { %>
                                <div class="square">
                                    <img src="../../../../Images/no-thumb.png" class="img-circle" style="height:100px; display:block; margin:0 auto"/>
                                </div>
                            <%} else {%>
                                <div class="square">
                                    <img src="data:image;base64,<%:System.Convert.ToBase64String(m.UserImage) %>" class="img-circle" style="height:100px; display:block; margin:0 auto"/>
                                </div>
                            <%} %>
                        </div>
                        <div>
                            <%:m.UserName %>
                        </div>
                        <table>
                            <tr>
                                <td>
                                    
                                    <%:m.TransDate.ToString("dd/MM/yyyy") %>
                                </td>
                                <td style="width: 700px; text-align: center">
                                    <%:m.PatunganTitle %>
                                </td>
                            </tr>
                        </table>

                        <div style="float: right; padding-right: 20px">
                            <a id="show<%:m.TransId %>" data-toggle="collapse" data-target="#divshow<%:m.TransId %>" onclick="show_onClick(this.id)">Tampilkan
                            </a>
                        </div>
                    </div>
                    <div id="divshow<%:m.TransId %>" class="collapse">
                        <div>
                            <div style="border: 1px solid #363737; padding: 10px">
                                <div class="container-fluid title-underline" style="text-align:center; margin:0px 25px">
                                    <span class="font-avant" style="font-size: 15px;">Hi <%:userLogin.FirstName %>, kamu telah diundang <%:m.UserName %> untuk patungan bersama.
                                    </span>
                                </div>
                                <div class="container-fluid">
                                    <div class="row" style="background-color:#DAD1C6; margin:20px 40px">
                                        <div class="font-helvetica" style="text-align:center; padding:15px; ">
                                            <%:m.PatunganTitle %>
                                        </div>
                                        <div class="font-avant" style="text-align:center; padding:15px">
                                            <%:m.ProductName %>
                                        </div>
                                        <div class="square" style="text-align:center; padding:15px;">
                                            <img src="data:image;base64,<%:System.Convert.ToBase64String(m.ProductImage) %>" style="width:300px; padding:10px; border:2px solid white" />
                                        </div>
                                        <div class="font-helvetica" style="text-align:center; padding:30px 15px;">
                                            <%:m.PatunganDescription %>
                                        </div>
                                    </div>
                                    <div class="row" style="margin-bottom:20px; padding:20px 40px">
                                        <div class="col-md-6">
                                            <div style="border:1px solid #CECCCC; padding:15px 10px;" >    
                                                BATAS WAKTU PELUNASAN : <%:m.BatasWaktuPelunasan.ToString("dd MMMM yyyy") %>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div style="border:1px solid #CECCCC; padding:15px 10px">
                                                TOTAL PEMBAYARAN : Rp <%:m.TotalPembayaran %>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row" style="margin:20px 100px">
                                        <div class="font-avant" style="font-size: 18px; padding-left:10px; margin-bottom:10px">
                                            Invitation Status
                                        </div>
                                        <table class="table tableBrownNavy" >
                                            <tbody>
                                                <%for (int i = 0; i < m.Status.Count; i++)
                                                  { %>
                                                    <tr>
                                                        <td>
                                                            <%if(userLogin.Id == m.Status[i].UserId) {%>
                                                                You
                                                            <%} else { %>
                                                                <%:m.Status[i].Name %>
                                                            <%} %>
                                                        </td>
                                                        <td>
                                                            <strong>
                                                                <%:m.Status[i].Status %>
                                                            </strong>
                                                        </td>
                                                    </tr>      
                                                <%} %>
                                            
                                            </tbody>
                                        </table>
                                    </div>
                                    <div class="row">
                                        <div>
                                            <table style="margin:auto">
                                                <tr>
                                                    <td>
                                                        <div style="padding: 15px 0px 15px 0px; width:200px; margin:0px 5px">
                                                            <button type="button" class="btn btn-default btn-lg btn-block btn-login" >Join</button>
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <div style="padding: 15px 0px 15px 0px; width:200px; margin:0px 5px">
                                                            <button type="button" class="btn btn-default btn-lg btn-block btn-danger" >Reject</button>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </table>
                                    
                                    
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            <%} %>
        <%} else { %>
            <div style="background-color:#F5F7F6; text-align:center; padding:20px; margin-top:5px" class="font-avant">
                Tidak Ada Patungan Invitation
            </div>
        <%} %>
    </div>
</div>

<script type="text/javascript">
    //function show_onClick(transId) {
    //    var btnShow = document.getElementById('show' + transId);

    //    if ($('#div' + transId).hasClass('collapsing') == false) {
    //        if ($('#div' + transId).hasClass('in')) {
    //            btnShow.text = "Tampilkan";
    //        } else {
    //            btnShow.text = "Sembunyikan";
    //        }
    //    }
    //}

    function show_onClick(transId) {
        var btnShow = document.getElementById(transId);

        if ($('#div' + transId).hasClass('collapsing') == false) {
            if ($('#div' + transId).hasClass('in')) {
                btnShow.text = "Tampilkan";
            } else {
                btnShow.text = "Sembunyikan";
            }
        }
    }
</script>