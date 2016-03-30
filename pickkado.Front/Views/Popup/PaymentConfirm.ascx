<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<pickkado.Front.Models.PaymentConfirmViewModel>" %>


<div style="position: fixed; background-color: rgba(10,10,10,0.6); top: 0; bottom: 0; width: 100%; height: 100%; left: 0; right: 0; z-index: 1100;">
    <div style="position: relative; width: 550px; height: 560px; background-color: white; margin: auto; transform: translateY(-50%); top: 50%;">
        <img src="../../Images/icon/close.png" style="position: absolute; top: -14px; right: -14px; cursor: pointer" id="btn-close" />

        <% using (Html.BeginForm("PaymentConfirm", "Popup", new { returnUrl = Request.UrlReferrer.AbsoluteUri }, FormMethod.Post, new {id="paymentConfirmForm", @enctype = "multipart/form-data" }))
           { %>
        <%: Html.AntiForgeryToken()%>

        <div style="width: auto; height: auto; padding: 20px">
            <div class="container-fluid title-underline">
                <span class="font-avant" style="font-size: 15px">
                    <%if (Model.IsUnderpayment)
                      { %>
                        UNDERPAYMENT CONFIRMATION
                    <% }
                      else
                      { %>
                        PAYMENT CONFIRMATION
                    <% } %>
                </span>
            </div>
            <div style="padding: 10px">
                <table>
                    <tr>
                        <td style="width: 150px">
                            <%:Html.HiddenFor(m => m.IsUnderpayment)%>
                            <%if (Model.IsUnderpayment)
                              { %>
                                Total Kekurangan
                            <% }
                              else
                              { %>
                                Total Tagihan
                            <% } %>
                            
                        </td>
                        <td>
                            <%var totalTagihan = Int32.Parse((Math.Ceiling(Model.TotalTagihan).ToString()));%>
                            <label id="lblTotalTagihan" class = "font-helvetica"><%:totalTagihan %></label>
                            <%--<%:Html.DisplayFor(m => , new { id = "lblTotalTagihan", @class = "font-helvetica" })%>--%>
                            <%:Html.HiddenFor(m => m.TotalTagihan)%>
                        </td>
                    </tr>
                </table>
            </div>
            <div style="max-height: 460px; overflow: auto">
                <% if (ViewData.ModelState.Any(x => x.Value.Errors.Any()))
                   {%>
                <div class="alert alert-danger" style="position: relative; margin: 0;">
                    <a href="#" class="close" data-dismiss="alert">×</a>
                    <%: Html.ValidationSummary("", new { @class = "validation-summary-custom" })%>
                </div>
                <% }%>
                <div>
                    <table style="width: 100%">
                        <tr>
                            <td style="padding-bottom: 10px">
                                <%--<input type="text" class="grayTextBox" style="width: 100%" value="jumlah yang sudah di bayar*" />--%>
                                <div class="input-group date">
                                    <%:Html.TextBoxFor(m => m.TanggalPembayaran, new { id = "txtTanggalTransfer", @class = "form-control", @placeholder = "Tanggal Transfer*" })%>
                                    <div class="input-group-addon">
                                        <span class="glyphicon glyphicon-th"></span>
                                    </div>
                                </div>
                                <%:Html.HiddenFor(m => m.TransactionId)%>
                            </td>
                        </tr>
                        <tr>
                            <td style="padding-bottom: 10px">
                                <%:Html.DropDownListFor(m => m.DariRekeningId, Model.DariRekenings, new { id = "ddlDariRekening", @class = "form-control", onchange="ddlDariRekening_onChange(this.id)" })%>
                                <%--<%:Html.HiddenFor(m => m._dariRekening) %>--%>
                            </td>
                        </tr>
                    </table>
                </div>
                <div id="divcollapse" class="collapse divRekeningBaruCollapse">
                    <table style="width: 100%">
                        <tr>
                            <td style="padding-bottom: 10px">
                                <%:Html.TextBoxFor(m => m.NamaBank, new { id = "txtNamaBank", @class = "form-control", @placeholder = "Nama Bank*" })%>
                            </td>
                        </tr>
                        <tr>
                            <td style="padding-bottom: 10px">
                                <%--<input type="text" class="grayTextBox" style="width: 100%" value="Nama Pemilik Rekening*" />--%>
                                <%:Html.TextBoxFor(m => m.NamaPemilikRekening, new { id = "txtNamaPemilikRekening", @class = "form-control", @placeholder = "Nama Pemilik Rekening*" })%>
                            </td>
                        </tr>
                        <tr>
                            <td style="padding-bottom: 10px">
                                <%--<input type="text" class="grayTextBox" style="width: 100%" value="Bomor Rekening*" />--%>
                                <%:Html.TextBoxFor(m => m.NomorRekening, new { id = "txtNomorRekening", @class = "form-control", @placeholder = "Nomor Rekening*" })%>
                            </td>
                        </tr>
                        <tr>
                            <td style="padding-bottom: 30px">
                                <%--<input type="text" class="grayTextBox" style="width: 100%" value="Cabang rekening*" />--%>
                                <%:Html.TextBoxFor(m => m.CabangRekening, new { id = "txtCabangRekening", @class = "form-control", @placeholder = "Cabang Rekening*" })%>
                            </td>
                        </tr>
                    </table>
                </div>
                <div>
                    <table style="width: 100%">
                        <tr>
                            <td style="padding-bottom: 10px">
                                <%:Html.DropDownListFor(m => m.RekeningTujuanId, Model.RekeningTujuans, new { id = "ddlRekeningTujuan", @class = "form-control" })%>
                            </td>
                        </tr>
                        <tr>
                            <td style="padding-bottom: 10px">
                                <%--<input type="text" class="grayTextBox" style="width: 100%" value="jumlah yang sudah di bayar*" />--%>
                                <div class="input-group">
                                    <span class="input-group-addon">
                                        <span  aria-hidden="true">Rp.</span>
                                    </span>
                                <%:Html.TextBoxFor(m => m.JumlahPembayaran, new { id = "txtJumlahPembayaran", @class = "form-control", @placeholder = "Jumlah yang Telah Dibayar*" })%>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td style="padding-bottom: 10px">
                                <%:Html.TextBoxFor(m => m.NoStrukPembayaran, new { id = "txtNoStrukPembayaran", @class = "form-control", @placeholder = "Nomor struk Pembayaran*" })%>
                            </td>
                        </tr>
                        <tr>
                            <td style="padding-bottom: 10px">
                                <%:Html.TextBoxFor(m => m.Remarks, new { id = "txtRemarks", @class = "form-control", @placeholder = "Catatan" })%>
                            </td>
                        </tr>
                    </table>
                </div>
                <div>
                    <%--http://stackoverflow.com/questions/3828554/how-to-allow-input-type-file-to-accept-only-image-files--%>
                    <input id="file1" type="file" onchange="readURL(this,'image-holder');" name="image" accept="image/x-png, image/gif, image/jpeg" />
                    <img id="image-holder" src="#" />
                </div>
                <div class="col-lg-12" style="padding-top: 15px; padding-bottom: 15px">
                    <button id="btnDone" value="PaymentConfirm" class="btn btn-lg btn-block btn-login">Done </button>
                </div>
            </div>

        </div>

        <% } %>
    </div>
