/// <reference path="jquery.zoom.min.js" />

$(document).ajaxStart(function () {
    // show loader on start
    $(".loader").css("display", "block");
}).ajaxSuccess(function () {
    // hide loader on success
    $(".loader").css("display", "none");
});
$(document).ready(function () {
    if ($(this).scrollTop() > 250) {
        console.log("add class");
        $('.navbar').addClass('navbar-default-inverse');
    }
    else {
        $('.navbar').removeClass('navbar-default-inverse');
    }
    $(document).scroll(function () {
        //console.log($(this).scrollTop());
        if ($(this).scrollTop() > 250) {
            $('.navbar').addClass('navbar-default-inverse');
        }
        else {
            $('.navbar').removeClass('navbar-default-inverse');
        }
    });
    function goToByScroll(id) {
        // Reove "link" from the ID
        id = id.replace("link", "");
        // Scroll
        $('html,body').animate({
            scrollTop: $("#" + id).offset().top - 50
        },
            'slow');
    }
    $('#navbar > ul li>a').click(function (e) {

        // Prevent a page reload when a link is pressed
        //e.preventDefault();
        // Call the scroll function
        goToByScroll($(this).attr("id"));
    });
    $('#login').click(function () {
        $.get("../account/login",
        function (data) {
            $("#popup").html(data);
        });

    });
    $('.btn-login').hover(function () {
        try {

            var img = $(this).find('img').attr('src');
            $(this).find('img').attr('src', img.replace('.png', '2.png'));
        }
        catch (e) {
        }
    }, function () {
        try {
            var img = $(this).find('img').attr('src');
            $(this).find('img').attr('src', img.replace('2.png', '.png'));

        }
        catch (e)
        { }

    });
    $('#btnAuthorize').click(function (e) {
        e.preventDefault();
        $.get("../account/login",
        function (data) {
            $("#popup").html(data);
        });

    });

    $('a[data-animated="tada"]').hover(function () {
        //$(this).toggleClass($(this).attr("data-animated"));
        $(this).toggleClass($(this).attr("data-animated"));
    });

});
$(function () {
    return $('.selectpicker').selectpicker({
        style: 'btn-default',
        size: 10,
        liveSearch: "true"
    });
});
$(function () {
    return $('[data-toggle="tooltip"]').tooltip();
});
$(function () {
    return $(".zoom").zoom();;
});
function ShowPopup(link)
{
    $.get(link,
    function (data) {
        $("#popup").html(data);
        $('#popup').modal('show');
    });
}
$("#popup").on('hidden.bs.modal', function () {
    $("#popup").html('');
});