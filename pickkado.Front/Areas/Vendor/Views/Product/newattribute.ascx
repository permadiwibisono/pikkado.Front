<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<pickkado.Front.Areas.Vendor.Models.NewAttributeViewModel>" %>
<div class="modal-content">
        
<% using (Html.BeginForm("newattribute", "product", new {id=ViewContext.RouteData.Values["id"] }, FormMethod.Post, new { @class = "form-horizontal", @enctype = "multipart/form-data", id="newAttributeForm" }))
   { %>
<%: Html.AntiForgeryToken()%>
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">New Attribute</h4>
    </div>
    <div class="modal-body">
        <div class="container-fluid">
            <div class="row">        
                <%:Html.LabelFor(m => m.AttributeId, new { @class = "col-sm-2 control-label" })%>
                <div class="col-sm-10">
                    <%
       var list = new List<SelectListItem>();
       foreach (var i in ViewBag.MasterList)
       {
           list.Add(new SelectListItem
           {
               Text = i.Name,
               Value = i.Id
           });
       }
                    %>
                    <%:Html.DropDownListFor(m => m.AttributeId, list, new { @class = "form-control", placeholder = "Attribute Id" })%>
                </div>
            </div>
            <div class="row">        
                <%:Html.LabelFor(m => m.Values, new { @class = "col-sm-2 control-label" })%>
                <div class="col-sm-10">
                    <%:Html.TextBoxFor(m => m.Values, new { @class = "col-sm-2 form-control", placeholder = "Values" })%>
                </div>
            </div>
            <div class="row">
                <div class="col-sm-offset-2 col-sm-10">
                    <label class="checkbox">
                        <%:Html.CheckBoxFor(m => m.Disabled)%>
                        Disabled
                    </label>
                </div>
            </div>
        </div>                                                            
    </div>
    <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
        <button type="button" id="Save" class="btn btn-primary">Save</button>
    </div>
    <%}%>
</div>
<script>
    $('#Save').click(function () {
        //console.log($(this).parents('form'));
        var form = $(this).parents('form');
        var url = form.attr('action');
        console.log(url);
        //$('#newAttributeForm').ajaxForm(options);
        $.ajax({
            type: "POST",
            url: url,
            data:form.serialize(),
            dataType: "json",
            success: function (data) {
                console.log(data);
                if (data.IsError == true) {
                    alert(data.Message);
                    console.log(data);
                    $("#newAttributeModal .modal-dialog").html(data.HTMLString);
                } else {
                    var message = '<div class="alert alert-success fadeIn animated">' +
                    '<a href="#" class="close" data-dismiss="alert">×</a>' +
                    '<strong>Success</strong> <span class="body">' + data.Message + '</span>' +
                    '</div>';
                    $('#message').html(message);
                    console.log(data);
                    $("#newAttributeModal").modal('hide');
                    var checked = '';
                    if (data.Obj.Disabled)
                        checked = 'checked';
                    var row = '<tr class="fadeIn">' +
                                '<td>' + data.Obj.Type + '</td>' +
                                '<td>' + data.Obj.Value + '</td>' +
                                '<td><input disabled="" type="checkbox" ' + checked + '></td>' +
                                '<td>' +
                                    '<button id="EDIT' + data.Obj.Id + '" class="edit-attribute btn btn-primary" >' +
                                        '<i class="fa fa-edit"></i>' +
                                    '</button>' +
                                '</td>' +
                                '<td>' +
                                '<form action="/vendor/product/deleteattribute/' + data.Obj.Id + '" class="form-horizontal" enctype="multipart/form-data" method="post">' +
                                '<button class="remove-attribute btn btn-default" onclick="return confirm(\'Are you sure?\');">' +
                                        '<i class="fa fa-trash"></i>' +
                                    '</button>' +
                                '</form>' +
                            '</td>' +
                            '</tr>';
                    $('#attributeList tbody').append(row);
                }
            },
            error: function (err) {
                alert(err.statusText);
            }
        });
        
    });
</script>