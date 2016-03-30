<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<pickkado.Entities.Transaction>" %>
                                

<h3>Package Details</h3>
<div class="row" style="padding:2px 0;">
    <div class="form-group">
        <label class="col-sm-2 control-label">
            Package Id:
        </label>
        <div class="col-sm-10">
                <%:Html.TextBoxFor(m=>m.PackageId,new{@class="form-control", disabled="disabled"}) %>
        </div>
    </div>
</div>
<div class="row" style="padding:2px 0;">
    <div class="form-group">
        <label class="col-sm-2 control-label">
            Preview:
        </label>
            <div class="col-sm-10">
                <%if(Model.PackageImage!=null){ %>
                <img src="data:image;base64,<%: System.Convert.ToBase64String(Model.PackageImage)%>" class="img-thumbnail" height="200" width="200" />
                <%}else{ %>
                <img src="../../../../Images/no-thumb.png" class="img-thumbnail" height="200" width="200" />
                <%} %>
            </div>
        </div>
    </div>
<div class="row" style="padding:2px 0;">
    <div class="form-group">
        <label class="col-sm-2 control-label">
            Package Name:
        </label>
        <div class="col-sm-10">
                <%:Html.TextBoxFor(m=>m.PackageName,new{@class="form-control", disabled="disabled"}) %>
        </div>
    </div>
</div>
<h3>Giftcard Details</h3>
<div class="row" style="padding:2px 0;">
    <div class="form-group">
        <label class="col-sm-2 control-label">
            Giftcard Id:
        </label>
        <div class="col-sm-10">
                <%:Html.TextBoxFor(m=>m.GreetingCardId,new{@class="form-control", disabled="disabled"}) %>
        </div>
    </div>
</div>
<div class="row" style="padding:2px 0;">
    <div class="form-group">
        <label class="col-sm-2 control-label">
            Preview:
        </label>
            <div class="col-sm-10">
                <%if(Model.GreetingCardImage!=null){ %>
                <img src="data:image;base64,<%: System.Convert.ToBase64String(Model.GreetingCardImage)%>" class="img-thumbnail" height="200" width="200" />
                <%}else{ %>
                <img src="../../../../Images/no-thumb.png" class="img-thumbnail" height="200" width="200" />
                <%} %>
            </div>
        </div>
    </div>
<div class="row" style="padding:2px 0;">
    <div class="form-group">
        <label class="col-sm-2 control-label">
            Giftcard Name:
        </label>
        <div class="col-sm-10">
                <%:Html.TextBoxFor(m=>m.GreetingCardName,new{@class="form-control", disabled="disabled"}) %>
        </div>
    </div>
</div>
<h3>Giftcard member list</h3>
<table class="datatable table table-striped" cellspacing="0" width="100%">
    <thead>
        <tr>
            <th>Name</th>
            <th>Email</th>
            <th>Message</th>
        </tr>
    </thead>
    <tbody>
                            
        <%if(Model.TransactionGiftcardMessages.Count>0){ %>
        <%foreach (var i in Model.TransactionGiftcardMessages)
            {%>
          
        <tr>
        <td><%:i.Name %></td>
        <td><%:i.Email %></td>
        <td><%:i.Message %></td>
        <%} %>
        </tr>
            <%}
        else{%>
        <tr>
            <td colspan="3">
                <div class="alert alert-danger">No Record Found</div>

            </td>
        </tr>
        <%} %>
    </tbody>
</table>