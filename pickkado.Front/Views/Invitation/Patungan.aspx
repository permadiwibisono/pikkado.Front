<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site1.Master" Inherits="System.Web.Mvc.ViewPage<pickkado.Front.Models.InputPatunganViewModel>" %>
<%@ Import Namespace="pickkado.Front" %>


<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Patungan
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div style="max-height: 2500px; overflow: auto; margin-bottom:60px">
        <% using (Html.BeginForm("patungan", "invitation", new { code = Request.Params["code"] }, FormMethod.Post, new { id = "formPatungan" }))
           { %>
        <%: Html.AntiForgeryToken()%>
        <div class="col-md-10 col-md-offset-1">
            <div class="container-fluid title-underline" style="text-align:center; margin: 0px 0px">
                <span class="font-avant" style="font-size: 16px;">Hi <%:Model.ToUserName %>, kamu telah diundang <%:Model.UserName%> untuk patungan bersama.
                </span>
            </div>
            
            <%--<div id="divshow<%:m.TransId %>" class="collapse">--%>
            <%--<div id="divshow<%:Model.TransId %>" class="collapse">--%>
            <div>
                <div>
                    <div style="border-left: 1px solid #CECCCC; border-right: 1px solid #CECCCC; border-bottom: 1px solid #CECCCC; padding: 10px">
                        
                        <% if (ViewData.ModelState.Any(x => x.Value.Errors.Any()))
                           {%>
                            <div id="message" class="alert alert-danger form-message">
                                <a href="#" class="close" data-dismiss="alert">×</a>
                                <%: Html.ValidationSummary("", new { @class = "validation-summary-custom" })%>
                            </div>
                        <% }%>
                        <%:Html.HiddenFor(m => m.Id)%>
                        <div class="container-fluid">
                            <div class="row" style="background-color: #DAD1C6; margin: 20px 40px">
                                <div class="font-helvetica" style="text-align: center; padding: 15px;">
                                    <%:Model.PatunganTitle%>
                                    <%--m.PatunganTitle--%>
                                </div>
                                <div class="font-avant" style="text-align: center; padding: 15px">
                                    <%:Model.ProductName%>
                                    <%--m.ProductName--%>
                                </div>
                                <div class="square" style="text-align: center; padding: 15px;">
                                    <%--<img src="data:image;base64,<%:System.Convert.ToBase64String(m.ProductImage) %>" style="width: 300px; padding: 10px; border: 2px solid white" />--%>
                                    <%--<img src="../../../../Images/no-thumb.png" style="width: 300px; padding: 10px; border: 2px solid white" />--%>
                                    
                                    <%if (Model.ProductImage == null)
                                      { %>
                                        <img src="../../../../Images/no-thumb.png" style="width: 300px; padding: 10px; border: 2px solid white" />
                                    <%}
                                      else
                                      {%>
                                        <img src="data:image;base64,<%:System.Convert.ToBase64String(Model.ProductImage)%>" style="width: 300px; padding: 10px; border: 2px solid white" />
                                    <%} %>
                                </div>
                                <div class="font-helvetica" style="text-align: center; padding: 30px 15px;">
                                    <%:Model.PatunganDescription%>
                                    <%--m.PatunganDescription--%>
                                </div>
                            </div>
                            <div class="row" style="margin-bottom: 20px; padding: 20px 40px">
                                <div class="col-md-6">
                                    <div style="border: 1px solid #CECCCC; padding: 15px 10px;">
                                        BATAS WAKTU PELUNASAN : <%:Model.BatasWaktuPelunasan.ToString("dd MMMM yyyy")%>
                                        <%--BATAS WAKTU PELUNASAN : m.BatasWaktuPelunasan.ToString("dd MMMM yyyy")--%>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div style="border: 1px solid #CECCCC; padding: 15px 10px">
                                        TOTAL PEMBAYARAN : <%:Model.TotalPembayaran.ToRupiah()%>
                                        <%--TOTAL PEMBAYARAN : Rp m.TotalPembayaran--%>
                                    </div>
                                </div>
                            </div>
                            <input id="tmgId" type="hidden" value="" />
                            <%string myStatus = ""; %>
                            <div class="row" style="margin: 20px 100px">
                                <div class="font-avant" style="font-size: 18px; padding-left: 10px; margin-bottom: 10px">
                                    Invitation Status
                                </div>
                                <table class="table tableBrownNavy friendlist">
                                    <tbody>
                                        <%for (int i = 0; i < Model.Status.Count; i++)
                                          { %>
                                        <tr>
                                            <td class="friendname">
                                                <%:Model.Status[i].Name%>
                                                <%if (Model.Status[i].Name == "You")
                                                  { %>
                                                <% myStatus = Model.Status[i].Status; %>
                                                <%} %>
                                            </td>
                                            <td class="friendstatus" style="font-weight:bold; text-transform:uppercase">
                                                <%:Model.Status[i].Status%>
                                            </td>
                                            <td class="friendprice" style="float:right">
                                                <%:Model.Status[i].Price.ToRupiah()%>
                                            </td>
                                        </tr>
                                        <%} %>
                                    </tbody>
                                </table>
                            </div>
                            <%if (myStatus.ToLower() == "waiting")
                              { %>
                            <%if (!Request.IsAuthenticated)
                            { %>
                            <div class="alert alert-info div-info" role="alert" style="text-align: center">
                                <p>Untuk dapat merespon undangan, Kamu perlu melakukan <a data-toggle="collapse" href="#divlogin">login</a> terlebih dahulu.</p>
                                <p>Belum punya akun? Register <a data-toggle="collapse" href="#divregister">disini</a></p>
                            </div>
                            <div id="divResponseResult">
                                <%--untuk mengisi hasil respon dengan div--%>
                            </div>
                            <div id="divlogin" class="col-lg-6 collapse div-login">
                                    <div class="row">
                                        <div id="divLoginError" class="col-lg-12">
                                            
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-lg-12">
                                            <div class="input-group input-group-lg" style="padding: 10px 0px">
                                                <%:Html.HiddenFor(m => m.EmailLogin)%>
                                                <%:Html.TextBoxFor(m => m.EmailLogin, new { id = "txtEmail", @class = "form-control disabled", @placeholder = "EMAIL ADDRESS", @disabled = "disabled" })%>
                                                <span class="input-group-addon">
                                                    <span class="glyphicon glyphicon-envelope" aria-hidden="true"></span>
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-lg-12">
                                            <div class="input-group input-group-lg" style="padding: 10px 0px">
                                                <%:Html.PasswordFor(m => m.PasswordLogin, new { id = "txtPassword", @class = "form-control", @placeholder = "PASSWORD" })%>
                                                <span class="input-group-addon">
                                                    <span class="glyphicon glyphicon-lock" aria-hidden="true"></span>
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                            </div>
                            <div id="divregister" class="col-lg-6 collapse div-register">
                                    <div class="row">
                                        <div id="divRegisterError" class="col-lg-12">
                                            
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-lg-12">
                                            <div class="input-group input-group-lg" style="padding: 10px 0px">
                                                <%:Html.TextBoxFor(m => m.Firstname, new { @class = "form-control", @placeholder = "FIRST NAME" })%>
                                                <span class="input-group-addon">
                                                    <span class="glyphicon glyphicon-user" aria-hidden="true"></span>
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-lg-12">
                                            <div class="input-group input-group-lg" style="padding: 10px 0px">
                                                <%:Html.TextBoxFor(m => m.Lastname, new { @class = "form-control", @placeholder = "LAST NAME" })%>
                                                <span class="input-group-addon">
                                                    <span class="glyphicon glyphicon-user" aria-hidden="true"></span>
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-lg-12">
                                            <div class="input-group input-group-lg" style="padding: 10px 0px">
                                                <%:Html.TextBoxFor(m => m.EmailRegister, new { @class = "form-control disabled", @placeholder = "EMAIL ADDRESS", @disabled = "disabled" })%>
                                                <%:Html.HiddenFor(m => m.EmailRegister)%>
                                                <span class="input-group-addon">
                                                    <span class="glyphicon glyphicon-envelope" aria-hidden="true"></span>
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-lg-12">
                                            <div class="input-group input-group-lg" style="padding: 10px 0px">
                                                <%:Html.PasswordFor(m => m.PasswordRegister, new { @class = "form-control", @placeholder = "PASSWORD" })%>
                                                <%--<input type="password" class="form-control" placeholder="PASSWORD" />--%>
                                                <span class="input-group-addon">
                                                    <span class="glyphicon glyphicon-lock" aria-hidden="true"></span>
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-lg-12">
                                            <div class="input-group input-group-lg" style="padding: 10px 0px">
                                                <%:Html.PasswordFor(m => m.ConfirmPasswordRegister, new { @class = "form-control", @placeholder = "CONFIRM PASSWORD" })%>
                                                <%--<input type="password" class="form-control" placeholder="CONFIRM PASSWORD" />--%>
                                                <span class="input-group-addon">
                                                    <span class="glyphicon glyphicon-lock" aria-hidden="true"></span>
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                            </div>
                            <%} %>
                            <div class="row div-response">
                                <div class="col-md-12">
                                    <table style="margin: auto">
                                        <tr>
                                            <td>
                                                <div style="padding: 15px 0px 15px 0px; width: 200px; margin: 0px 5px">
                                                    <%--<button type="button" class="btn btn-default btn-accept btn-lg btn-block btn-login">Join</button>--%>
                                                    
                                                    <button type="submit" class="btn btn-default btn-lg btn-block btn-login" name="isAccept" value="true">Join</button>
                                                </div>
                                            </td>
                                            <td>
                                                <div style="padding: 15px 0px 15px 0px; width: 200px; margin: 0px 5px">
                                                    <%--<button type="button" class="btn btn-default btn-reject btn-lg btn-block btn-danger">Reject</button>--%>
                                                    <button type="submit" class="btn btn-default btn-lg btn-block btn-danger" name="isAccept" value="false">Reject</button>
                                                </div>
                                            </td>
                                        </tr>
                                    </table>


                                </div>
                            </div>
                            <%}
                              else
                              { %>
                            <div class="alert alert-info div-info" role="alert" style="text-align: center">
                                <p>Kamu sudah merespon undangan ini</p>
                            </div>
                            <%} %>
                        </div>
                        
                    </div>
                </div>
            </div>

        </div>
        <%} %>
    </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="navBar" runat="server">
    <%Html.RenderAction("login_partial","account"); %>
