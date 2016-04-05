<%@ Page Title="" Language="C#" MasterPageFile="~/Areas/Vendor/Views/Shared/Vendor.Master" Inherits="System.Web.Mvc.ViewPage<pickkado.Front.Areas.Vendor.Models.NewProductViewModel>" %>

<asp:Content ID="Content5" ContentPlaceHolderID="navBar" runat="server">
    <%Html.RenderAction("login_partial","account"); %>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <% using (Html.BeginForm("new", "product", FormMethod.Post, new {@class="form-horizontal" }))
       { %>
    <%: Html.AntiForgeryToken()%>
    <div class="page-title">
        <%if(!string.IsNullOrEmpty(ViewBag.Success)){%>                               
        <div id="Div2" class="alert alert-success fadeIn animated">
            <a href="#" class="close" data-dismiss="alert">×</a>
            <strong>Success</strong> <%:ViewBag.Success%>
        </div>
        <%} %>
        <%if(!string.IsNullOrEmpty(ViewBag.Error)){%>                               
            <div id="Div3" class="alert alert-danger fadeIn animated">
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
                        <span class="title">New</span>
                        <div class="description">Create a new product</div>
                    </div>
                </div>
                <div class="card-body">
                    <div class="form-group">
                        <%:Html.LabelFor(m=>m.Name,new{@class="col-sm-2 control-label"}) %>
                        <div class="col-sm-10">
                            <%:Html.TextBoxFor(m=>m.Name,new{@class="col-sm-2 form-control",placeholder="Name"}) %>
                        </div>
                    </div>
                    <div class="form-group">
                        <%:Html.LabelFor(m=>m.Weight,new{@class="col-sm-2 control-label"}) %>
                        <div class="col-sm-10">
                            <%:Html.TextBoxFor(m=>m.Weight,new{@class="col-sm-2 form-control",placeholder="Weight"}) %>
                        </div>
                    </div>
                    <div class="form-group">
                        <%:Html.LabelFor(m=>m.Description,new{@class="col-sm-2 control-label"}) %>
                        <div class="col-sm-10">
                            <%:Html.TextAreaFor(m=>m.Description,new{@class="col-sm-2 form-control",placeholder="Description",rows="5"}) %>
                        </div>
                    </div>
                    <div class="form-group">
                        <%:Html.LabelFor(m=>m.Gender,new{@class="col-sm-2 control-label"}) %>
                        <div class="col-sm-10">
                            <%:Html.TextBoxFor(m=>m.Gender,new{@class="col-sm-2 form-control",placeholder="Gender"}) %>
                        </div>
                    </div>
                    <div class="form-group">
                        <%:Html.LabelFor(m=>m.Price,new{@class="col-sm-2 control-label"}) %>
                        <div class="col-sm-10">
                            <%:Html.TextBoxFor(m=>m.Price, new{@class="col-sm-2 form-control", placeholder="Price"}) %>
                        </div>
                    </div>
                    <div class="form-group">
                        <%:Html.LabelFor(m=>m.Category,new{@class="col-sm-2 control-label"}) %>
                        <div class="col-sm-10">
                            <%var CatList = (List<pickkado.Entities.Category>)ViewBag.CategoryList;
                              var CatNameList = ViewBag.CategoryNameList;
                              var List = new List<SelectListItem>();
                              for (int i=0;i<CatList.Count;i++)
                              {
                                  List.Add(new SelectListItem { 
                                    Text=CatNameList[i],
                                    Value = CatList[i].Id.ToString()
                                  });
                              }
                               %>
                            <%:Html.DropDownListFor(m=>m.Category,List,new{@class="col-sm-2 form-control"}) %>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-xs-offset-2 col-lg-1">
                            <a href="<%:Url.Action("index") %>" class="btn btn-default"><span class="icon fa fa-arrow-left"></span> Back</a>
                        </div>
                        <div class="col-lg-1">
                            <button type="submit" class="btn btn-primary"><span class="icon fa fa-plus"></span> Save</button>   
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="container-fluid" style="padding:15px 0px;">
    </div>
    <%} %>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="breadcumber" runat="server">
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ScriptContent" runat="server">
</asp:Content>
