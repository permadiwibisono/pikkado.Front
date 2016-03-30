<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<pickkado.Front.Models.GiftCardPartialView>" %>


<%foreach(var i in Model.List) {%>
<div class="col-xs-6 col-sm-4 col-lg-2">
    <% if(Model.GiftcardSelected==i.Id.ToString()){ %>
        <div class="circle-gray selected">
    <%} else
    {%>
        <div class="circle-gray" data-bind-name="#GiftcardId">
    <%}%>
      
      <%if(i.Image==null){ %>
        <img src="../../Images/no-thumb.png" data-toggle="tooltip" data-placement="top" title="<%:i.Name %>" id="<%:i.Id %>" alt="<%:i.Name %>" class="img-circle" style="height:140px; width:140px" />
      <%}else {%>
        <img src="data:image;base64,<%: System.Convert.ToBase64String(i.Image)%>" id="<%:i.Id %>"  alt="<%:i.Name %>" alt="<%:i.Name %>" class="img-circle" style="height:140px; width:140px" />
            <%} %>
    </div>
</div>
<%} %>