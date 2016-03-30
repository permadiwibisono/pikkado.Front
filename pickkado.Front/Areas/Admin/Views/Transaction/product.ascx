<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<pickkado.Entities.Transaction>" %>
                
<div class="row" style="padding:2px 0;">
    <div class="form-group">
        <label class="col-sm-2 control-label">
            Product Name:
        </label>
        <div class="col-sm-10">
                <%:Html.TextBoxFor(m=>m.ProductName,new{@class="form-control", disabled="disabled"}) %>
        </div>
    </div>
</div>
<div class="row" style="padding:2px 0;">
    <div class="form-group">
        <label class="col-sm-2 control-label">
            Weight(gr):
        </label>
        <div class="col-sm-10">
                <%:Html.TextBoxFor(m=>m.ProductWeight,new{@class="form-control", disabled="disabled"}) %>
        </div>
    </div>
</div>
<div class="row" style="padding:2px 0;">
    <div class="form-group">
        <label class="col-sm-2 control-label">
            Product Description:
        </label>
        <div class="col-sm-10">
                <%:Html.TextAreaFor(m=>m.ProductDescription,new{@class="form-control",rows=3, disabled="disabled"}) %>
        </div>
    </div>
</div>
<div class="row" style="padding:2px 0;">
    <div class="form-group">
        <label class="col-sm-2 control-label">
            Preview:
        </label>
            <div class="col-sm-5">
                <%if(Model.ProductImage!=null){ %>
                <img src="data:image;base64,<%: System.Convert.ToBase64String(Model.ProductImage)%>" class="img-thumbnail" height="200" width="200" />
                <%}else{ %>
                <img src="../../../../Images/no-thumb.png" class="img-thumbnail" height="200" width="200" />
                <%} %>
            </div>
            <div class="col-sm-5">
                <table class="datatable table table-striped" style="text-align:center" cellspacing="0" width="100%">
                <thead>
                    <tr>
                        <th style="text-align:center" colspan="2">Additional Info</th>
                    </tr>
                </thead>
                <tbody>
                            
                    <%if(Model.TransactionProductAttributes.Count>0){ %>
                    <%foreach (var i in Model.TransactionProductAttributes)
                        {%>
          
                    <tr>
                    <td><%:i.Name %></td>
                    <td><%:i.Value %></td>
                    <%} %>
                    </tr>
                        <%}
                    else{%>
                    <tr>
                        <td colspan="2">
                            <div class="alert alert-danger">No Record Found</div>

                        </td>
                    </tr>
                    <%} %>
                </tbody>
            </table>
            </div>
        </div>
    </div>
<div class="row" style="padding:2px 0;">
</div>