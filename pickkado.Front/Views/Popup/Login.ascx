<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<pickkado.Front.Models.LoginViewModel>" %>

<div style="position:fixed;background-color:rgba(10,10,10,0.6); top:0; bottom:0;left:0; right:0;z-index:5;">
    <div style="position:relative; width:490px;height:540px;background-color:white; margin: auto; top:50%; transform:translateY(-50%)">
        <img src="../../Images/icon/close.png" style=" position:absolute; top:-14px; right:-14px; cursor:pointer" id="btn-close"  />
            
    <% using (Html.BeginForm("login", "account", FormMethod.Post, new { @class = "container-fluid", @style = "padding:50px 20px" }))
       { %>
        <%: Html.AntiForgeryToken()%>
        <%: Html.ValidationSummary()%>
                <div class="row">
                    <div class="col-lg-12">
                    <div class="input-group input-group-lg" style="padding:10px 0px">
                        <%:Html.TextBoxFor(m => m.Email, new { @class = "form-control", @placeholder = "EMAIL ADDRESS" })%>
                        <span class="input-group-addon">
                            <span class="glyphicon glyphicon-envelope" aria-hidden="true"></span>
                        </span>
                    </div>

                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-12">
                    <div class="input-group input-group-lg" style="padding:10px 0px">
                        <%:Html.PasswordFor(m => m.Password, new { @class = "form-control", @placeholder = "PASSWORD" })%>
                        <span class="input-group-addon">
                            <span class="glyphicon glyphicon-lock" aria-hidden="true"></span>
                        </span>
                    </div>

                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-4 col-lg-offset-8 ">
                    <div class="input-group input-group-lg" style="padding:10px 0px">
                        
                        <button type="button"  class="btn btn-block btn-link link-green" >Forget password?</button>
                    </div>

                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-12">
                    <div class="input-group input-group-lg" style="padding:10px 0px; width:100%">
                        <button type="submit"  class="btn btn-primary btn-lg btn-block btn-login ">LOGIN</button>
                    </div>
                    </div>
                </div>
                <div class="row" style="padding:10px 0px">
                    <div class="col-lg-6">
                    <div style="width:100%; border-bottom:1px solid #cecccc"></div>
                    </div>
                    <div class="col-lg-6">
                    <div style="width:100%; border-bottom:1px solid #cecccc"></div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-12">
                    <div class="input-group input-group-lg" style="padding:10px 0px; width:100%">
                        <button type="button" class="btn btn-primary btn-lg btn-block btn-fb"><img src="../../Images/icon/fb.png" style="padding-right:20px" />  Login with Facebook</button>
                    </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-12">
                    <div class="input-group input-group-lg" style="padding:10px 0px; width:100%">
                        <button type="button" class="btn btn-default btn-lg btn-block btn-google"> <img src="../../Images/icon/gplus.png" style="padding-right:20px" />Login with Google</button>
                    </div>
                    </div>
                </div>
    <% } %>
    </div>
</div>
<script>

    $('#btn-close').click(function () {
       $("#popup").html('');
    });
</script>

