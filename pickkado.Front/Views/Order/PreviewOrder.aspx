<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site1.Master" Inherits="System.Web.Mvc.ViewPage<pickkado.Front.Models.OrderViewModel>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Preview Order
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="breadcumb" runat="server">
    <li>Catalog</li>
    <li ><%:ViewBag.ProductName %></li>
    <li>Package & Giftcard</li>
    <li>Input your giftcard message</li>
    <li ><a href="<%:ViewBag.LinkBack %>">Purchase Information</a> </li>
    <li class="active">Review Order</li>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="navBar" runat="server">
    <%Html.RenderAction("login_partial","account"); %>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container-fluid">
        <div class="container-fluid title-underline">
            <span class="font-avant">Preview Order</span>
        </div>
        <div class="container-fluid" style="margin:50px 0px; border:1px solid #353535">
            <div class="row" style="margin:10px;">
                <div class="col-lg-12">
                    <div class="form-group form-group-lg" style="padding:10px 0px">
                        <%: Html.TextAreaFor(m=>m.OrderDetail,new {@class="form-control", rows="5", placeholder="TEXT*",disabled="disabled"}) %>
                        
                    </div>
                </div>
                <div class="col-lg-3" style="padding-top:10px; padding-bottom:10px">
                    <div class="img-thumbnail square">
                        <%if(Model.imageByte!=null) {%>
                        <img src="data:image;base64,<%: System.Convert.ToBase64String(Model.imageByte)%>"  />
                        <%}else{ %>
                        <img src="../../Images/no-thumb.png" height="100" width="100"/>
                        <%} %>
                    </div>
                </div>
                <div class="col-lg-12">
                    <div class="form-group">
                        <div class="input-group input-group-lg" style="padding:10px 0px">
                            <span class="input-group-addon">
                                <span  aria-hidden="true">Rp.</span>
                            </span>
                            <%:Html.TextBoxFor(m=>m.Price,new {@class="form-control",id="price",placeholder="TEXT*",disabled="disabled" }) %>

                        </div>
                    </div>
                </div>
                
            </div>
        </div>
        <div class="container-fluid" >            
            <div class="row" style="padding:10px 0px">
                <div class="col-xm-2 col-sm-2 col-md-2 col-lg-2">
                    <a class="btn btn-block btn-lg btn-login" href="/order">
                        <img src="../../Images/icon/PanahBackIcon.png" class="lefticon"/>
                        Back
                    </a>                    
                </div>
                <div class="col-xm-offset-7 col-xm-3 col-sm-offset-7 col-sm-3 col-md-offset-7 col-md-3 col-lg-offset-7 col-lg-3">
                    <a class="btn btn-block btn-lg btn-login" href="<%:Url.Action("package","suggest",new{returnUrl=Request.Url.AbsoluteUri}) %>">
                        Next
                        <img src="../../Images/icon/PanahNextIcon.png" class="righticon"/>
                    </a>           
                </div>
            </div>
        </div>
    </div>
<style>
    .square {
        position: relative;
        width: 200px;
        height: 200px;
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
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ScriptsSection" runat="server">
    <script>
        $(function () {
            if ($('.square').find('img').width() > $('.square').find('img').height())
                return $('.square').find('img').addClass('img-landscape');
            return $('.square').find('img').addClass('img-portait');;
        });
    </script>
</asp:Content>
