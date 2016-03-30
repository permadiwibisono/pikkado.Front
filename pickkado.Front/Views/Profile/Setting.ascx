<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<dynamic>" %>

<div id="mainDiv" style="padding: 50px; margin-left: 120px">
    <div id="message"></div>
    <div class="container-fluid title-underline">
        <span class="font-avant" style="font-size: 15px">Change Password
        </span>
    </div>
    <%using(Html.BeginForm("changepassword", "profile", null, FormMethod.Post, new { id="formChangePassword" })) %>
    <%{ %>
    <%: Html.AntiForgeryToken() %>
    <%--<%var mdl = (pickkado.Front.Models.AccountBindingModel.ChangePasswordBindingModel)TempData["ChangePasswordModel"];%>--%>
    <%var modelKu = new pickkado.Front.Models.AccountBindingModel.ChangePasswordBindingModel();%>
            <div class="container-fluid">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="input-group input-group-lg" style="padding:10px 0px">
                            <%:Html.PasswordFor(m => modelKu.OldPassword, new { @class = "form-control", @placeholder = "ENTER OLD PASSWORD*" })%>
                            <span class="input-group-addon">
                                <span class="glyphicon glyphicon-lock" aria-hidden="true"></span>
                            </span>
                        </div>
                        <%:Html.ValidationMessageFor(m => modelKu.OldPassword)%>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-12">
                        <div class="input-group input-group-lg" style="padding:10px 0px">
                            <%:Html.PasswordFor(m => modelKu.NewPassword, new { @class = "form-control", @placeholder = "ENTER NEW PASSWORD*" })%>
                            <span class="input-group-addon">
                                <span class="glyphicon glyphicon-lock" aria-hidden="true"></span>
                            </span>
                        </div>
                        <%:Html.ValidationMessageFor(m => modelKu.NewPassword)%>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-12">
                        <div class="input-group input-group-lg" style="padding:10px 0px">
                            <%:Html.PasswordFor(m => modelKu.ConfirmPassword, new { @class = "form-control", @placeholder = "CONFIRM NEW PASSWORD*" })%>
                            <span class="input-group-addon">
                                <span class="glyphicon glyphicon-lock" aria-hidden="true"></span>
                            </span>
                        </div>
                        <%:Html.ValidationMessageFor(m => modelKu.ConfirmPassword)%>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-4">
                        <div style="padding:10px 0px">
                            <button type="button" class="btn btn-save btn-lg btn-block btn-login" >Save</button>
                        </div>
                    </div>
                </div>
            </div>
    <%} %>
    
</div>

<script type="text/javascript">
    $('.btn-save').on('click', function () {
        //e.preventDefault();
        //var myModel = $(this).attr('data-bind');
        //var btn = $(this);
        //alert(myModel);
        $.ajax({
            type: "POST",
            url: '<%:Url.Action("changepassword", "profile")%>',
            dataType: "json",
            //data: $.param({ "model": mdl }),
            //data: $.param({ "modelKu": myModel }),
            data: $('#formChangePassword').serialize(),
            success: function (result) {
                if (result.IsError) {
                    //alert(result.IsError + ' ' + result.Message);
                    alert("error" + ' ' + result.Message);
                    //$('#message').attr("style", "visibility:visible");
                    $('.message-result').remove();
                    $('#message').append("<div class=\"alert alert-danger form-message message-result\" style=\"margin-bottom:15px\">" +
                    "<a href=\"#\" class=\"close\" data-dismiss=\"alert\">×</a>" +
                    result.Message + 
                    "</div>");
                    //callback;
                    //btn.button('reset');
                    //console.log("error");
                } else {
                    //console.log("not error");
                    //alert(result.Message);
                    //alert(result.IsError + ' ' + result.Message);
                    alert("success");
                    $('.message-result').remove();
                    $('#message').append("<div class=\"alert alert-success form-message message-result\" style=\"margin-bottom:15px\">" +
                    "<a href=\"#\" class=\"close\" data-dismiss=\"alert\">×</a>" +
                    result.Message +
                    "</div>");
                    //window.location.href = "profile?menu=setting";
                    //callback;
                    //$(".categories_content_container").html(result);
                    //console.log(result);
                    //var parent = btn.parents('.row').parent();
                    //var table = parent.find('.friendlist tbody');
                    //var colStatus = table.find('.me').parents('tr').find('td').eq(1);
                    //console.log(colStatus);
                    //console.log(table);
                    //table.append('<tr><td colspan=3>' +
                    //        '<div class="alert alert-success" role="alert">' + result.Message + '</div>' +
                    //    '</td></tr>');
                    //btn.parents('.row').remove();
                    //btn.button('reset');
                }
            },
            error: function () {
                alert('error');
            }
        });

    });
</script>
