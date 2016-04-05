﻿<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<pickkado.Front.Areas.Admin.Models.OnProcessTransactionFilterViewModel>" %>

<%var pagination = ViewBag.Pagination; %>
<div style="padding:10px">
    <%using (Html.BeginForm("tab_onprocess", "transaction", FormMethod.Post, new {@class="form-inline" , id="onProcessForm"})) {%>    
        <div class="row">
            <div class="form-group">
                <label class="control-label">Email</label>
                <%:Html.TextBoxFor(m=>m.Email,new{@class="form-control"}) %>
            </div>
            <div class="form-group">
                <label class="control-label">Vendor Name</label>
                <%:Html.TextBoxFor(m=>m.VendorName,new{@class="form-control"}) %>
            </div>
            <div class="form-group">
                <label class="control-label">Sort by</label>
                <%var list2 = new List<SelectListItem>{
                new SelectListItem{
                    Text="Newest Transaction",
                    Value="0",
                    Selected=Model.SortBy=="0"?true:false
                },
                new SelectListItem{
                    Text="Older Transaction",
                    Value="1",
                    Selected=Model.SortBy=="1"?true:false
                },
                new SelectListItem{
                    Text="Lowest Price",
                    Value="2",
                    Selected=Model.SortBy=="2"?true:false
                },
                new SelectListItem{
                    Text="Highest Price",
                    Value="3",
                    Selected=Model.SortBy=="3"?true:false
                },
                new SelectListItem{
                    Text="Closest Deadline",
                    Value="4",
                    Selected=Model.SortBy=="4"?true:false
                },
                new SelectListItem{
                    Text="Longest Deadline",
                    Value="5",
                    Selected=Model.SortBy=="5"?true:false
                },
                }; %>
            <%:Html.DropDownListFor(m => m.SortBy, list2, new {@class="form-control" })%>
            </div>
            <div class="form-group">
                <a class="btn btn-primary" href="javascript:Search()" >Search</a>
            </div>
                                                
        </div>
      <%} %>

</div>
<table class="datatable table table-striped fadeInUp animated" cellspacing="0" width="100%">
    <thead>
        <tr>
            <th>Id</th>
            <th>Email</th>
            <th>Deadline</th>
            <th>Address</th>
            <th>Total</th>
            <th></th>
        </tr>
    </thead>
    <tbody>
            <%foreach (var item in ViewBag.List)
                {%>
                <tr class="animated">
                    <td style="vertical-align:middle"><%:item.Id %></td>
                    <td style="vertical-align:middle"><%:item.Email %></td>
                    <td style="vertical-align:middle"><%:item.Deadline.ToShortDateString() %></td>
                <td style="vertical-align:middle;max-width:250px;"><%:item.Address %></td>
                    <td style="vertical-align:middle">Rp. <%:item.Total %></td>
                <td style="vertical-align:middle">
                        <button class="btn btn-success btn-confirm" name="<%:item.Id %>">Confirm</button>
                </td>
                    <td style="vertical-align:middle">                        
                        <button class="btn btn-primary btn-details" name="<%:item.Id %>">Details</button>
                    </td>
                </tr>
                <%} %>                      
    </tbody>
</table>
<div class="col-xs-12">
    <div class="row">                                                
        <span class="text-center col-xs-12 pager-show">
            Show <span class="pager-show-from"><%:pagination.StartIndex()+1>pagination.DataCount?pagination.DataCount:pagination.StartIndex()+1 %></span>
                to <span class="pager-show-to"> <%:pagination.EndIndex()%></span>
                of <span class="pager-show-count"><%:pagination.DataCount %></span>
            <span class="pager-show-msg"></span>
        </span>
    </div>
    <ul class = "pager">                
        <li class = "previous  <%:pagination.PrevPage() <= 0 ? "disabled" : "" %>"   ><a href="<%:pagination.PrevPage() <= 0 ?"javascript:void(0)":pagination.PrevPageLink%>"  >&larr; Older</a></li>
        <li class = "next <%: pagination.PageCount()<pagination.NextPage() ? "disabled" : "" %>"><a href="<%:pagination.PageCount()<pagination.NextPage() ?"javascript:void(0)":pagination.NextPageLink%>">Newer &rarr;</a></li>
    </ul>
</div>
<script>
    function Search() {
        $.post('/admin/transaction/tab_onprocess', $('#onProcessForm').serialize(), function (data) {
            if(data)
                $('#list .card-body').html(data);
        });
    }
</script>