</asp:Content>

<asp:Content ID="Content5" ContentPlaceHolderID="ScriptsSection" runat="server">
    <script src="../../Scripts/convert-rupiah.js"></script>
    <script>
        $('.btn-accept').on('click', function () {
            var btn = $(this);
            var isDisabled = btn.hasClass('disabled');
            var id = $('#tmgId').text();
            if (!isDisabled) {
                $.ajax({
                    type: "POST",
                    url: '<%:Url.Action("patungan", "invitation")%>',
                    dataType: "json",
                    data: $('#formPatungan').serialize() + '&' + $.param({ "code": '<%:Request.Params["code"]%>', "isAccept": "true" }),
                    success: function (result) {
                        alert('suc');
                        if (result.IsError) {
                            alert('error');
                            //alert(result.Message);
                            //btn.button('reset');
                            //window.location.href = result.redirectTo;
                        } else {
                            alert('success');
                            //$('#divResponseResult').append(
                            //'<div class="alert alert-success" role="alert" style="text-align: center">' +
                            //    '<p>' + result.Message + '</p>' +
                            //'</div>');
                            //var parent = btn.parents('.row').parent();
                            //var table = parent.find('.friendlist tbody');
                            //var colStatus = parent.find('.friendlist tbody .friendname:contains(\'You\')').parents('tr').find('td').eq(1);

                            //console.log(colStatus);
                            //console.log(table);
                            //colStatus.html(result.Status);
                            //btn.parents('.row').remove();
                            //$('.div-info').remove();
                        }
                    },
                    error: function () {
                        //window.location.href = "patungan?code=22820A54-0125-45AC-B0A4-190997CFF819";
                    }
                });
            }

        });
    </script>
    <script>
        $('#btn-join').click(function (e) {
            e.peventDefault(); // stop default redirect
            var href = $(this).attr('href'); //  get current href value
            href = href + '?isAccept=true'; // update with parameters
            window.location.href = href; // redirect
        })
    </script>
</asp:Content>
