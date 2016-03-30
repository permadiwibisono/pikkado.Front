<%@ Page Title="" Language="C#" MasterPageFile="~/Areas/Admin/Views/Shared/Admin.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        [data-toggle="collapse"] {
          cursor: pointer;
        }
        .parent-expanded {
          display: none;
  
        }
        .parent-collapsed {
        }

        .collapsed .parent-expanded {
          display: inline-block;
        }
        .collapsed .parent-collapsed {
          display: none;
        }
    </style>
<div>
    <div class="page-title">
        <div class="title">
            Category
        </div>
        <div class="description">
            this is master category of your product to sale.
        </div>        
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
        <div id="filter-sidebar" class="col-xs-6 col-sm-2 visible-sm visible-md visible-lg">
            <ul style="list-style:none;padding:0px;">
                <%:Html.Raw(ViewBag.Filter) %>
                <li>
                    <a href="#" class="link link-default" >Parent</a>
                    <a class="collapsed" data-toggle="collapse" data-target="#group-2">                        
                        <i class="fa fa-fw fa-minus-square parent-collapsed"></i>
                        <i class="fa fa-fw fa-plus-square parent-expanded"></i>
                    </a>
                    <div id="group-2" aria-expanded="false" class="collapse">
                        <ul style="list-style:none;padding:0px 10px;">
                            <li>
                                <a href="#" class="link link-default">Child</a>
                            </li>
                            <li>
                                <a href="#" class="link link-default">Child</a>
                            </li>
                        </ul>
                    </div>
                </li>
                <li>
                    <a href="#" class="link link-default">Parent</a>
                </li>
                <li>
                    <a href="#" class="link link-default">Parent</a>
                </li>
            </ul>
        </div>
        <div class="col-xs-10">
            <div class="card">
                <div class="card-header">
                    <div class="card-title">
                        <div class="title">List</div> 
                    </div>
                </div>
                <div class="card-body">
                    <table class="table table-striped fadeInUp animated">
                    <thead>
                      <tr>
                        <th>Name</th>
                        <th>ImageUrl</th>
                        <th>Updated by</th>
                        <th>Updated date</th>
                      </tr>
                    </thead>
                    <tbody>
                        <%if(((List<pickkado.Entities.Category>)ViewBag.List).Count>0){ %>
                        <%foreach (var i in (List<pickkado.Entities.Category>)ViewBag.List)
                          {%>
          
                      <tr>
                        <td><%:i.Name %></td>
                        <td><%:i.ImageUrl %></td>
                        <td><%:i.UpdatedBy %></td>
                        <td><%:i.UpdatedDate %></td>
                        <td>
                            <a href="<%:Url.Action("edit","mastercategory",new{id=i.Id}) %>" class="btn btn-primary"><span class="icon fa fa-edit"></span>Edit</a></td>
                        <%using (Html.BeginForm("delete", "mastercategory", new { id = i.Id }, FormMethod.Post, new { id = "F"+i.Id }))
                              {%>
                        <td><button type="submit" class="btn btn-default" data-confirm="Are you sure?" data-confirm-title="Warning" form="F<%:i.Id%>" data-target="dataConfirmModal" ><span class="icon fa fa-trash"></span> Delete</button></td>
            
                        <%} %>
                      </tr>
                          <%}
                      } else{%>
                        <tr>
                            <td colspan="6">
                                <div class="alert alert-danger">No Record Found</div>

                            </td>
                        </tr>
                        <%} %>
                    </tbody>
                    <tfoot>
                        <tr>
                            <%using(Html.BeginForm("new","mastercategory",FormMethod.Post)){%>
                            <td><input type="text" class="form-control" name="Name" placeholder="Category name"/></td>
                            <td><input type="text" class="form-control" name="ImageUrl" placeholder="Image icon url"/></td>
                            <td></td>
                            <td></td>
                            <td><button type="submit" class="btn btn-primary"><span class="icon fa fa-plus"></span> New</button></td>
            
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

<asp:Content ID="Content3" ContentPlaceHolderID="breadcumber" runat="server">
   <li >Dashboard</li>
   <li class="active">Master Categories</li>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="navBar" runat="server">
    <%Html.RenderAction("login_partial","account"); %>
</asp:Content>
