<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site1.Master" Inherits="System.Web.Mvc.ViewPage<List<pickkado.Entities.Transaction>>" %>

<asp:Content ID="profileTitle" ContentPlaceHolderID="TitleContent" runat="server">
    Profile
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="navBar" runat="server">
    <%Html.RenderAction("login_partial", "account"); %>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server" >
    <%var userLogin = (pickkado.Entities.User)TempData["UserLogin"]; %>
    <div class="container-fluid" style="background-color:#F2F2F2; margin:-20px -105px; padding:20px 120px" >
        <div style="float:left; border:5px solid white;" class="circular-portrait">
            <img src="../../images/damian7.jpg" />
        </div>
        <div style="margin-left: 160px">
            <h4 class="font-avant"><%:userLogin.FirstName + ' ' + userLogin.LastName %></h4>
        </div>
        
        <div style="background-color:white; padding:20px 0px 30px 0px; margin:0px -120px">
            <ul style="list-style-type: none; ">
                <li style="float: left; padding-left: 25px;">
                    <a id="tabinvitation" href="?menu=invitation" class="tab-unselected font-helvetica" style="text-decoration:none;"><div>Invitation</div>
                    </a>
                </li>
                <li style="float: left; padding-left: 25px;">
                    <a id="tabunconfirmedpurchase" href="?menu=unconfirmedpurchase" class="tab-unselected font-helvetica" style="text-decoration:none;"><div>Payment Confirmation</div>
                    </a>
                </li>
                <li style="float: left; padding-left: 25px">
                    <a id="tabpendingpurchase" href="?menu=pendingpurchase" class="tab-unselected font-helvetica" style="text-decoration:none;"><div>Pending Purchase</div>
                    </a>
                </li>
                <li style="float: left; padding-left: 25px">
                    <a id="tabonprocesspurchase" href="?menu=onprocesspurchase" class="tab-unselected font-helvetica" style="text-decoration:none;"><div>On Process Purchase</div>
                    </a>
                </li>
                <li style="float: left; padding-left: 25px">
                    <a id="tabhistorypurchase" href="?menu=historypurchase" class="tab-unselected font-helvetica" style="text-decoration:none; "><div>History Purchase</div>
                    </a>
                </li>
                <li style="float: left; padding-left: 25px">
                    <a id="tabmessage" href="?menu=message" class="tab-unselected font-helvetica" style="text-decoration:none; "><div>Message</div>
                    </a>
                </li>
                <li style="float: left; padding-left: 25px">
                    <a id="tabsetting" href="?menu=setting" class="tab-unselected font-helvetica" style="text-decoration:none; "><div style="color:inherit">Setting</div>
                    </a>
                </li>
            </ul>
        </div>

        <br />
        <%Html.RenderPartial((string)ViewBag.Menu, (object)TempData["TransactionList"]); %>
        <%--<%Html.RenderPartial((string)ViewBag.Menu, (object)ViewBag.TransactionList); %>--%>
    </div>
</asp:Content>

<asp:Content ID="scriptsContent" ContentPlaceHolderID="ScriptsSection" runat="server">
    <%: Scripts.Render("~/bundles/jqueryval") %>
    <style>
        .tab-unselected {
            color:#333333;
        }
        .circular-portrait {
            position:relative;
            width:150px;
            height:150px;
            overflow:hidden;
            border-radius:50%;
        }
        .circular-portrait img {
            width:100%;
            height:auto;
        }
    </style>
    <script>
        $(document).ready(function () {
            //alert('<%:ViewBag.Menu%>');
            $('#tab' + '<%:ViewBag.Menu%>').removeClass('tab-unselected').addClass('tab-selected');
        });
        function toggleExpandCollapse(sourceId, targetId) {
            if ($('#' + targetId).hasClass('collapsing') == false) {
                if ($('#' + targetId).hasClass('in')) {
                    $('#' + sourceId).text("Tampilkan");
                    $('#' + sourceId).append(" <span class=\"glyphicon glyphicon-chevron-down\"></span>");
                } else {
                    $('#' + sourceId).text("Sembunyikan");
                    $('#' + sourceId).append(" <span class=\"glyphicon glyphicon-chevron-up\"></span>");
                }
            }
        }
        function confirm_onClick(transId) {
            $.get("popup/paymentconfirm?transId=" + transId,
            function (data) {
                $("#popup").html(data);
            });
        }
        function detailPatungan_onClick(transId) {
            $.get("popup/detailpatungan?transId=" + transId,
            function (data) {
                $("#popup").html(data);
            });
        }
        function detailGiftcard_onClick(transId) {
            $.get("popup/detailgiftcard?transId=" + transId,
            function (data) {
                $("#popup").html(data);
            });
        }
    </script>

</asp:Content>