</div>

<%--berdasarkan w3schools, kalo mau dapet method .collapse di script, harus ada 3 component ini--%>
<%--http://www.w3schools.com/bootstrap/tryit.asp?filename=trybs_ref_js_collapse_methods&stacked=h--%>
<%--http://getbootstrap.com/javascript/#collapse--%>
<%--<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>--%>
<%--<link rel="stylesheet" href="../../Content/bootstrap/css/bootstrap.min.css" />
<script src="../../Scripts/jquery-1.12.0.min.js"></script>
<script src="../../Scripts/bootstrap/bootstrap.min.js"></script>--%>
<%--http://bootstrap-datepicker.readthedocs.org/en/latest/--%>
<%--http://www.eyecon.ro/bootstrap-datepicker/--%>
<link rel="stylesheet" href="../../Content/bootstrap/css/datepicker.css" />
<script src="../../Scripts/bootstrap/bootstrap-datepicker.js"></script>
<script>
    $(document).ready(function () {
        var ddl = document.getElementById('ddlDariRekening');

        if (ddl.selectedIndex == (ddl.length - 1)) {
            $('.divRekeningBaruCollapse').collapse('show');
        } else {
            $('.divRekeningBaruCollapse').collapse('hide');
        }


        $("#txtTanggalTransfer").datepicker("setValue", new Date());
    });

    function ddlDariRekening_onChange(ddlId) {

        //.val() untuk ngambil selectedvalue (yaitu idnya)
        //alert($('#' + ddlId).val() + ' ' + ($('#' + ddlId).length + 1) );
        var ddl = document.getElementById(ddlId);
        //alert(ddl.selectedIndex + ' ' + (ddl.length - 1));

        if (ddl.selectedIndex == (ddl.length - 1)) {
            $('.divRekeningBaruCollapse').collapse('show');
        } else {
            $('.divRekeningBaruCollapse').collapse('hide');
        }

        //$('.collapse').collapse('toggle');
        //$(".collapse").collapse('show');
        //$(".collapse").collapse('hide');
    }
