$(document).ready(function() {
  $(".how-it-works-content").hide();
  $(".how-it-works-button").on("click", function() {
    $(".how-it-works-content").slideToggle("slow", function() {});
  });
});
