<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<pickkado.Front.Areas.Vendor.Models.PopupProductDetailsViewModel>" %>

<%@ Import Namespace="pickkado.Front" %>
<div class="modal-content">
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Details</h4>
    </div>
    <div class="modal-body">
        <div class="card">
            <%--<div class="card-header">
                <div class="card-title">
                <div class="title">Product info</div>
                </div>
            </div>--%>
            <div class="card-body">
                <div class="container-fluid form-horizontal">
                    
                    <div class="row" style="padding:2px 0;">
                        <div class="form-group">
                            <label class="col-sm-3 control-label">
                                Product Name:
                            </label>
                            <div class="col-sm-9">
                                    <%:Html.TextBoxFor(m=>m.ProductName,new{@class="form-control", disabled="disabled"}) %>
                            </div>
                        </div>
                    </div>
                    <div class="row" style="padding:2px 0;">
                        <div class="form-group">
                            <label class="col-sm-3 control-label">
                                Weight(gr):
                            </label>
                            <div class="col-sm-9">
                                    <%:Html.TextBoxFor(m=>m.ProductWeight,new{@class="form-control", disabled="disabled"}) %>
                            </div>
                        </div>
                    </div>
                    <div class="row" style="padding:2px 0;">
                        <div class="form-group">
                            <label class="col-sm-3 control-label">
                                Product Description:
                            </label>
                            <div class="col-sm-9">
                                    <%:Html.TextAreaFor(m=>m.ProductDescription,new{@class="form-control",rows=3, disabled="disabled"}) %>
                            </div>
                        </div>
                    </div>
                    <div class="row" style="padding:2px 0;">
                        <div class="form-group">
                            <label class="col-sm-3 control-label">
                                Preview:
                            </label>
                                <div class="col-sm-4">
                                    <%if(Model.Image!=null){ %>
                                    <img src="data:image;base64,<%: System.Convert.ToBase64String(Model.Image)%>" class="img-thumbnail" height="200" width="200" />
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
                            
                                        <%if(Model.ProdutAttributeList.Count>0){ %>
                                        <%foreach (var i in Model.ProdutAttributeList)
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
                        <div class="form-group">
                            <label class="col-sm-3 control-label">
                                Product Price:
                            </label>
                            <div class="col-sm-9">
                                <%:Html.TextBoxFor(m=>m.PriceToRupiah,new{@class="form-control", disabled="disabled"}) %>
                            </div>
                        </div>
                    </div>
                    <div class="row" style="padding:2px 0;">
                        <div class="form-group">
                            <label class="col-sm-3 control-label">
                                Discount:
                            </label>
                            <div class="col-sm-9">
                                <%:Html.TextBoxFor(m=>m.DiscountProductToRupiah,new{@class="form-control", disabled="disabled"}) %>
                            </div>
                        </div>
                    </div>
                    <div class="row" style="padding:2px 0;">
                        <div class="form-group">
                            <label class="col-sm-3 control-label">
                                Total:
                            </label>
                            <div class="col-sm-9">
                                <%:Html.TextBoxFor(m=>m.TotalToRupiah,new{@class="form-control", disabled="disabled"}) %>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>                                                 
    </div>
    <div class="modal-footer">
    </div>
</div>