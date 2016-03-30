<%@ Page Title="" Language="C#" MasterPageFile="~/Areas/Vendor/Views/Shared/Vendor.Master" Inherits="System.Web.Mvc.ViewPage<pickkado.Front.Areas.Vendor.Models.NewProductViewModel>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div id="message">

    </div>
    <div class="page-title">
        <span class="title"></span>
        <div class="description"></div>
    </div>
    <div class="row">
        <div class="col-xs-12">
            <div class="card">
                <div class="card-body no-padding">
                    <div role="tabpanel">
                        <!-- Nav tabs -->
                        <ul class="nav nav-tabs" role="tablist">
                            <li role="presentation" class="active"><a href="#properties" aria-controls="list" role="tab" data-toggle="tab">Properties</a></li>
                            <li role="presentation"><a href="#thumbnail" aria-expanded="true" aria-controls="profile" role="tab" data-toggle="tab">Thumbnail</a></li>
                            <li role="presentation"><a href="#attribute" aria-controls="user" role="tab" data-toggle="tab">Product Attribute</a></li>
                        </ul>
                        <!-- Tab panes -->
                        <div class="tab-content">
                            <div role="tabpanel" class="tab-pane active" id="properties">                        
                                <div class="card">
                                    <div class="card-header">
                                        <div class="card-title">
                                        <div class="title">Product's Properties</div>
                                        </div>
                                    </div>
                                    <div class="card-body">
                                        <div class="container-fluid">
                                            <% using (Html.BeginForm("edit", "product", new {id=ViewContext.RouteData.Values["id"] }, FormMethod.Post, new { @class = "form-horizontal" }))
                                               { %>
                                            <%: Html.AntiForgeryToken()%>
                                            <div class="form-group">
                                                <%:Html.LabelFor(m => m.Name, new { @class = "col-sm-2 control-label" })%>
                                                <div class="col-sm-10">
                                                    <%:Html.TextBoxFor(m => m.Name, new { @class = "col-sm-2 form-control", placeholder = "Name" })%>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <%:Html.LabelFor(m => m.Weight, new { @class = "col-sm-2 control-label" })%>
                                                <div class="col-sm-10">
                                                    <%:Html.TextBoxFor(m => m.Weight, new { @class = "col-sm-2 form-control", placeholder = "Weight" })%>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <%:Html.LabelFor(m => m.Description, new { @class = "col-sm-2 control-label" })%>
                                                <div class="col-sm-10">
                                                    <%:Html.TextAreaFor(m => m.Description, new { @class = "col-sm-2 form-control", placeholder = "Description", rows = "5" })%>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <%:Html.LabelFor(m => m.Gender, new { @class = "col-sm-2 control-label" })%>
                                                <div class="col-sm-10">
                                                    <%:Html.TextBoxFor(m => m.Gender, new { @class = "col-sm-2 form-control", placeholder = "Gender" })%>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <%:Html.LabelFor(m => m.Price, new { @class = "col-sm-2 control-label" })%>
                                                <div class="col-sm-10">
                                                    <%:Html.TextBoxFor(m => m.Price, new { @class = "col-sm-2 form-control", placeholder = "Price" })%>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <%:Html.LabelFor(m => m.Category, new { @class = "col-sm-2 control-label" })%>
                                                <div class="col-sm-10">
                                                    <%var CatList = (List<pickkado.Entities.Category>)ViewBag.CategoryList;
                                                      var CatNameList = ViewBag.CategoryNameList;
                                                      var List = new List<SelectListItem>();
                                                      for (int i = 0; i < CatList.Count; i++)
                                                      {
                                                          List.Add(new SelectListItem
                                                          {
                                                              Text = CatNameList[i],
                                                              Value = CatList[i].Id.ToString(),
                                                              Selected = Model.Category == CatList[i].Id ? true : false
                                                          });
                                                      }
                                                       %>
                                                    <%:Html.DropDownListFor(m => m.Category, List, new { @class = "col-sm-2 form-control" })%>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <div class="col-xs-offset-2 col-lg-1">
                                                    <a href="<%:Url.Action("index")%>" class="btn btn-default"><span class="icon fa fa-arrow-left"></span> Back</a>
                                                </div>
                                                <div class="col-lg-1">
                                                    <button type="submit" class="btn btn-primary"><span class="icon fa fa-plus"></span> Save</button>   
                                                </div>

                                            </div>
                                            <%} %>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div role="tabpanel" class="tab-pane" id="thumbnail">
                                <div class="card">
                                    <div class="card-header">
                                        <div class="card-title">
                                        <div class="title">Thumbnail</div>
                                        </div>
                                    </div>
                                    <div class="card-body">
                                        <div class="row" id="list">
                                            <div class="col-xs-12">
                                                <div class="input-group">
                                                    <% using (Html.BeginForm("uploadphoto", "product", new { id = ViewContext.RouteData.Values["id"] }, FormMethod.Post, new { id = "UploadPhotoForm" ,@enctype = "multipart/form-data" }))
                                                       { %>
                                                    <%: Html.AntiForgeryToken()%>                                                    
                                                    <label for="file-upload" class="btn btn-default custom-file-upload">
                                                        <i class="fa fa-file-image-o"></i> Browse
                                                    </label>
                                                    <input id="file-upload" type="file" name="photo"/>
                                                    <button id="uploadPhoto" class="btn btn-primary"> <i class="fa fa-cloud-upload"></i> Upload Photo</button>
                                                    <%}%>
                                                </div>
                                            </div>
                                        <%foreach (var i in ViewBag.ProductThumbnail)
                                            { %>
                                                     
                                                <div class="photo-item col-xs-6 col-md-3 fadeIn animated" id="<%:i.Id %>"> 
                                                    <button class="remove-photo btn btn-danger" >
                                                        <span class="fa fa-remove"></span>
                                                    </button>
                                                    <img src="data:image;base64,<%: System.Convert.ToBase64String(i.Image)%>"  class="img-responsive"/> 
                                                </div>
                                            
                                                      
                                            <%} %>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div role="tabpanel" class="tab-pane" id="attribute">
                                <div class="card">
                                    <div class="card-header">
                                        <div class="card-title">
                                        <div class="title">Product's Attribute</div>
                                        </div>
                                    </div>
                                    <div class="card-body">
                                        <div class="container-fluid"> 
                                            <div class="modal fade " id="newAttributeModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                                                <div class="modal-dialog modal-md">
                                                    
                                                </div>
                                              </div>
                                            <div class="col-xs-12">
                                                <div class="input-group">
                                                    <button id="newAttribute" class="btn btn-primary"> <i class="fa fa-plus"></i> New</button>
                                                </div>
                                            </div>                                           
                                            <table class="datatable table table-striped fadeInUp animated" id="attributeList">
                                            <thead>
                                              <tr>
                                                <th>Type</th>
                                                <th>Value</th>
                                                <th>Disabled</th>
                                                 <th></th>
                                              </tr>
                                            </thead>
                                            <tbody>
                                                
                                                <%if (ViewBag.AttributeList.Count > 0)
                                                  { %>
                                                <%foreach (var i in ViewBag.AttributeList)
                                                  {%>
                                                        <tr class="animated">
                                                            <td><%:i.master.Name%></td>
                                                            <td><%:i.Value%></td>
                                                            <td><input type="checkbox" <%:i.Disabled ? "checked" : ""%> disabled /></td>
                                                            <td>                                                                
                                                                <button id="EDIT<%:i.Id%>" class="edit-attribute btn btn-primary" >
                                                                    <i class="fa fa-edit"></i>
                                                                </button>
                                                            </td>
                                                            <td>
                                                                <% using (Html.BeginForm("deleteattribute", "product", new { id = i.Id }, FormMethod.Post, new { @class = "form-horizontal", @enctype = "multipart/form-data" }))
                                                                   { %>
                                                                <%: Html.AntiForgeryToken()%>
                                                                    <button class="remove-attribute btn btn-default" onclick="return confirm('Are you sure?');">
                                                                        <i class="fa fa-trash"></i>
                                                                    </button>
                                                                <%} %>
                                                            </td>
                                                        </tr>
                                                    <%}
                                                  }%>
                                            </tbody>
                                          </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>


