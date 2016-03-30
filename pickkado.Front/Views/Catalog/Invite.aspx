<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site1.Master" Inherits="System.Web.Mvc.ViewPage<pickkado.Front.Models.GiftCardInviteViewModel>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Invite
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="navBar" runat="server">
    <%Html.RenderAction("login_partial","account"); %>
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="breadcumb" runat="server">
    <li><a href="/">Home</a></li>
    <li>Catalog</li>
    <li ><%:ViewBag.ProductName %></li>
    <li ><a href="<%:ViewBag.LinkBack %>">Package & Giftcard</a> </li>
    <li class="active">Input your giftcard message</li>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container-fluid title-underline" style="margin-bottom:20px">
    <% if (ViewData.ModelState.Any(x => x.Value.Errors.Any()))
            {%>
        <div class="alert alert-danger" style="position: relative; margin: 0;">
            <a href="#" class="close" data-dismiss="alert">×</a>
            <%: Html.ValidationSummary("", new { @class = "validation-summary-custom" })%>
        </div>
        <% }%>
        <span class="font-avant" style="font-size:15px">
            Ucapan kamu kepadanya
        </span>
    </div>
    <% using (Html.BeginForm())
       { %>
            <%: Html.AntiForgeryToken()%>
        <%: Html.TextAreaFor(m=>m.MyGiftCard,new {@class="form-control", rows="5", placeholder="TYPE YOUR WORDS FOR THE GIFT CARD",style="margin-bottom:20px"}) %>
        <%--<%:Html.TextBoxFor(a => a.MyGiftCard, new { placeholder="TYPE YOUR WORDS FOR THE GIFT CARD", @class="form-control", style="height:50px; margin-bottom:20px" }) %>--%>
    
        <div class="container-fluid title-underline" style="margin-bottom:20px">
            <span class="font-avant" style="font-size:15px">
                Undang teman untuk memberikan ucapan juga*
            </span>
        </div>
        <div style="width:100%" id="inviteFriends">
            <span style="color:#bfbfbf;font-size:13px;">*Kosongkan form dibawah ini jika tidak ingin mengundang teman</span>
        <%: Html.TextAreaFor(m=>m.MessageToFriends,new {@class="form-control", rows="5", placeholder="TYPE YOUR WORDS FOR YOUR FRIENDS",style="margin-bottom:20px"}) %>
            <table id="tableInvite" class="table">
                <tbody id="inviteContent">
                    <%if(Model!=null&&Model.FriendsGiftCard!=null){
                          for (int i = 0; i < Model.FriendsGiftCard.Count; i++)
                          {%> 
                            <tr>
                                <td>
                                    <%:Html.TextBox("FriendsGiftCard["+i+"].Name",Model.FriendsGiftCard[i].Name,new{@class="form-control",style="width:100%",placeholder="NAMA"} )%>
                                </td>
                                <td>
                                    <%:Html.TextBox("FriendsGiftCard["+i+"].Email",Model.FriendsGiftCard[i].Email,new{@class="form-control",style="width:100%",placeholder="EMAIL"} )%>
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
                        <td>
                            <div class="btn btn-default" style="background-color:#DAD1C6; color:white; min-width:107px" onclick="addRow()"> <span class="glyphicon glyphicon-plus"></span> <strong>Add More</strong>

                            </div>
                            
                            <div class="btn btn-default btn-clear" style="background-color:#DAD1C6; color:white; min-width:107px"><span class="glyphicon glyphicon-repeat"></span> <strong>Clear</strong></div>
                        </td>
                    </tr>
                </tfoot>
            </table>
        </div>
    
        <div class="container-fluid" style="padding:15px 0px;">
            <div class="row" style="margin:30px 0px 30px 0px">
                <div class="col-xm-2 col-sm-2 col-md-2 col-lg-2">
                    <a href="<%:ViewBag.LinkBack %>" class="btn btn-lg btn-block btn-login"> <img src="../../images/icon/PanahBackIcon.png" class="lefticon"/> Back</a>
                </div>
                <div class="col-xm-offset-7 col-xm-3 col-sm-offset-7 col-sm-3 col-md-offset-7 col-md-3 col-lg-offset-7 col-lg-3" >
                    <button type="submit" class="btn btn-lg btn-block btn-login"> Next <img src="../../images/icon/PanahNextIcon.png" class="righticon"/> </button>
                </div>
            </div>
        </div>
    <%} %>
</asp:Content>

<asp:Content ID="Content5" ContentPlaceHolderID="ScriptsSection" runat="server">
    <%: Scripts.Render("~/bundles/jqueryval") %>
    <script>
        $(document).ready(function () {
            var count = $('#tableInvite tbody tr').length;
            if (count == 0)
            {
                var row = '<tr><td>\
                                <input type="text" class="form-control" placeholder="NAMA" style="width:100%" name="FriendsGiftCard[0].Name"/>\
                            </td>\
                            <td>\
                                <input type="text" class="form-control" placeholder="EMAIL" style="width:100%" name="FriendsGiftCard[0].Email"/>\
                            </td>\
                            <td style="vertical-align:middle">\
                            </td></tr>';
                $('#tableInvite tbody').append(row);
            }
        });

        
        $('.btn-clear').click(function () {
            $('#inviteFriends input[type="text"], #inviteFriends textarea').val('');
            var row = '<tr><td>\
                                <input type="text" class="form-control" placeholder="NAMA" style="width:100%" name="FriendsGiftCard[0].Name"/>\
                            </td>\
                            <td>\
                                <input type="text" class="form-control" placeholder="EMAIL" style="width:100%" name="FriendsGiftCard[0].Email"/>\
                            </td>\
                            <td style="vertical-align:middle">\
                            </td></tr>';
            $('#tableInvite tbody').html(row);
        });
        function addRow() {
            var tr = document.createElement('tr');
            var lastRow = $('#tableInvite tbody tr:last');
            var canAddRow = true;
            cannotAddRow=lastRow.children().find('input[type="text"]').each(function () {
                if ($(this).val() == "") {
                    alert("Please fulfill your friend's name and email before.");
                    canAddRow = false;
                    return false;
                }
            });
            if (canAddRow)
            {

                //div.className = "row";
                var table = document.getElementById('tableInvite');
                tr.innerHTML =
                                '<td>\
                                    <input type="text" class="form-control" placeholder="NAMA" style="width:100%" name="FriendsGiftCard[' + (table.rows.length-1) + '].Name"/>\
                                </td>\
                                <td>\
                                    <input type="text" class="form-control" placeholder="EMAIL" style="width:100%" name="FriendsGiftCard[' + (table.rows.length - 1) + '].Email"/>\
                                </td>\
                                <td style="vertical-align:middle">\
                                    <button type="button" style="background-color:transparent; background-repeat:no-repeat; border:none" onclick="removeRow(this)">\
                                        <span class="glyphicon glyphicon-remove-sign" aria-hidden="true" style="font-size:20px; color:#C4021A"></span>\
                                    </button>\
                                </td>';

                document.getElementById('inviteContent').appendChild(tr);

            }
        }

        function removeRow(input) {
            var table = document.getElementById('tableInvite');
            
            var rowIndex = input.parentNode.parentNode.rowIndex;
            if (rowIndex + 1 != table.rows.length-1) {
                //alert('a');
                for (var i = rowIndex + 1; i < table.rows.length - 1; i++) {
                    table.rows[i].cells[0].getElementsByTagName('input')[0].name = 'FriendsGiftCard[' + (i - 1) + '].Name'
                    table.rows[i].cells[1].getElementsByTagName('input')[0].name = 'FriendsGiftCard[' + (i - 1) + '].Email'
                }
            }

            document.getElementById('inviteContent').removeChild(input.parentNode.parentNode);
        }

        $(".validation-summary-errors").removeClass("validation-summary-errors");
        $(".input-validation-error").removeClass("input-validation-error").parent().addClass("has-error");
    </script>
</asp:Content>
