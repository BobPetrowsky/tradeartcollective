$( document ).ready(function() {
  $(window).scroll(function() {
      var scroll = $(window).scrollTop();
      if (scroll >= 90) {
        $(".artist").css({
          "position": "fixed",
          "width": "32.7%",
          "height": "100%",
          "margin-top": "-90px"
        });
        $(".items-container").css("margin-left", "34.69%")
      }
      if (scroll <= 90) {
        $(".artist").css({

        });
      }
  });
});

// 443px 834px
