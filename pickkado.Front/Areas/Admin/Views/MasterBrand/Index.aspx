<%@ Page Title="" Language="C#" MasterPageFile="~/Areas/Admin/Views/Shared/Admin.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content3" ContentPlaceHolderID="breadcumber" runat="server">
   <li >Dashboard</li>
   <li class="active">Master Brands</li>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<div>
    <div class="page-title">
        <div class="title">Brands</div>
        <div class="description">This is master of your brands. Manage here to show in your front end</div>
        <%if(!string.IsNullOrEmpty(ViewBag.Success)){%>                               
            <div id="message" class="alert alert-success fadeIn animated">
                <a href="#" class="close" data-dismiss="alert">×</a>
                <strong>Success</strong> <%:ViewBag.Success%>
            </div>
        <%} %>
        <%if(!string.IsNullOrEmpty(ViewBag.Error)){%>                               
            <div id="Div1" class="alert alert-danger fadeIn animated">
                <a href="#" class="close" data-dismiss="alert">×</a>
                <strong>Error</strong> <%:ViewBag.Error%>
            </div>
        <%} %>
    </div>
    <div class="row">
        <div class="col-xs-12">
            <div class="card">
                <div class="card-header">
                    <div class="card-title">
                        <div class="title">
                            List
                        </div>
                    </div>
                </div>
                <div class="card-body">
                    <table class="datatable table table-striped fadeInUp animated">
                    <thead>
                      <tr>
                        <th>Brand</th>
                        <th>Updated by</th>
                        <th>Updated date</th>
                          <th></th>
                          <th></th>
                      </tr>
                    </thead>
                    <tbody >
                        <%if(((List<pickkado.Entities.Brand>)ViewBag.List).Count>0){ %>
                        <%foreach( var i in (List<pickkado.Entities.Brand>)ViewBag.List){%>
          
                      <tr>
                        <td><%:i.Name %></td>
                        <td><%:i.UpdatedBy %></td>
                        <td><%:i.UpdatedDate %></td>
                        <td>
                            <a href="<%:Url.Action("edit",new{id=i.Id}) %>" class="btn btn-primary"><span class="icon fa fa-edit"></span>Edit</a></td>
                          <%using (Html.BeginForm("delete", "masterbrand", new { id = i.Id }, FormMethod.Post, new { id = "F" + i.Id }))
                              {%>
                        <td><button type="submit" data-confirm="Are you sure?" data-confirm-title="Warning" form="F<%:i.Id%>" data-target="dataConfirmModal" class="btn btn-default"><span class="icon fa fa-trash"></span> Delete</button></td>
            
                        <%} %>
                      </tr>
                          <%}
                      } else{%>
                        <tr>
                            <td colspan="4">
                                <div class="alert alert-danger">No Record Found</div>

                            </td>
                        </tr>
                        <%} %>
                    </tbody>
                    <tfoot>
                        <tr>
                            <%using(Html.BeginForm("new","masterbrand",FormMethod.Post)){%>
                            <td><input type="text" id="BrandNameFooter" class="form-control" name="Name" placeholder="Brand name" /></td>
                            <td></td>
                            <td></td>
                            <td><button id="addButton" data-loading-text="Loading..." class="btn btn-primary"><span class="icon fa fa-plus"></span> New</button></td>
            
                            <%} %>
            
                        </tr>
                    </tfoot>
                  </table>
                </div>
            </div>
        </div>
    </div>
    
</div>
    
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ScriptContent" runat="server">
    <script>
        var table = $('.datatable').DataTable({
            "dom": '<"top"fl<"clear">>rt<"bottom"ip<"clear">>'
        });
        $('#addButton').on('click', function () {
            var $this = $(this);
            $this.button('loading');
            
            var obj = {
                Name: $("#BrandNameFooter").val()
            };
            $.ajax({
                type: "POST",
                url: '<%: Url.Action("new", "masterbrand")%>',
                dataType: "json",
                data: obj,
                success: function (result) {
                    var linkEdit = '<a href="<%:Url.Action("edit",new{id="parseId"}) %>" class="btn btn-primary"><span class="icon fa fa-edit"></span>Edit</a></td>';
                    linkEdit = linkEdit.replace("parseId", result.Id);
                    table.row.add([                        
                        result.Name,
                        result.UpdatedBy,
                        result.UpdatedDate,
                        linkEdit,
                        null
                    ]).draw();
                    console.log(result);
                    $this.button('reset');
                },
                error: function (err) {
                    $this.button('reset');

                }
            });
        });
    </script>
</asp:Content>


<asp:Content ID="Content5" ContentPlaceHolderID="navBar" runat="server">
    <%Html.RenderAction("login_partial","account"); %>
</asp:Content>