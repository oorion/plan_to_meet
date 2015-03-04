$(document).ready(function() {
  function toggleAngles() {
    if ($(".how-it-works i").hasClass("fa-angle-down")) {
      $(".how-it-works i").removeClass("fa-angle-down");
      $(".how-it-works i").addClass("fa-angle-up");
    } else {
      $(".how-it-works i").removeClass("fa-angle-up");
      $(".how-it-works i").addClass("fa-angle-down");
    }
  };

  $(".how-it-works-content").hide();

  $(".how-it-works").on("click", function() {
    $(".how-it-works-content").slideToggle("slow", function() {
      toggleAngles();
    });
  });
});
