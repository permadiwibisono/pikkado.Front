<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site1.Master" Inherits="System.Web.Mvc.ViewPage<pickkado.Front.Models.ProductDetailCatalogViewModel>" %>

<asp:Content ID="resultDetailsTitle" ContentPlaceHolderID="TitleContent" runat="server">
    <%:ViewBag.Title %>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="navBar" runat="server">
    <%Html.RenderAction("login_partial","account"); %>
</asp:Content>
<asp:Content ContentPlaceHolderID="breadcumb" runat="server">
    <li><a href="/">Home</a></li>
    <li><a href="/catalog/views">Catalog</a> </li>
    <li class="active"><%:ViewBag.Title %></li>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container-fluid title-underline">
        <span class="font-avant" style="font-size:15px">
            Details
        </span>
    </div>

    <% using (Html.BeginForm())
       { %>
        <%: Html.AntiForgeryToken()%>    
        <% if (ViewData.ModelState.Any(x => x.Value.Errors.Any()))
           {%>
                <div id="message" class="alert alert-danger form-message">
                    <a href="#" class="close" data-dismiss="alert">×</a>
                    <%: Html.ValidationSummary("", new { @class = "validation-summary-custom" })%>
                </div>
            <% }%>
        <div class="container-fluid" style="padding:15px 0px;">
            <div class="row">
                <%var product = ViewBag.Product;%>
                <div class="col-xs-12 col-sm-6 col-md-4">
                    <div class="col-xs-12">
                        <div class="thumbnail zoom">
                            <%:Html.HiddenFor(m => m.ProductId)%>
                            <%if (product.Thumbnail.Count > 0) %>
                            <%{
                                    %>                                    
                                <img class="img-responsive" src="data:image;base64,<%: System.Convert.ToBase64String(product.Thumbnail[0])%>"  />
                                <%}
                              else
                              {%>
                                <img class="img-responsive" src="../../Images/no-thumb.png" />
                                    
                                <%} %>   
                        </div>
                    </div>
                    <%foreach (var item in product.Thumbnail)
                      { %>                    
                        <div class="col-xs-3 thumb" style="padding:5px; ">
                            <img  class="img-responsive" src="data:image;base64,<%: System.Convert.ToBase64String(item)%>" />
                        </div>
                    <%} %>
                </div>
                <div class="col-xs-12 col-sm-6 col-md-8">
                    <h3 class="font-helvetica"><%:product.Name%></h3>
                    <h5 class="font-helvetica"><%:product.Price%></h5>
                    <div style="border:1px solid #D2CCC7;display:none; height:auto;min-height:100px; padding:10px; margin-bottom:10px">
                        <h4 class="font-helvetica">Rules</h4>
                    </div>
                    <div style="border:1px solid #D2CCC7;height:auto;min-height:100px; padding:10px; margin-bottom:10px" class="col-xs-12">
                        <h4 class="font-helvetica">Description</h4>
                        <p style="white-space:pre-line">
                            <%:product.Description%>
                        </p>
                    </div>
                    <div style="border:1px solid #D2CCC7;height:auto;min-height:100px; padding:10px; margin-bottom:10px" class="col-xs-12">
                        <% 
                       for (int i = 0; i < product.MasterAttributeList.Count; )
                       {
                           var master = product.MasterAttributeList[i];
                          %>
                        
                        <div class="col-xs-12" style="padding:10px 0px;">
                            <h5 class="font-helvetica">Choose a <%:master.Name%></h5>
                            <div class="box-size">

                                <ul class="list-inline">
                                    <%:Html.Hidden("AttributeSelected[" + i + "]", Model.AttributeSelected[i])%>
                                    <%foreach (var child in product.AttributeProductList)
                                      {
                                          if (child.MasterAttributeId == master.Id)
                                          { %>
                                    <li class="<%:child.Disabled ? "disabled" : "clickable"%> <%:Model.AttributeSelected != null && Model.AttributeSelected.Count > 0 && Model.AttributeSelected[i] == child.Value ? " box-size-selected" : ""%>">
                                        <div id="<%:child.Value%>" data-bind-name="#AttributeSelected_<%:i%>_" ><%:child.Disabled ? Html.Raw("<s>" + child.Text + "</s>") : child.Text%></div>
                                        
                                    </li>
                                        <%
                                          }
                                      }%>
                                </ul>
                            </div>
                        </div>                              
                            <%  i++;
           } %>
                    </div>
                </div>

            </div>
            <div class="row" style="margin:30px 0px 30px 0px;padding:10px 0px;">
                <div class="col-xm-2 col-sm-2 col-md-2 col-lg-2">
                    <a href="/catalog/views"  class="btn btn-lg btn-block btn-login"> <img src="../../images/icon/PanahBackIcon.png" class="lefticon"/> Back</a>
                </div>
                <div class="col-xm-offset-7 col-xm-3 col-sm-offset-7 col-sm-3 col-md-offset-7 col-md-3 col-lg-offset-7 col-lg-3" >
                    <button type="submit" class="btn btn-lg btn-block btn-login"> Next <img src="../../images/icon/PanahNextIcon.png" class="righticon"/> </button>
                </div>
            </div>
        </div>
    <% } %>
</asp:Content>

<asp:Content ID="scriptsContent" ContentPlaceHolderID="ScriptsSection" runat="server">
    <%: Scripts.Render("~/bundles/jqueryval") %>
    <style>
        .box-size {
            
        }
        .box-size ul{
            list-style:none;
        }
        .box-size li{
            padding:5px 15px; 
            border:1px solid #CECCCC; 
            margin-left:5px;
            margin-bottom:5px;
            transition:all ease-in 0.2s;
        }
        .box-size li.clickable:hover{
            background-color:#5DB194;
            color:white;
            opacity:0.9;
            cursor:pointer;
            transition:all ease-in 0.2s;
        }
        .box-size li.disabled{
            background-color:rgba(0,0,0,0.1);
        }
        .box-size li.disabled:hover{
            cursor:not-allowed;
        }
        .box-size-selected{
            background-color:#5DB194;
            color:white;
        }

        .childImage:hover {
            cursor:pointer;
        }
        
        .thumb {
            cursor:pointer;
        }
        .thumb.img-selected {
            border:1px solid #5DB194;
        }
        .zoom:hover {
           cursor:crosshair;
        }
    </style>
    <script>
        $('.list-inline li.clickable').click(function () {
            //alert('a');
            var parent = $(this).parent();
            parent.find('li.clickable').removeClass('box-size-selected');
            $(this).addClass('box-size-selected');
            var target = $(this).find('div').attr('data-bind-name');
            $(target).val($(this).find('div').attr('id'));
            //$('#PackageId').val($(this).find("img").attr('id'));
            //$('#CategorySelected_CategoryName').val($(this).find("img").attr('alt'));
            //alert($(this).attr('id'));
        });
        $('.thumb').eq(0).addClass('img-selected');
        $('.thumb').click(function () {
            //alert('a');
            $('.thumb').removeClass('img-selected');
            $(this).addClass('img-selected');
            var src = $(this).find('img').attr('src');
            $('.thumbnail img').attr('src', src);
        });

        function SwapMainImage(img) {
            //alert(img.id);
            var mainImage = document.getElementById("mainImage");
            var childImage = document.getElementById(img.id);

            var MainImageSrc = mainImage.src;
            mainImage.src = childImage.src;
            childImage.src = MainImageSrc;
        }
    </script>
</asp:Content>