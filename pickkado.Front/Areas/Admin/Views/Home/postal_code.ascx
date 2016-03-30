<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<pickkado.Front.Areas.Admin.Models.HomeViewModel>" %>
<div class="container" id="postalForm">
    <%--<% using (Html.BeginForm("postal_code", "home", null, FormMethod.Post, new { id = "postalForm" }))
       { %>
        <%: Html.AntiForgeryToken()%>--%>
    <div class="form-group" id="postal_code">
        <%
            List<SelectListItem> citySelectlist =

                Model.postalcode.Cities.Select(x => new SelectListItem
                {
                    Text = x.CityName,
                    Value = x.CityName,

                    Selected = (x.CityName == Model.postalcode.CitySelected ? true : false)
                })

                .ToList();
            List<SelectListItem> kecSelectlist =

            Model.postalcode.Kecamatans.Select(x => new SelectListItem
            {
                Text = x.KecamatanName,
                Value = x.KecamatanName,

                Selected = (x.KecamatanName == Model.postalcode.KecSelected ? true : false)
            })

            .ToList();
            List<SelectListItem> kelSelectlist =

            Model.postalcode.Kelurahans.Select(x => new SelectListItem
            {
                Text = x.KelurahanName,
                Value = x.KelurahanName,

                Selected = (x.KelurahanName == Model.postalcode.KelSelected ? true : false)
            })

            .ToList();
             %> 
        <div class="form-group">
            <div class="col-lg-4">
                <%:Html.DropDownListFor(m => m.postalcode.CitySelected, citySelectlist, new { id = "ddlCity", onchange = "onchangeDDL();",@class="form-control" })%>

            </div>
            <div class="col-lg-4">
                <%:Html.DropDownListFor(m=>m.postalcode.KecSelected,kecSelectlist, new {id="ddlKecamatan", onchange="onchangeDDL1();",@class="form-control"  }) %>

            </div>
            <div class="col-lg-4">
                <%:Html.DropDownListFor(m=>m.postalcode.KelSelected,kelSelectlist, new {id="ddlKelurahan",@class="form-control" }) %>

            </div>
        </div>
    </div>
    <%--<%} %>--%>
</div>
<script>
    function onchangeDDL() {
        $.ajax({
            type: "POST",
            url: '<%: Url.Action("postal_code", "home")%>',
            dataType: "json",
            data: $('form').serialize() + "&city=" + $('#ddlCity').val() + "&kec=" + $('#ddlKecamatan').val() + "&kel=" + $('#ddlKelurahan').val(),
            success: function (result) {
                if (result.redirectTo != null) {
                    //    // The operation was a success on the server as it returned
                    //    // a JSON objet with an url property pointing to the location
                    //    // you would like to redirect to => now use the window.location.href
                    //    // property to redirect the client to this location
                    //    window.location.href = result.redirectTo;
                } else {
                    //    // The server returned a partial view => let's refresh
                    //    // the corresponding section of our DOM with it
                    $("#postal_code").html(result.HtmlString);
                }
            },
            error: function (err) {
                console.log(err.statusText);
            }
        });
    }
    function onchangeDDL1() {
        $.ajax({
            type: "POST",
            url: '<%: Url.Action("postal_code", "home")%>',
            dataType: "json",
            data: $('form').serialize() + "&city=" + $('#ddlCity').val() + "&kec=" + $('#ddlKecamatan').val() + "&kel=" + $('#ddlKelurahan').val(),
            success: function (result) {
                if (result.redirectTo != null) {
                    //    // The operation was a success on the server as it returned
                    //    // a JSON objet with an url property pointing to the location
                    //    // you would like to redirect to => now use the window.location.href
                    //    // property to redirect the client to this location
                    //    window.location.href = result.redirectTo;
                } else {
                    //    // The server returned a partial view => let's refresh
                    //    // the corresponding section of our DOM with it
                    $("#postal_code").html(result.HtmlString);
                }
            },
            error: function (err) {
                console.log(err.statusText);
            }
        });
    }
</script>

