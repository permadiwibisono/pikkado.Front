<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<dynamic>" %>

<%if (Request.IsAuthenticated)
  { %>               
    <% using (Html.BeginForm("logoff", "account", FormMethod.Post, new { id = "logoutForm" ,@class="navbar-right"}))
       { %>
        <%: Html.AntiForgeryToken()%>       
        <ul class="nav navbar-nav navbar-right">
            <li class="dropdown">
                <a href="#" class="dropdown-toggle" style="color:white;" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><%:((string)ViewBag.UserName).ToUpper()%> <span class="caret"></span></a>
                <ul class="dropdown-menu">
                    <li><a href="../profile"><img src="../../Images/icon/ProfileWhite_Icon.png" /> Profile</a></li>
                    <li><a href="#"><img src="../../Images/icon/PaymentConfirmation_Icon.png" />Payment confirmation</a></li>
                    <li><a href="#"><img src="../../Images/icon/PendingPurchase_Icon.png" />Pending purchase</a></li>
                    <li><a href="#"><img src="../../Images/icon/OnProcess_Icon.png" />Onprocess purchase</a></li>
                    <li><a href="#"><img src="../../Images/icon/MessageWhite_Icon.png" />Messages</a></li>
                </ul>
            </li> 
            <li ><div style="height:20px; margin-top:15px; border-right:1px white solid;border-left:1px white solid;"></div></li>
            <li><a class="btn btn-link" style="color:white" href="javascript:document.getElementById('logoutForm').submit()">LOGOUT</a></li>
                       
         </ul>
    <%} %>

  <%} %>
<%else{ %>      
        <ul class="nav navbar-nav navbar-right">
           
             <li><a style="color:white;cursor:pointer " id="login"><%--<span class="glyphicon glyphicon-user"></span>--%>  LOGIN</a></li> 
            <li ><div style="height:20px; margin-top:15px; border-right:1px white solid;border-left:1px white solid;"></div></li>
            <li><a style="color:white; " href="/account/register"><%--<span class="glyphicon glyphicon-plus-sign"></span>--%> REGISTER</a></li>
                       
         </ul>
<%} %>

<script type="text/javascript">
    $('#login').click(function () {
        $.get("../account/login",
        function (data) {
            $("#popup").html(data);
        });

    });
</script>