</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="breadcumber" runat="server">
   <li>Dashboard</li>
   <li>My Product</li>
   <li class="active">Edit</li>
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ScriptContent" runat="server">
    <script>
        //source:http://stackoverflow.com/questions/18999501/bootstrap-3-keep-selected-tab-on-page-refresh
        $("ul.nav-tabs > li > a").on("shown.bs.tab", function (e) {
            var id = $(e.target).attr("href");
            localStorage.setItem('selectedTab', id)
        });
        var selectedTab = localStorage.getItem('selectedTab');
        $('ul[role="tablist"] a[href="' + selectedTab + '"]').tab('show');
    </script>
    <style>
        input[type="file"] {
            display: none;
        }
        .custom-file-upload {
            border: 1px solid #ccc;
            display: inline-block;
            padding: 6px 12px;
            cursor: pointer;
        }
        .remove-photo {
            position:absolute;
            z-index:5;
            right:25px;
        }
        .photo-item {
            padding-bottom:15px;
        }
    .square {
        position: relative;
        width: 100%;
        height: 230px;
        overflow: hidden;    
    }
    .square .img-landscape {
      position: absolute;
      left: 50%;
      top: 50%;
      height: auto;
      width: 100%;
      -webkit-transform: translate(-50%,-50%);
          -ms-transform: translate(-50%,-50%);
              transform: translate(-50%,-50%);
}
    .square .img-portait {
      position: absolute;
      left: 50%;
      top: 50%;
      height: 100%;
      width: auto;
      -webkit-transform: translate(-50%,-50%);
          -ms-transform: translate(-50%,-50%);
              transform: translate(-50%,-50%);
}
    </style>
    <script src="../../../../Scripts/jquery.form.js"></script>
    <script>
        //tab thumbnail
        if ($('#list .photo-item').length >= 4) {
            $('#uploadPhoto').attr('disabled', 'disabled');
        }
        $('#uploadPhoto').click(function () {
            var options = {
                success: function (data) {
                    console.log(data);
                    if (data.IsError == true) {
                        var message = '<div class="alert alert-danger fadeIn animated">' +
                                        '<a href="#" class="close" data-dismiss="alert">×</a>' +
                                        '<strong>Error</strong> <span class="body">' + data.Message + '</span>' +
                                        '</div>';
                        $('#message').html(message);
                    } else {
                        var message = '<div class="alert alert-success fadeIn animated">' +
                        '<a href="#" class="close" data-dismiss="alert">×</a>' +
                        '<strong>Success</strong> <span class="body">' + data.Message + '</span>' +
                        '</div>';
                        $('#message').html(message);
                        var item = '<div class="photo-item col-xs-6 col-md-3 fadeIn animated" id="'+data.Id+'"> '+
                                        '<button class="remove-photo btn btn-danger" >'+
                                            '<span class="fa fa-remove"></span>'+
                                        '</button>'+
                                        '<img src="'+data.Photo+'"  class="img-responsive"/>'+ 
                                    '</div>'
                        $("#list").append(item);
                        if ($('#list .photo-item').length >= 4) {
                            $('#uploadPhoto').attr('disabled', 'disabled');
                        }
                        $('#UploadPhotoForm').clearForm();
                    }
                },
                error: function (err) {
                    alert(err.statusText);
                }
            };
            $('#UploadPhotoForm').ajaxForm(options);
        });
        //something error when after append click method not triggered when use $('.remove-photo').click
        $(document).on('click', '.remove-photo', function (e) {
            
            var parent = $(this).parent();
            var get = parent.attr('id');
            $.ajax({
                type: "POST",
                url: '/vendor/product/deletephoto/' + get,
                dataType: "json",
                success: function (data) {
                    console.log(data);
                    if (data.IsError == true) {
                        var message = '<div class="alert alert-danger fadeIn animated">' +
                                        '<a href="#" class="close" data-dismiss="alert">×</a>' +
                                        '<strong>Error</strong> <span class="body">' + data.Message + '</span>' +
                                        '</div>';
                        $('#message').html(message);
                    } else {
                        parent.removeClass('fadeIn');
                        parent.addClass('fadeOut');
                        var message = '<div class="alert alert-success fadeIn animated">' +
                        '<a href="#" class="close" data-dismiss="alert">×</a>' +
                        '<strong>Success</strong> <span class="body">' + data.Message + '</span>' +
                        '</div>';
                        $('#message').html(message);
                        setTimeout(function () {
                            parent.remove();
                            if ($('#list .photo-item').length < 4) {
                                $('#uploadPhoto').removeAttr('disabled');
                            }
                        }, 1000);
                    }
                },
                error: function (err) {
                    alert(err.statusText);

                }
            });
        });
        //$(function () {
        //    if ($('.square').find('img').width() > $('.square').find('img').height())
        //        return $('.square').find('img').addClass('img-landscape');
        //    return $('.square').find('img').addClass('img-portait');;
        //});

        //tab attribute
        $(document).on('click', '.remove-attribute', function () {
            var form = $(this).parent('form');
            var options = {
                success: function (data) {
                    console.log(data);
                    if (data.IsError == true) {
                        var message = '<div class="alert alert-danger fadeIn animated">' +
                                        '<a href="#" class="close" data-dismiss="alert">×</a>' +
                                        '<strong>Error</strong> <span class="body">' + data.Message + '</span>' +
                                        '</div>';
                        $('#message').html(message);
                    } else {
                        var message = '<div class="alert alert-success fadeIn animated">' +
                        '<a href="#" class="close" data-dismiss="alert">×</a>' +
                        '<strong>Success</strong> <span class="body">' + data.Message + '</span>' +
                        '</div>';
                        $('#message').html(message);
                        var tr = form.parents('tr:first');
                        console.log(tr);
                        tr.addClass('fadeOut animated');
                        setTimeout(function () {
                            tr.remove();
                        }, 1000);
                    }
                },
                error: function (err) {
                    alert(err.statusText);
                }
            };
            form.ajaxForm(options);
        });
        $('#newAttribute').click(function () {
            $.get('/vendor/product/newattribute/<%:ViewContext.RouteData.Values["id"]%>',
            function (data) {
                $("#newAttributeModal .modal-dialog").html(data);
                $('#newAttributeModal').modal({ show: true });
            });
        });
        $(document).on('click', '.remove-attribute', function () {
            var form = $(this).parent('form');
            var options = {
                success: function (data) {
                    console.log(data);
                    if (data.IsError == true) {
                        var message = '<div class="alert alert-danger fadeIn animated">' +
                                        '<a href="#" class="close" data-dismiss="alert">×</a>' +
                                        '<strong>Error</strong> <span class="body">' + data.Message + '</span>' +
                                        '</div>';
                        $('#message').html(message);
                    } else {
                        var message = '<div class="alert alert-success fadeIn animated">' +
                        '<a href="#" class="close" data-dismiss="alert">×</a>' +
                        '<strong>Success</strong> <span class="body">' + data.Message + '</span>' +
                        '</div>';
                        $('#message').html(message);
                        var tr = form.parents('tr:first');
                        console.log(tr);
                        tr.addClass('fadeOut animated');
                        setTimeout(function () {
                            tr.remove();
                        }, 1000);
                    }
                },
                error: function (err) {
                    alert(err.statusText);
                }
            };
            form.ajaxForm(options);
        });

        $('#newAttribute').click(function () {
            $.get('/vendor/product/newattribute/<%:ViewContext.RouteData.Values["id"]%>',
            function (data) {
                $("#newAttributeModal .modal-dialog").html(data);
                $('#newAttributeModal').modal({ show: true });
            });
        });
        $(document).on('click', '.edit-attribute', function () {
            //alert('a');
            var id = $(this).attr('id').replace('EDIT','');
            $.get('/vendor/product/editattribute/' + id,
            function (data) {
                $("#newAttributeModal .modal-dialog").html(data);
                $('#newAttributeModal').modal({ show: true });
            });
        });

        $('#newAttribute').on('hidden.bs.modal', function (e) {
            $("#newAttributeModal .modal-dialog").html('');
            // do something...
        });
    </script>
</asp:Content>
