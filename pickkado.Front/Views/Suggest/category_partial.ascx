<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<List<pickkado.Entities.Category>>" %>

<%foreach(var i in Model) {%>
<div class="col-xs-6 col-sm-4 col-lg-2">
    <div class="circle-gray">
        <img src="<%:i.ImageUrl %>" id="<%:i.Id %>" alt="<%:i.Name %>" />
        <span class="title" style="display:none">
            <%:i.Name %>
        </span>
    </div>
</div>
<%} %>