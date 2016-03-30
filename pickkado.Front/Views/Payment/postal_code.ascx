<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<pickkado.Front.Models.PurchaseInformationViewModel>" %>
    <div id="postal_code">
        <%
            List<SelectListItem> citySelectlist =

                Model.postalcode.Cities.Select(x => new SelectListItem
                {
                    Text = x.CityName,
                    Value = x.CityName,
                    
                    Selected = (x.CityName == Model.postalcode.City ? true : false)
                })

                .ToList();
            List<SelectListItem> kecSelectlist =

            Model.postalcode.Kecamatans.Select(x => new SelectListItem
            {
                Text = x.KecamatanName,
                Value = x.KecamatanName,

                Selected = (x.KecamatanName == Model.postalcode.Kecamatan ? true : false)
            })

            .ToList();
            List<SelectListItem> kelSelectlist =

            Model.postalcode.Kelurahans.Select(x => new SelectListItem
            {
                Text = x.KelurahanName,
                Value = x.KelurahanName,

                Selected = (x.KelurahanName == Model.postalcode.Kelurahan? true : false)
            })

            .ToList();
             %> 
        <div class="col-lg-4">
            <%:Html.DropDownListFor(m => m.postalcode.City, citySelectlist, new { id = "ddlCity", onchange = "onchangeDDL();",@class="selectpicker form-control",title="Pilih Kab/Kota..."})%>

        </div>
        <div class="col-lg-4">
            <%:Html.DropDownListFor(m=>m.postalcode.Kecamatan,kecSelectlist, new {id="ddlKecamatan", onchange="onchangeDDL1();",@class="selectpicker form-control",title="Pilih Kecamatan..."}) %>

        </div>
        <div class="col-lg-4">
            <%:Html.DropDownListFor(m=>m.postalcode.Kelurahan,kelSelectlist, new {id="ddlKelurahan",@class="selectpicker form-control",title="Pilih Kelurahan..."}) %>

        </div>
    </div>
<script>
    $(function () {
        return $('.selectpicker').selectpicker({
            style: 'btn-default',
            size: 4,
            liveSearch: "true"
        });
    });
    function onchangeDDL() {
        var getValues = $('#ddlCity').val();
        var service = $('#JenisPaket').val();
        //alert(service);
        if (service != "") {
            //var value = getValues.split('/');
            $('#JenisPaket').val('');
            $('#JenisPaket.selectpicker').selectpicker('refresh');
        }
        $.ajax({
            type: "POST",
            url: '<%: Url.Action("postal_code", "payment")%>',
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
                    $(".postalcode").html(result.HtmlString);
                    $('.selectpicker').selectpicker('refresh');
                }
            },
            error: function (err) {
                console.log(err.statusText);
            }
        });
        //$.ajax({
        //    type: "GET",
        //    url: '//api.rajaongkir.com/starter/city',
        //    contentType: 'application/x-www-form-urlencoded',
        //    crossDomain:true,
        //    beforeSend: function (request)
        //    {
        //        request.setRequestHeader("key", "0f89cac1a365b19d9232df468d89fd48");
        //    },
        //    success: function (result) {
        //        console.log(result);
        //    },
        //    error: function (err) {
        //        alert(err.statusText);
        //    }
        //});
    }
    function onchangeDDL1() {
        $.ajax({
            type: "POST",
            url: '<%: Url.Action("postal_code", "payment")%>',
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
                    $(".postalcode").html(result.HtmlString);
                    $('.selectpicker').selectpicker('refresh');
                }
            },
            error: function (err) {
                console.log(err.statusText);
            }
        });
    }
</script>



