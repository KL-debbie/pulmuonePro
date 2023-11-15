
$(function(){
  
    $(".btn-menu, .gnb-close").on("click", toggleMenu);
    function toggleMenu() {
        if ($("#gnb-item").css("display") == "block") {
          $("#gnb-item").slideUp();
        }
        else {
          $("#gnb-item").slideDown();
        }
    }

    $(document).on("click", "#pagable-list .card-header", function () {
        var card = $(this).parents(".card");
        if (card.hasClass("active")) {
          card.removeClass("active");
        } else {
          card.addClass("active");
        }
    });
})