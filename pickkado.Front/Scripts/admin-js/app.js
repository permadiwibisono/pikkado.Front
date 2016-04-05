$(function() {
  $(".navbar-expand-toggle").click(function() {
    $(".app-container").toggleClass("expanded");
    return $(".navbar-expand-toggle").toggleClass("fa-rotate-90");
  });
  return $(".navbar-right-expand-toggle").click(function() {
    $(".navbar-right").toggleClass("expanded");
    return $(".navbar-right-expand-toggle").toggleClass("fa-rotate-90");
  });
});

//$(function() {
//  return $('select').select2();
//});

//$(function() {
//  return $('.toggle-checkbox').bootstrapSwitch({
//    size: "small"
//  });
//});

$(function () {
    return $('.match-height').matchHeight();
});
$(function () {
    var menus = $('.menu');
    return menus.each(function () {
        var id = $(this).attr('id');
        if (document.location.href.indexOf(id) >= 0) {
            if (id == 'admin') {
                var count = document.location.href.length;
                if (count == document.location.href.indexOf(id) + 5) {
                    $(this).addClass('active');
                    return;
                }
            }
            else if (id == "vendor")
            {
                var count = document.location.href.length;
                if (count == document.location.href.indexOf(id) + 6) {
                    $(this).addClass('active');
                    return;
                }
            }
            else {
                $(this).addClass('active');
                return;
            }
        }
    });
});

//var table=$('.datatable').DataTable({
//    "dom": '<"top"fl<"clear">>rt<"bottom"ip<"clear">>'
//});
//$(function() {
//    return $('.datatable').DataTable({
//        "dom": '<"top"fl<"clear">>rt<"bottom"ip<"clear">>',
//  });
//});

$(function() {
  return $(".side-menu .nav .dropdown").on('show.bs.collapse', function() {
    return $(".side-menu .nav .dropdown .collapse").collapse('hide');
  });
});
$(document).ajaxStart(function () {
    // show loader on start
    $(".loader").css("display", "block");
}).ajaxSuccess(function () {
    // hide loader on success
    $(".loader").css("display", "none");
});