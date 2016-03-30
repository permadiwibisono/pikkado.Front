<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site1.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Invite
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="navBar" runat="server">
    <%Html.RenderAction("login_partial","account"); %>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container-fluid title-underline" style="margin-bottom:20px">
        <span class="font-avant" style="font-size:15px">
            Ucapan kamu kepadanya
        </span>
    </div>
    <input type="text" style="border:1px solid #CECCCC; padding:15px; margin-bottom:20px; width:100%" placeholder="TYPE YOUR WORDS FOR THE GIFT CARD"/>

    <div class="container-fluid title-underline" style="margin-bottom:20px">
        <span class="font-avant" style="font-size:15px">
            Undang teman untuk memberikan ucapan juga
        </span>
    </div>
    <div style="width:100%">
        <table id="tableInvite" class="table table-striped" >
            <thead>
                <tr>
                    <th>Name</th>
                    <th>Email</th>
                    <th></th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>
                        <div class="input-group">
                            <input type="text" class="form-control" />
                            <span class="input-group-addon">
                                <span class="glyphicon glyphicon-user" aria-hidden="true"></span>
                            </span>
                        </div>
                    </td>
                    <td>
                        <div class="input-group">
                            <input type="text" class="form-control" />
                            <span class="input-group-addon">
                                <span class="glyphicon glyphicon-envelope" aria-hidden="true"></span>
                            </span>
                        </div>
                    </td>
                    <td>
                        <button type="submit" class="btn btn-default"><span class="glyphicon glyphicon-remove"></span> Delete</button>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div class="input-group">
                            <input type="text" class="form-control" />
                            <span class="input-group-addon">
                                <span class="glyphicon glyphicon-user" aria-hidden="true"></span>
                            </span>
                        </div>
                    </td>
                    <td>
                        <div class="input-group">
                            <input type="text" class="form-control" />
                            <span class="input-group-addon">
                                <span class="glyphicon glyphicon-envelope" aria-hidden="true"></span>
                            </span>
                        </div>
                    </td>
                    <td>
                        <button type="submit" class="btn btn-default"><span class="glyphicon glyphicon-remove"></span> Delete</button>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div class="input-group">
                            <input type="text" class="form-control" />
                            <span class="input-group-addon">
                                <span class="glyphicon glyphicon-user" aria-hidden="true"></span>
                            </span>
                        </div>
                    </td>
                    <td>
                        <div class="input-group">
                            <input type="text" class="form-control" "/>
                            <span class="input-group-addon">
                                <span class="glyphicon glyphicon-envelope" aria-hidden="true"></span>
                            </span>
                        </div>
                    </td>
                    <td>
                        <button type="submit" class="btn btn-default"><span class="glyphicon glyphicon-remove"></span> Delete</button>
                    </td>
                </tr>
            </tbody>
            <tfoot>
                <tr>
                    <td></td>
                    <td></td>
                    <td><button class="btn btn-default" style="width:100%"> <span class="glyphicon glyphicon-plus"></span> Add More</button></td>
                </tr>
            </tfoot>
        </table>
    </div>

    <div class="container-fluid" style="padding:15px 0px;">
        <div class="row" style="margin:30px 0px 30px 0px">
            <div class="col-xm-2 col-sm-2 col-md-2 col-lg-2">
                <a class="btn btn-lg btn-block btn-login"> <img src="../../images/icon/PanahBackIcon.png" class="lefticon"/> Back</a>
            </div>
            <div class="col-xm-offset-7 col-xm-3 col-sm-offset-7 col-sm-3 col-md-offset-7 col-md-3 col-lg-offset-7 col-lg-3" >
                <button type="submit" class="btn btn-lg btn-block btn-login"> Next <img src="../../images/icon/PanahNextIcon.png" class="righticon"/> </button>
            </div>
        </div>
    </div>

</asp:Content>

<asp:Content ID="Content5" ContentPlaceHolderID="ScriptsSection" runat="server">
    <%: Scripts.Render("~/bundles/jqueryval") %>
</asp:Content>
