<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<dynamic>" %>

<div style="padding: 50px; margin-left: 120px">
    <%var userLogin = (pickkado.Entities.User)TempData["UserLogin"]; %>
    <div id="tabs">
        <ul class="nav nav-tabs">
            <li role="presentation" class="active"><a href="#giftcard" style="outline:none" aria-controls="giftcard" role="tab" data-toggle="tab">Giftcard</a></li>
            <li role="presentation" ><a href="#patungan" style="outline:none" aria-controls="patungan" role="tab" data-toggle="tab">Patungan</a></li>
        </ul>
        <div class="tab-content">
            <div role="tabpanel" class="tab-pane fade in active" id="giftcard">
                <div style="max-height: 2500px; overflow: auto">

                    <%var GiftCardList = (List<pickkado.Front.Models.InvitationGiftCardViewModel>)TempData["GiftCardInvitationList"]; %>
                    <%if (GiftCardList.Count > 0)
                      { %>
                    <%foreach (var m in GiftCardList)
                      { %>
                    <div>
                        <div style="border: 1px solid #363737; height: 120px; padding: 10px; background-color: white">
                            <div style="width: 120px; height: 100px; float: left;">
                                <%if (m.UserImage == null)
                                  { %>
                                <div class="square">
                                    <img src="../../../../Images/no-thumb.png" class="img-circle" style="height: 100px; display: block; margin: 0 auto" />
                                </div>
                                <%}
                                  else
                                  {%>
                                <div class="square">
                                    <img src="data:image;base64,<%:System.Convert.ToBase64String(m.UserImage) %>" class="img-circle" style="height: 100px; display: block; margin: 0 auto" />
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
                                    <%--<td style="width: 700px; text-align: center">
                                        <%:m.PatunganTitle %>
                                    </td>--%>
                                </tr>
                            </table>

                            <div style="float: right; padding-right: 20px">
                                <a id="showgift<%:m.TransactionGiftcardMessage.Id %>" data-toggle="collapse" data-target="#divshowgift<%:m.TransactionGiftcardMessage.Id %>" onclick="show_onClick(this.id)">Tampilkan
                                </a>
                            </div>
                        </div>
                        <div id="divshowgift<%:m.TransactionGiftcardMessage.Id %>" class="collapse">
                            <div>
                                <div style="border: 1px solid #363737; padding: 10px">
                                    <div class="container-fluid title-underline" style="text-align: center; margin: 0px 25px; margin-bottom: 20px">
                                        <span class="font-avant" style="font-size: 15px;">Hi <%:userLogin.FirstName %>, kamu telah diundang <%:m.UserName %> untuk menulis ucapan dikartu ucapan
                                        </span>
                                    </div>
                                    <div class="container-fluid">
                                        <div class="row">
                                            <div class="col-md-12">
                                                <textarea class="form-control giftcardmessage" rows="5" placeholder="TYPE YOUR WORDS FOR THE GIFT CARD*" ></textarea>
                                            </div>

                                        </div>
                                        <div class="row">
                                            <div style="padding: 15px 0px 15px 0px; width: 200px; margin: 0px 10px; float: right">
                                                <button type="button" class="btn btn-default btn-submit-giftcard btn-lg btn-block btn-login" data-bind="<%:m.TransactionGiftcardMessage.Id %>">Submit</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <%} %>
                    <%}
                      else
                      { %>
                    <div style="background-color: #F5F7F6; text-align: center; padding: 20px; margin-top: 5px" class="font-avant">
                        Tidak Ada Giftcard Invitation
                    </div>
                    <%} %>
                </div>
            </div>
            <div role="tabpanel" class="tab-pane fade" id="patungan">
                <div style="max-height: 2500px; overflow: auto">
                    <%string myStatus = ""; %>
                    <%var InvitationList = (List<pickkado.Front.Models.PatunganInvitationViewModel>)TempData["PatunganInvitationList"]; %>
                    <%if (InvitationList.Count > 0)
                      { %>
                    <%foreach (var m in InvitationList)
                      { %>
                    <div>
                        <div style="border: 1px solid #363737; height: 120px; padding: 10px; background-color: white">
                            <div style="width: 120px; height: 100px; float: left;">
                                <%if (m.UserImage == null)
                                  { %>
                                <div class="square">
                                    <img src="../../../../Images/no-thumb.png" class="img-circle" style="height: 100px; display: block; margin: 0 auto" />
                                </div>
                                <%}
                                  else
                                  {%>
                                <div class="square">
                                    <img src="data:image;base64,<%:System.Convert.ToBase64String(m.UserImage) %>" class="img-circle" style="height: 100px; display: block; margin: 0 auto" />
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
                                    <div class="container-fluid title-underline" style="text-align: center; margin: 0px 25px">
                                        <span class="font-avant" style="font-size: 15px;">Hi <%:userLogin.FirstName %>, kamu telah diundang <%:m.UserName %> untuk patungan bersama.
                                        </span>
                                    </div>
                                    <div class="container-fluid">
                                        <div class="row" style="background-color: #DAD1C6; margin: 20px 40px">
                                            <div class="font-helvetica" style="text-align: center; padding: 15px;">
                                                <%:m.PatunganTitle %>
                                            </div>
                                            <div class="font-avant" style="text-align: center; padding: 15px">
                                                <%:m.ProductName %>
                                            </div>
                                            <div class="square" style="text-align: center; padding: 15px;">
                                                <img src="data:image;base64,<%:System.Convert.ToBase64String(m.ProductImage) %>" style="width: 300px; padding: 10px; border: 2px solid white" />
                                            </div>
                                            <div class="font-helvetica" style="text-align: center; padding: 30px 15px;">
                                                <%:m.PatunganDescription %>
                                            </div>
                                        </div>
                                        <div class="row" style="margin-bottom: 20px; padding: 20px 40px">
                                            <div class="col-md-6">
                                                <div style="border: 1px solid #CECCCC; padding: 15px 10px;">
                                                    BATAS WAKTU PELUNASAN : <%:m.BatasWaktuPelunasan.ToString("dd MMMM yyyy") %>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div style="border: 1px solid #CECCCC; padding: 15px 10px">
                                                    TOTAL PEMBAYARAN : Rp <%:m.TotalPembayaran %>
                                                </div>
                                            </div>
                                        </div>
                                        <%string tmgId = ""; %>
                                        
                                        <div class="row" style="margin: 20px 100px">
                                            <div class="font-avant" style="font-size: 18px; padding-left: 10px; margin-bottom: 10px">
                                                Invitation Status
                                            </div>
                                            <table class="table tableBrownNavy friendlist">
                                                <tbody>
                                                    <%for (int i = 0; i < m.Status.Count; i++)
                                                      { %>
                                                    <tr>
                                                        <td class="friendname">
                                                            <%if (userLogin.Id == m.Status[i].UserId || userLogin.Email == m.Status[i].Email)
                                                              {%>
                                                                    You
                                                                <% tmgId = m.Status[i].TransactionMemberGroupsId; %>
                                                                <% myStatus = m.Status[i].Status; %>
                                                                <input type="hidden" class="me"/>
                                                            <%}
                                                              else
                                                              { %>
                                                            <%:m.Status[i].Name %>
                                                            <%} %>
                                                        </td>
                                                        <td class="friendstatus" style="font-weight:bold">
                                                            <%:m.Status[i].Status %>
                                                        </td>
                                                        <td class="friendprice" style="float:right">
                                                            Rp <%:m.Status[i].Price %>
                                                        </td>
                                                    </tr>
                                                    <%} %>
                                                </tbody>
                                            </table>
                                        </div>
                                        <%if (myStatus.ToLower() == "waiting")
                                          { %>
                                        <div class="row">
                                            <div>
                                                <table style="margin: auto">
                                                    <tr>
                                                        <td>
                                                            <div style="padding: 15px 0px 15px 0px; width: 200px; margin: 0px 5px">
                                                                <button type="button" class="btn btn-default btn-accept btn-lg btn-block btn-login" data-bind="<%:tmgId %>">Join</button>
                                                            </div>
                                                        </td>
                                                        <td>
                                                            <div style="padding: 15px 0px 15px 0px; width: 200px; margin: 0px 5px">
                                                                <button type="button" class="btn btn-default btn-reject btn-lg btn-block btn-danger" data-bind="<%:tmgId %>">Reject</button>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </table>


                                            </div>
                                        </div>
                                        <%} %>
                                        <%if(m.TransStatus == pickkado.Front.TransactionStatus.InvitationGroupPending && m.UserId == userLogin.Id) { %>
                                        <div class="row">
                                            <div>
                                                <table style="margin: auto">
                                                    <tr>
                                                        <td>
                                                            <div style="padding: 15px 0px 15px 0px; width: 200px; margin: 0px 5px">
                                                                <button type="button" class="btn btn-default btn-continue btn-lg btn-block btn-login" data-bind="<%:m.TransId %>">Continue</button>
                                                            </div>
                                                        </td>
                                                        <td>
                                                            <div style="padding: 15px 0px 15px 0px; width: 200px; margin: 0px 5px">
                                                                <button type="button" class="btn btn-default btn-cancel btn-lg btn-block btn-danger" data-bind="<%:m.TransId %>">Cancel</button>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </table>


                                            </div>
                                        </div>
                                        <%} %>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <%} %>
                    <%}
                      else
                      { %>
                    <div style="background-color: #F5F7F6; text-align: center; padding: 20px; margin-top: 5px" class="font-avant">
                        Tidak Ada Patungan Invitation
                    </div>
                    <%} %>
                </div>
            </div>
        </div>

    </div>

</div>

<script type="text/javascript">
    $('.btn-accept').on('click', function () {
        //$(this).button('loading');
        <%myStatus = "Joined";%>
        var id = $(this).attr('data-bind');
        //var id = tmgId;
        console.log(id);
        var btn = $(this);
        $.ajax({
            type: "POST",
            url: '<%:Url.Action("invitation", "profile")%>',
            dataType: "json",
            data: $.param({ "tmgId": id, "isAccept": "true" }),
            success: function (result) {
                if (result.IsError) {
                    alert(result.Message);
                    //btn.button('reset');
                    //window.location.href = result.redirectTo;
                } else {
                    //$(".categories_content_container").html(result);
                    console.log(result);
                    var parent = btn.parents('.row').parent();
                    var table = parent.find('.friendlist tbody');
                    var colStatus = table.find('.me').parents('tr').find('td').eq(1);
                    console.log(colStatus);
                    console.log(table);
                    table.append('<tr><td colspan=3>' +
                            '<div class="alert alert-success" role="alert">' + result.Message + '</div>' +
                        '</td></tr>');
                    colStatus.html(result.Status);
                    btn.parents('.row').remove();
                    //btn.button('reset');
                }
            },
            error: function () {

            }
        });

    });
    $('.btn-reject').on('click', function () {
        //$(this).button('loading');
        <%myStatus = "Rejected";%>
        var id = $(this).attr('data-bind');
        //var id = tmgId;
        console.log(id);
        var btn = $(this);
        $.ajax({
            type: "POST",
            url: '<%:Url.Action("invitation", "profile")%>',
            dataType: "json",
            data: $.param({ "tmgId": id, "isAccept": "false" }),
            success: function (result) {
                if (result.IsError) {
                    alert(result.Message);
                    //btn.button('reset');
                    //window.location.href = result.redirectTo;
                } else {
                    //$(".categories_content_container").html(result);
                    console.log(result);
                    var parent = btn.parents('.row').parent();
                    var table = parent.find('.friendlist tbody');
                    var colStatus = table.find('.me').parents('tr').find('td').eq(1);
                    var colPrice = table.find('.me').parents('tr').find('td').eq(2);
                    var tableRow = table.find('tr');
                    
                    for (var i = 0; i < tableRow.length; i++) {
                        var tableRowStatus = tableRow.eq(i).find('td').eq(1);
                        var tableRowPrice = tableRow.eq(i).find('td').eq(2);
                        if (tableRowStatus.text().trim() == "Joined" || tableRowStatus.text().trim() == "Waiting")
                        tableRowPrice.html("Rp " + result.TotalPricePerPerson);
                    }
                    console.log(colStatus);
                    console.log(table);
                    table.append('<tr><td colspan=3>' +
                            '<div class="alert alert-success" role="alert">' + result.Message + '</div>' +
                        '</td></tr>');
                    colStatus.html(result.Status);
                    colPrice.html("Rp 0");
                    btn.parents('.row').remove();
                    //btn.button('reset');
                }
            },
            error: function () {

            }
        });

    });
    $('.btn-continue').on('click', function () {
        
        var id = $(this).attr('data-bind');
        console.log(id);
        var btn = $(this);
        $.ajax({
            type: "POST",
            url: '<%:Url.Action("invitationContinue", "profile")%>',
            dataType: "json",
            data: $.param({ "transId": id, "isContinue": "true" }),
            success: function (result) {
                if (result.IsError) {
                    alert(result.Message);
                    //btn.button('reset');
                    //window.location.href = result.redirectTo;
                } else {
                    //$(".categories_content_container").html(result);
                    console.log(result);
                    var parent = btn.parents('.row').parent();
                    var table = parent.find('.friendlist tbody');
                    var colStatus = table.find('.me').parents('tr').find('td').eq(1);
                    console.log(colStatus);
                    console.log(table);
                    table.append('<tr><td colspan=3>' +
                            '<div class="alert alert-success" role="alert">' + result.Message + '</div>' +
                        '</td></tr>');
                    btn.parents('.row').remove();
                    //btn.button('reset');
                }
            },
            error: function () {

            }
        });

    });
    $('.btn-cancel').on('click', function () {

        var id = $(this).attr('data-bind');
        console.log(id);
        var btn = $(this);
        $.ajax({
            type: "POST",
            url: '<%:Url.Action("invitationContinue", "profile")%>',
            dataType: "json",
            data: $.param({ "transId": id, "isContinue": "false" }),
            success: function (result) {
                if (result.IsError) {
                    alert(result.Message);
                    //btn.button('reset');
                    //window.location.href = result.redirectTo;
                } else {
                    //$(".categories_content_container").html(result);
                    console.log(result);
                    var parent = btn.parents('.row').parent();
                    var table = parent.find('.friendlist tbody');
                    var colStatus = table.find('.me').parents('tr').find('td').eq(1);
                    console.log(colStatus);
                    console.log(table);
                    table.append('<tr><td colspan=3>' +
                            '<div class="alert alert-success" role="alert">' + result.Message + '</div>' +
                        '</td></tr>');
                    btn.parents('.row').remove();
                    //btn.button('reset');
                }
            },
            error: function () {

            }
        });

    });
    $('.btn-submit-giftcard').on('click', function () {

        var id = $(this).attr('data-bind');
        console.log(id);
        var btn = $(this);
        var parent = btn.parents('.row').parent();
        var giftcardmessage = parent.find('textarea');
        
        
        $.ajax({
            type: "POST",
            url: '<%:Url.Action("invitationgiftcard", "profile")%>',
            dataType: "json",
            data: $.param({ "tgmId": id, "giftcardmessage": giftcardmessage.val() }),
            success: function (result) {
                if (result.IsError) {
                    alert(result.Message);
                } else {
                    giftcardmessage.attr("disabled", "disabled");
                    btn.parents('.row').remove();
                    parent.append('<div class="alert alert-success" role="alert">' + result.Message + '</div>');
                }
            },
            error: function () {
        
            }
        });

    });
    function btnJoin_onClick(tmgId) {
    }

    //$('#btnJoin').click(function (e) {
    //    e.preventDefault();
    //    $.ajax({
    //        type: "POST",
    //        url: '<%:Url.Action("invitation", "profile")%>',
    //        dataType: "json",
    //        data: $.param({ "isAccept": "true" }),
    //        success: function (result) {
    //            if (result.redirectTo) {
                    // The operation was a success on the server as it returned
                    // a JSON objet with an url property pointing to the location
                    // you would like to redirect to => now use the window.location.href
                    // property to redirect the client to this location
    //                window.location.href = result.redirectTo;
    //            } else {
                    // The server returned a partial view => let's refresh
                    // the corresponding section of our DOM with it
    //                $(".categories_content_container").html(result);
    //            }
    //        },
    //        error: function () {

    //        }
    //    });
    //});


    function show_onClick(Id) {
        var btnShow = document.getElementById(Id);

        if ($('#div' + Id).hasClass('collapsing') == false) {
            if ($('#div' + Id).hasClass('in')) {
                btnShow.text = "Tampilkan";
            } else {
                btnShow.text = "Sembunyikan";
            }
        }
    }


</script>
