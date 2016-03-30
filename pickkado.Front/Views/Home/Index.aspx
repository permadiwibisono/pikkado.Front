<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="indexTitle" ContentPlaceHolderID="TitleContent" runat="server">
    pickkado
</asp:Content>

<asp:Content ID="indexFeatured" ContentPlaceHolderID="FeaturedContent" runat="server">
    <style>
    </style>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="navBar" runat="server">
    <%Html.RenderAction("login_partial","account"); %>
</asp:Content>

<asp:Content ID="indexContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container-fluid" style="background:url(/Images/dsmmcm1415-gift-giving-convert.png);background-color:rgba(255,255,255,0.5);  height:638px;background-repeat:no-repeat">
       <div  style="display: table;width:100%;height:100%; min-height:100%; background-color:transparent;margin:0;">
           <div style="display:table-cell; vertical-align:middle;">
               <div class="row" style=" padding-top:75px" >
                   <div class="col-xs-12 col-md-6" style="padding-left:100px; padding-top:50px" >
                       <h2 style="color:white; font-size:36px" class="font-moon">
                           personal <span class="font-moon-bold">gift assistant</span> to <br /> 
                            help you buy <span class="font-moon-bold">the best gift</span>  <br /> 
                            for your <span class="font-moon-bold">special one</span>.
                       </h2>
                   </div>
                   <div class="col-xs-12 col-md-6" style="padding:75px 0px;">
                       <div class="container-fluid " style="background-color:rgba(102,102,102,0.5); padding:35px" >
                           <div class="row" >
                               <div class="col-xs-7">
                                   <div class="input-group input-group-lg">
                                       <div class="input-group-addon" style="background-color:transparent; border:none; color:white; font-size:30px">
                                            <span class="glyphicon glyphicon-search" id="basic-addon1"></span>
                                       </div>
                                      <input type="text" class="form-control input-search" placeholder="Cari kado" aria-describedby="sizing-addon1" style="background-color:rgba(255,255,255,0.5); color:white;">
                                    </div>
                               </div>
                               <div class="col-xs-5">                                   
                                    <button class="btn btn-block btn-lg font-moon btn-pink btn-search" >
                                        AMBIL KADO
                                    </button>                                   
                               </div>
                           </div>
                       </div>
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
    <div class="container-fluid" style="padding:0px;">
        <div class="col-xs-12" style="color:#5daf92;">
            <h3 class="font-moon-bold" style="display:block; text-align:center; padding:25px 0px">kategori hadiah di pickkado</h3>
        </div>
        <div class="col-xs-3" style="padding:0px">
            <div class="category">
                <a href="/catalog/views?category=2">
                    <img class="img-responsive" src="../../Images/icon/FashionPria.jpg" />
                    <div class="overlay">
                        <span class="font-moon-bold">fashion pria</span>
                    </div>
                </a>
            </div>
        </div>
        <div class="col-xs-3" style="padding:0px">
            <div class="category">
                <a href="/catalog/views?category=1">
                    <img class="img-responsive" src="../../Images/icon/FashionWanita.jpg" />
                    <div class="overlay">
                        <span class="font-moon-bold">fashion wanita</span>
                    </div>
                </a>
            </div>
        </div>
        <div class="col-xs-3" style="padding:0px">
            <div class="category">
                <a href="/catalog/views?category=3">
                    <img class="img-responsive" src="../../Images/icon/Unique.jpg" />
                    <div class="overlay">
                        <span class="font-moon-bold">aksesoris</span>
                    </div>
                </a>
            </div>
        </div>
        <div class="col-xs-3" style="padding:0px">
            <div class="category">
                <a href="/catalog/views?category=4">
                    <img class="img-responsive" src="../../Images/icon/Voucher.jpg" />
                    <div class="overlay">
                        <span class="font-moon-bold">voucher</span>
                    </div>
                </a>
            </div>
        </div>
        <div class="col-xs-3" style="padding:0px">
            <div class="category">
                <a href="/catalog/views?category=5">
                    <img class="img-responsive" src="../../Images/icon/Electronic.jpg" />
                    <div class="overlay">
                        <span class="font-moon-bold">Electronic</span>
                    </div>
                </a>
            </div>
        </div>
        <div class="col-xs-3" style="padding:0px">
            <div class="category">
                <a href="/catalog/views?category=6">
                    <img class="img-responsive" src="../../Images/icon/Toy.jpg" />
                    <div class="overlay">
                        <span class="font-moon-bold">toy</span>
                    </div>
                </a>
            </div>
        </div>
        <div class="col-xs-3" style="padding:0px">
            <div class="category">
                <a href="/catalog/views?category=7">
                    <img class="img-responsive" src="../../Images/icon/Flower.jpg" />
                    <div class="overlay">
                        <span class="font-moon-bold">Flower</span>
                    </div>
                </a>
            </div>
        </div>
        <div class="col-xs-3" style="padding:0px">
            <div class="category">
                <a href="#">
                    <img class="img-responsive" src="../../Images/icon/Experience.jpg" />
                    <div class="overlay">
                        <span class="font-moon-bold">Experience</span>
                    </div>
                </a>
            </div>
        </div>
    </div>
    <div class="container-fluid testi">
        <div class="col-xs-12" style="color:#707070;">
            <h3 class="font-moon-bold" style="display:block; text-align:center; padding:25px 0px">testimoni dari mereka</h3>
        </div>
        <div class="col-sm-6">
            <div class="thumbnail">
                <img src="../../Images/damian7.jpg"  class="img-circle" />
                <div class="caption" style="color:#707070">
                    <div class="font-helvetica col-xs-offset-1 col-xs-10 col-xs-offset-1">
                        <blockquote>
                            <i>it’s make more easy for us to give a gift to people, all product catalog
                                is intended for gift and i think this is a good solution.</i>
                            <footer>Damian “JR.GONG” Marley</footer>
                        </blockquote>

                    </div>
                </div>
                
            </div>
        </div>
        <div class="col-sm-6">
            <div class="thumbnail">
                <img src="../../Images/pw.jpg"  class="img-circle" />
                <div class="caption" style="color:#707070">
                    <div class="font-helvetica col-xs-offset-1 col-xs-10 col-xs-offset-1">
                        <blockquote>
                            <i>pickkado memudahkan kita untuk bisa memberi kado kepada orang lain,
                                 family, kerabat maupun orang yang spesial tanpa harus repot sana - sini,
                                just once klik. Kita juga bisa patungan untuk membelikan kadonya.
                            </i>
                            <footer>Permadi Wibisono</footer>
                        </blockquote>

                    </div>
                </div>
                
            </div>
        </div>

    </div>
    <script>
        $('.btn-search').click(function () {
            window.location.href = '/catalog/views?search='+$('.input-search').val()+'';
        });
        $('.input-search').on('keyup', function (event) {
            console.log(event.keyCode);
            if (event.keyCode == 13) {
                window.location.href = '/catalog/views?search=' + $('.input-search').val() + '';
            }
        });
    </script>
</asp:Content>
