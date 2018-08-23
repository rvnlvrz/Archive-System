let distance = $('#header').offset().top;

$(window).scroll(() => {
    if ($(window).scrollTop() > distance) {
        $('#home-nav-brand').fadeIn(500);
        $('#home-nav-brand').text("The Cardinal Archives");
        $('#navbar').removeClass("bg-mapuan-gold").addClass("bg-mapuan-red");
    }
    else {
        $('#home-nav-brand').fadeOut(500);
        $('#home-nav-brand').text("");
        $('#navbar').removeClass("bg-mapuan-red").addClass("bg-mapuan-gold");
    }
});
