<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site1.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Catalog
</asp:Content>

<asp:Content ID="Content5" ContentPlaceHolderID="breadcumb" runat="server">
    <li><a href="/">Home</a></li>
    <li class="active">Catalog</li>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
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
        #filter-sidebar ul {
            list-style:none;
            padding:0px;
        }
        #filter-sidebar ul> li{
            list-style:none;
            padding-top:5px;
            padding-bottom:5px;
        }
        #filter-sidebar ul> li a{
            text-decoration:none;
            color:#282828;
            background-color:transparent;
        }
        
        #filter-sidebar ul> li.active> a{
            text-decoration:none;
            color:#5daf92;
            background-color:transparent;
        }
        #filter-sidebar ul> li  {
            text-decoration:none;
            color:#282828;
        }
        #filter-sidebar ul> li i{
            padding:0px 5px;
        }
        .head-category a{
            text-decoration:none;
            color:#282828;
            background-color:transparent;            
        }
        .head-category >.active{
            text-decoration:none;
            color:#5daf92;
            background-color:transparent;          
        }
        .gift-container {
            padding:0px 5px;
            padding-bottom:5px;
        }
        .gift-container .gift {
            border:1px solid #e5e5e5;
            padding:5px;
            height:300px;
        }
            .gift-container .gift a {
                text-decoration:none;
                background-color:transparent;
                color:#5daf92;
            }
            .gift-container .gift a {
                text-decoration:none;
                background-color:transparent;
                color:#282828;
            }
            .gift-container .gift a:hover {
                color:#5daf92;
            }
            .gift-container .gift a:hover .img-portait {
              height: 110%;
              width: auto;
              transition:height ease 0.5s;

            }
            .gift-container .gift a:hover .img-landscape {
              height: auto;
              width: 110%;
              transition:width ease 0.5s;

            }
            .gift-container .gift .title {
                padding-top:5px;
                padding-bottom: 5px;
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
              transition:width ease 0.5s;
}
    .square .img-portait {
      position: absolute;
      left: 50%;
      top: 50%;
      /*height: 100%;
      width: auto;*/
      width: 100%;
      height: auto;
      -webkit-transform: translate(-50%,-50%);
          -ms-transform: translate(-50%,-50%);
              transform: translate(-50%,-50%);
      transition:height ease 0.5s;
}
        .pagination li> a, .pagination li > a:hover {
            color:#5daf92;
            
        }
        .pagination li.active > a, .pagination li.active > a:hover {
            color:white;
            background-color:#5daf92;
            cursor:pointer;
            border-color:#5daf92;
        }
    </style>
    <div class="container-fluid">
        <div id="filter-sidebar" class="col-xs-6 col-sm-2" style="position:fixed;">            
            <div class="container-fluid head-category" style="border-bottom:2px solid #cccaca;padding:5px 0px; margin-right:15px;">
                <%var active = Request.Params["category"] == null ? "active" : Request.Params["category"] == "0" ? "active" : ""; %>
                <a class="link link-default font-moon <%:active %>" href="/catalog/views?category=0">Semua kategori</a>
            </div>
            <ul class="font-moon">
                <%:Html.Raw(ViewBag.Filter) %>                
            </ul>
        </div>
        <div class=" col-xs-offset-6 col-sm-offset-2 col-xs-6 col-sm-10">
            <div class="row">
                <%var list=ViewBag.ProductList; %>
                <%int start = ViewBag.StartIndex, end = list.Count >= start + 1 ? start + 1 : list.Count, activePage =Request.Params["page"]!=null?Int32.Parse(Request.Params["page"]):1;
                  string categoryFilter = Request.Params["category"] == null ? "" : "category=" + Request.Params["category"]+"&";
                  string searchFilter = Request.Params["search"] == null ? "" : "search=" + Request.Params["search"] + "&";
                  int pageCount = ViewBag.PageCount, maxblock = ViewBag.MaxBlock;
                  int endBlock = 0;
                  if (maxblock != 0)
                  {
                      endBlock = (((start) / maxblock) + 1) * maxblock > pageCount ? pageCount : (((start) / maxblock) + 1) * maxblock;                    
                  }
                  if (pageCount > 0)
                  {
                      if ((start + 1) % maxblock == 0)
                      {
                          endBlock = start + maxblock > pageCount ? pageCount : start + maxblock;
                      }
                  }
                   %>
                <ul class = "pagination pagination-sm" style="float:right;padding:0px;margin:0px">
                    <%if (pageCount > 1)
                      { %>
                        <%if (activePage > 1)
                          { %>
                            <li><a href = "/catalog/views?<%:categoryFilter%><%:searchFilter%>page=<%:activePage - 1%>" >&laquo;</a></li>
                        <%}%>
                        <%for (int j = (endBlock - maxblock>0?endBlock - maxblock:0); j < endBlock; j++)
                          {%>
                            <li class="<%:j + 1 == activePage ? "active" : ""%>"><a href = "/catalog/views?<%:categoryFilter%><%:searchFilter%>page=<%:j + 1%>"><%:j + 1%></a></li>

                        <%} %>
                        <%if (activePage < pageCount)
                          { %>
                            <li><a href = "/catalog/views?<%:categoryFilter%><%:searchFilter%>page=<%:activePage + 1%>" >&raquo;</a></li>
                        <%}
                      }%>
                </ul>
            </div>
            <div class="row" style="padding:10px">
                <%for (int i=0;i<ViewBag.ProductList.Count;i++) { %>
                <div class="col-xs-12 col-sm-3 gift-container">
                    <div class="gift">
                        <a href="/catalog/details/<%:list[i].Id %>" data-toggle="tooltip" data-placement="bottom" title="<%:list[i].Name %>">
                            <div class="square">
                                <%if (list[i].Image != null) %>
                                <%{
                                      %>                                    
                                    <img class="img-landscape" src="data:image;base64,<%: System.Convert.ToBase64String(list[i].Image)%>"  />
                                  <%}
                                  else{%>
                                    <img class="" src="../../Images/no-thumb.png" />
                                    
                                  <%} %>                                
                            </div>
                        </a>
                        <a href="/catalog/details/<%:list[i].Id %>" class="col-xs-12 font-avant title" data-toggle="tooltip" data-placement="top" title="<%:list[i].Name %>" style="overflow:hidden; height:30px">
                            <div class="glyphicon glyphicon-gift"></div>
                            <%:list[i].Name %>
                        </a>
                        <span class="col-xs-12 font-avant title">
                            <%:list[i].Price %>
                        </span>                        
                    </div>                    
                </div>
                  
                <%} %>                
             </div>
        </div>
    </div>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="navBar" runat="server">
    <%Html.RenderAction("login_partial","account"); %>
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ScriptsSection" runat="server">
    <script>
        $(function () {
            //$('.square').each(function ()
            //{
            //    if ($(this).find('img').width() > $(this).find('img').height()) {

            //        return $(this).find('img').addClass('img-landscape');

            //    }
            //    else
            //        return $(this).find('img').addClass('img-portait');
            //});
        });
    </script>
</asp:Content>
