<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<pickkado.Front.Models.SubscribeViewModel>" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Welcome</title>
    <meta name="viewport" content="width=device-width" />
    <link rel="stylesheet" href="/Content/bootstrap/css/bootstrap.css" />
    <link rel="stylesheet" href="/Content/master.css" />
    <link href="../../Content/lib/css/animate.min.css" rel="stylesheet" />
    <script src="../../Scripts/jquery-1.10.2.js"></script>
    <script src="../../Scripts/jquery-ui-1.8.24.js"></script>
    <%: Scripts.Render("~/bundles/bootstrap") %>
    <style>
        .textbox {
            border-radius:0px;
            background-color:transparent;
            border-color:white;
            border:2px solid white;
            color:white;
        }
        .subscribe {
            background-color:rgba(93,177,148,0.5);
            border:2px solid #5daf92;
        }
        .subscribe:hover {
            border:2px solid #5db194;
        }
    </style>
</head>
<body>
    <div id="body">
        <section class="content-wrapper main-content clear-fix" style="min-width:768px;overflow:auto">
            <div class="container-fluid" style="background:url(/Images/dsmmcm1415-gift-giving-convert.png);background-color:rgba(255,255,255,0.5);  height:638px;background-repeat:no-repeat">
               <div  style="display: table;width:100%;height:100%; min-height:100%; background-color:transparent;margin:0;">
                   <div style="display:table-cell; vertical-align:middle;">
                       <div class="row" style="padding-left:50px;">
                           <div class="col-xs-12 col-lg-7">
                                <img src="../../Images/brand-large.png" class="img-responsive" style="height:100px;position:relative;top:50%;left:50%;transform:translate(-50%,-50%)" />

                           </div>
                       </div>
                       <div class="row" style="padding-left:50px;">
                           <div class="col-xs-12 col-lg-7">                                
                               <h1 class="font-moon" style="color:white;text-align:center">Be ready, we are launching soon !</h1>
                           </div>
                       </div>
                       <div class="row" style="padding-left:50px;padding-top:50px" >
                           <div class="col-xs-12 col-lg-7" style="">
                       
                            <% using (Html.BeginForm("index", "subscribe", null, FormMethod.Post))
                               { %>
                                <%: Html.AntiForgeryToken()%>
                                <% if (ViewData.ModelState.Any(x => x.Value.Errors.Any()))
                                   {%>
                                        <div id="message" class="alert alert-danger form-message" style="margin-bottom:15px">
                                            <a href="#" class="close" data-dismiss="alert">×</a>
                                            <%: Html.ValidationSummary("", new { @class = "validation-summary-custom",style="padding:0px;" })%>
                                        </div>
                                    <% }
                                   else if (!string.IsNullOrEmpty(ViewBag.Success))
                                   {%>
                               
                                        <div id="Div1" class="alert alert-success form-message" style="margin-bottom:15px">
                                            <a href="#" class="close" data-dismiss="alert">×</a>
                                            <strong>Success</strong> <%:ViewBag.Success%>
                                        </div>
                                      <%} %>
                               <div class="container-fluid" >
                                   <div class="row" style="padding-bottom:20px">
                                       <div class="col-xs-8 col-md-8 col-lg-8" style="padding:0px;">
                                            <%:Html.TextBoxFor(m => m.Email, new { @class = "form-control input-lg textbox", @placeholder = "Please enter your email address" })%>
                                       </div>
                                       <div class="col-xs-4 col-md-4 col-lg-4" style="padding:0px;padding-left:2px">
                                           <button type="submit" class="btn btn-primary btn-block btn-lg font-helvetica btn-login subscribe" style="border-radius:0;">Subscribe</button>
                                       </div>
                                   </div>
                               </div>
                               <%} %>
                           </div>
                        </div>
                   </div>
               </div>
            </div>
            <div class="container-fluid" id="how" style="padding:0px;">
                <div class="col-xs-12" style="background-color:#5daf92; color:white; height:130px">
                    <h3 class="font-moon" style="display:block; text-align:center; padding:25px 0px">bagaimana pickkado memenuhi kebutuhan kado anda ?</h3>
                </div>
                <div class="col-xs-6 col-md-3 how">
                    <div class="thumbnail">
                        <img src="../../Images/icon/IconPilihKado_Hijau.png" style="padding-top:30px;" />
                        <div class="caption">
                            <h4 class="font-moon" style="" >pilih kado anda</h4>
                            <div class="font-helvetica col-xs-offset-1 col-xs-10 col-xs-offset-1" style="text-align:center; font-size:12px">
                                PICKKADO menyediakan beragam kategori dan jenis barang sebagai pilihan kado anda.

                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-xs-6 col-md-3 how-inverse" >
                    <div class="thumbnail">
                        <img src="../../Images/icon/IconKartuUcapan_Hijau.png" style="padding-top:30px;" />
                        <div class="caption" style="color:#707070">
                            <h4 class="font-moon" style="text-align:center;min-height:80px">Kartu ucapan dari anda & kerabatnya</h4>
                            <div class="font-helvetica col-xs-offset-1 col-xs-10 col-xs-offset-1" style="text-align:center; font-size:12px">
                                PICKKADO mennyediakan sebuah feature agar anda bisa
                                meminta kerabatnya untuk memberikan ucapan selamat 
                                dalam satu kartu ucapan yang akan anda berikan.
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-xs-6 col-md-3 how" >
                    <div class="thumbnail">
                        <img src="../../Images/icon/IconBungkusKado_Hijau.png" style="padding-top:30px;" />
                        <div class="caption" style="color:#707070">
                            <h4 class="font-moon" style="text-align:center;min-height:80px">bungkus kado</h4>
                            <div class="font-helvetica col-xs-offset-1 col-xs-10 col-xs-offset-1" style="text-align:center; font-size:12px">
                                PICKKADO akan membungkus kado anda sesuai dengan bungkus kado yang anda pilih.
                            </div>
                        </div>
                    </div>

                </div>
                <div class="col-xs-6 col-md-3 how-inverse">
                    <div class="thumbnail">
                        <img src="../../Images/icon/IconPatungan_Hijau.png" style="padding-top:30px;" />
                        <div class="caption" style="color:#707070">
                            <h4 class="font-moon" style="min-height:80px" >Patungan dengan teman-teman anda?</h4>
                            <div class="font-helvetica col-xs-offset-1 col-xs-10 col-xs-offset-1" style="text-align:center; font-size:12px">
                                PICKKADO memberikan opsi untuk anda, agar
                                bisa membeli kado secara individu atau patungan
                                dengan kerabat-kerabat anda.

                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </section>
    </div>
</body>
</html>