</script>


<script>
    $("#txtTanggalTransfer").datepicker({
        format: 'dd/mm/yyyy'
    }).on('changeDate', function () {
        $("#txtTanggalTransfer").datepicker('hide');
    });
    $('.datepicker').css("z-index", 1100);
</script>

<%--<script src="http://malsup.github.com/jquery.form.js"></script>--%>
<script src="../../Scripts/jquery.form.js"></script>
<script>
    $('#btnDone').click(function () {
        alert('a');
        //http://stackoverflow.com/questions/15922268/file-upload-with-ajax-in-asp-net-mvc
        var options = {
            success: function (data) {
                console.log(data);
                if (data.redirectTo != null) {
                    window.location.href = data.redirectTo;
                } else {
                    alert('a');
                    $("#popup").html(data.HtmlString);
                }
            },
            error: function (err) {
                alert(err.statusText);
            }
        };
        $('form').ajaxForm(options);
    });
    $('#btnDone1').click(function (e) {
        //http://stackoverflow.com/questions/14667274/asp-net-mvc-partial-view-ajax-post
        e.preventDefault();

        var formData = new FormData();
        var files = $("#file1").get(0).files;
        formData = { "file": files[0] };
        console.log($('form').serialize());
        $.ajax({
            type: "POST",
            url: '<%:Url.Action("paymentconfirm","popup")%>',
            dataType: "json",
            xhr: function () {  // Custom XMLHttpRequest
                var myXhr = $.ajaxSettings.xhr();
                if (myXhr.upload) { // Check if upload property exists
                    myXhr.upload.addEventListener('progress', progressHandlingFunction, false); // For handling the progress of the upload
                }
                return myXhr;
            },
            data: $('form').serialize() + '&' + $.param({ "returnUrl": '<%:Request.UrlReferrer.AbsoluteUri%>' }),
            success: function (result) {

                if (result.redirectTo != null) {
                    window.location.href = result.redirectTo;
                } else {
                    if (result.Alert != null)
                    {
                        alert(result.Alert);
                    }
                    else
                        $("#popup").html(result.HtmlString);
                }
            }, error: function (err) {
                alert(err.statusText);
            }
        });
    });

    function progressHandlingFunction(e) {
        if (e.lengthComputable) {
            $('progress').attr({ value: e.loaded, max: e.total });
        }
    }

    $('#btn-close').click(function () {
        $("#popup").html('');
    });
    $(".validation-summary-errors").removeClass("validation-summary-errors");
    $(".input-validation-error").removeClass("input-validation-error").parent().addClass("has-error");

    //http://stackoverflow.com/questions/12368910/html-display-image-after-selecting-filename
    function readURL(input, imgId) {
        if (input.files && input.files[0]) {
            var reader = new FileReader();

            reader.onload = function (e) {
                var img = document.getElementById(imgId);
                img.src = e.target.result;
                img.width = 150;
                img.height = 200;
            };

            reader.readAsDataURL(input.files[0]);
        }
    }
</script>
