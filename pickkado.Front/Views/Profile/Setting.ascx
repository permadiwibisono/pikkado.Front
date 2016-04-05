<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<dynamic>" %>

<div id="mainDiv" style="padding: 50px; margin-left: 120px">
    <div id="message"></div>
    <div class="container-fluid title-underline">
        <span class="font-avant" style="font-size: 15px">User Details
        </span>
    </div>
    <%using(Html.BeginForm("changeuserdetail", "profile", null, FormMethod.Post, new { id="formUserDetail" })) %>
    <%{ %>
    <%: Html.AntiForgeryToken() %>
    <%--<%var mdl = (pickkado.Front.Models.AccountBindingModel.ChangePasswordBindingModel)TempData["ChangePasswordModel"];%>--%>
    <%var user = (pickkado.Entities.User)TempData["UserLogin"];%>
            <div class="container-fluid" style="margin-bottom:20px">
                <%:Html.HiddenFor(a => user.Id) %>
                <%--<div class="row">
                    <div class="col-lg-12">
                        <input id="pp" type="file" name="image" accept="image/x-png, image/gif, image/jpeg"/>
                    </div>
                </div>--%>
                <div class="row">
                    <div class="col-lg-12">
                        <div class="input-group input-group-lg" style="padding:10px 0px">
                            <%:Html.TextBoxFor(m => user.Email, new { @class = "form-control disabled", @placeholder = "EMAIL", @disabled="disabled" })%>
                            <%:Html.HiddenFor(m => user.Email)%>
                            <span class="input-group-addon">
                                <span class="glyphicon glyphicon-envelope" aria-hidden="true"></span>
                            </span>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-6">
                        <div class="input-group input-group-lg" style="padding:10px 0px">
                            <%:Html.TextBoxFor(m => user.BirthPlace, new { @class = "form-control", @placeholder = "BIRTH PLACE" })%>
                            <span class="input-group-addon">
                                <span class="glyphicon glyphicon-home" aria-hidden="true"></span>
                            </span>
                        </div>
                    </div>
                    <div class="col-lg-6">
                        <div class="input-group input-group-lg" style="padding:10px 0px">
                            <%:Html.TextBoxFor(m => user.BirthDate, new { @class = "form-control", @placeholder = "BIRTH DATE", id="textBoxBirthDate" })%>
                            <span class="input-group-addon">
                                <span class="glyphicon glyphicon-th" aria-hidden="true"></span>
                            </span>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-12">
                        <div class="input-group input-group-lg" style="padding:10px 0px">
                            <%var genderList = new List<SelectListItem>();
                              genderList.Add(new SelectListItem { Text = "Laki-laki", Value = "0" });
                              genderList.Add(new SelectListItem { Text = "Perempuan", Value = "1" });
                              %>
                            <%--<%:Html.TextBoxFor(m => user.Gender, new { @class = "form-control", @placeholder = "GENDER" })%>--%>
                            <%:Html.DropDownListFor(m => user.Gender, genderList, new { @class = "form-control", @placeholder = "GENDER" })%>
                            <span class="input-group-addon">
                                <span class="glyphicon glyphicon-user" aria-hidden="true"></span>
                            </span>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-12">
                        <div class="input-group input-group-lg" style="padding:10px 0px">
                            <%:Html.TextBoxFor(m => user.PhoneNumber, new { @class = "form-control", @placeholder = "PHONE NUMBER" })%>
                            <span class="input-group-addon">
                                <span class="glyphicon glyphicon-phone" aria-hidden="true"></span>
                            </span>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-4">
                        <div style="padding:10px 0px">
                            <button type="button" class="btn btn-save-changeuserdetail btn-lg btn-block btn-login" >Save</button>
                        </div>
                    </div>
                </div>
            </div>
    <%} %>
    

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
                            <button type="button" class="btn btn-save-changepassword btn-lg btn-block btn-login" >Save</button>
                        </div>
                    </div>
                </div>
            </div>
    <%} %>
    
</div>

<%--<script src="../../Scripts/jquery.form.js"></script>--%>
<link rel="stylesheet" href="../../Content/bootstrap/css/datepicker.css" />
<script src="../../Scripts/bootstrap/bootstrap-datepicker.js"></script>
<script type="text/javascript">
    $(document).ready(function () {
        $('#textBoxBirthDate').datepicker({ format: 'dd/mm/yyyy' }).on('changeDate', function () {
            $(this).datepicker('hide');
        });;
    });
    $('.btn-save-changepassword').on('click', function () {
        $.ajax({
            type: "POST",
            url: '<%:Url.Action("changepassword", "profile")%>',
            dataType: "json",
            data: $('#formChangePassword').serialize(),
            success: function (result) {
                if (result.IsError) {
                    $('.message-result').remove();
                    $('#message').append("<div class=\"alert alert-danger form-message message-result\" style=\"margin-bottom:15px\">" +
                    "<a href=\"#\" class=\"close\" data-dismiss=\"alert\">×</a>" +
                    result.Message + 
                    "</div>");
                } else {
                    $('.message-result').remove();
                    $('#message').append("<div class=\"alert alert-success form-message message-result\" style=\"margin-bottom:15px\">" +
                    "<a href=\"#\" class=\"close\" data-dismiss=\"alert\">×</a>" +
                    result.Message +
                    "</div>");
                }
            },
            error: function () {
                alert('error');
            }
        });

    });
    $('.btn-save-changeuserdetail').on('click', function () {
        $.ajax({
        type: "POST",
        url: '<%:Url.Action("changeuserdetail", "profile")%>',
            dataType: "json",
            data: $('#formUserDetail').serialize(),
            success: function (result) {
                if (result.IsError) {
                    $('.message-result').remove();
                    $('#message').append("<div class=\"alert alert-danger form-message message-result\" style=\"margin-bottom:15px\">" +
                    "<a href=\"#\" class=\"close\" data-dismiss=\"alert\">×</a>" +
                    result.Message +
                    "</div>");
                } else {
                    $('.message-result').remove();
                    $('#message').append("<div class=\"alert alert-success form-message message-result\" style=\"margin-bottom:15px\">" +
                    "<a href=\"#\" class=\"close\" data-dismiss=\"alert\">×</a>" +
                    result.Message +
                    "</div>");
                }
            },
            error: function () {
                alert('error');
            }
        });

    });
    

    
</script>
