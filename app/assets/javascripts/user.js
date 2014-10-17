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
        $(".video").css({
          "position": "fixed",
          "width": "100%",
          "height": "100%",
          "margin-top": "-90px"
        });
        $(".items-container").css("margin-left", "34.69%")
        $(".item-container").css("margin-left", "34.69%")
      }
      if ((scroll <= 90) && $(".artist").css("position") == "fixed") {
        $(".artist").css({
          "position": "static",
          "width": "32.7%",
          "height": "100%",
          "margin-top": "0px"
        });
        $(".items-container").css("margin-left", "0")
        $(".item-container").css("margin-left", "0")
      }
  });
  var t = setInterval(function(){
    if ($(".item-images ul li").length > 1) {
      $(".item-images ul").animate({marginLeft:-480},1000,function(){
        $(this).find("li:last").after($(this).find("li:first"));
        $(this).css({marginLeft:0});
      })
    }
  },5000);

  $( document ).on("mouseover", function() {
    $( ".exit" ).on("click", function() {
      $(".item-container").remove();
    });
  });
});
