<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<pickkado.Front.Models.LoginViewModel>" %>

<div style="position:fixed;background-color:rgba(10,10,10,0.6); top:0; bottom:0;left:0; width:100%; height:100%; right:0;z-index:1100;">
    <div style="position:relative; width:490px;height:540px;background-color:white; margin: auto; top:50%; transform:translateY(-50%)">
        <img src="../../Images/icon/close.png" style=" position:absolute; top:-14px; right:-14px; cursor:pointer" id="btn-close"  />
           
        <div class="container-fluid" style = "padding:50px 20px" > 
    <% using (Html.BeginForm("login", "account", null, FormMethod.Post, new {id="loginForm"}))
       { %>
        <%: Html.AntiForgeryToken()%>
        <% if (ViewData.ModelState.Any(x => x.Value.Errors.Any()))
           {%>
                <div id="message" class="alert alert-danger popup-message">
                    <a href="#" class="close" data-dismiss="alert">×</a>
                    <%: Html.ValidationSummary("", new { @class = "validation-summary-custom " })%>
                </div>
            <% }%>
                <div class="row">
                    <div class="col-lg-12">
                    <div class="input-group input-group-lg" style="padding:10px 0px">
                        <%:Html.TextBoxFor(m => m.Email, new { id = "txtEmail", @class = "form-control", @placeholder = "EMAIL ADDRESS" })%>
                        
                        <span class="input-group-addon">
                            <span class="glyphicon glyphicon-envelope" aria-hidden="true"></span>
                        </span>
                    </div>

                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-12">
                    <div class="input-group input-group-lg" style="padding:10px 0px">
                        <%:Html.PasswordFor(m => m.Password, new { id = "txtPassword", @class = "form-control", @placeholder = "PASSWORD" })%>
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
                        <button id="btnLogin" type="button" data-loading-text="Logging in"  class="btn  btn-lg btn-block btn-login ">LOGIN</button>
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
    <% } %>
            
            <%Html.RenderPartial("_ExternalLoginsListPartial", new pickkado.Front.Models.ExternalLoginListViewModel { ReturnUrl = Url.Action("","home") }); %>                

        </div>
    </div>
</div>
<script>

    $('#btn-close').click(function () {
        $("#popup").html('');
    });
    $('#txtPassword').on('keyup', function (event) {
        if (event.keyCode == 13) {
            $('#btnLogin').button('loading');
            login();
            
        }
    });

    function login()
    {
        $.ajax({
            type: "POST",
            url: '<%: Url.Action("login", "account")%>',
            dataType: "json",
            data: $('#loginForm').serialize() + "&returnUrl=" + '<%:Request.UrlReferrer.AbsoluteUri%>',
            success: function (result) {
                if (result.redirectTo != null) {
                    // The operation was a success on the server as it returned
                    // a JSON objet with an url property pointing to the location
                    // you would like to redirect to => now use the window.location.href
                    // property to redirect the client to this location
                    window.location.href = result.redirectTo;
                } else {
                    // The server returned a partial view => let's refresh
                    // the corresponding section of our DOM with it
                    $("#popup").html(result.HtmlString);
                }
                //$this.button('reset');
            },
            error: function (err) {
                $('#btnLogin').button('reset');
            }
        });
    }
    $('#btnLogin').click(function (e) {
        //http://stackoverflow.com/questions/14667274/asp-net-mvc-partial-view-ajax-post
        e.preventDefault();
        var $this = $(this);
        $this.button('loading');
        login();
        $this.button('reset');
    });
    //$(".validation-summary-errors").removeClass("validation-summary-errors");
    //$(".input-validation-error").removeClass("input-validation-error").parent().addClass("has-error");
</script>
<script src="../../Scripts/validation-summary.js"></script>

