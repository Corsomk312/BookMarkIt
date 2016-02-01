$(document).ready(function() {
  $("#bookmark-form").hide();
  $("#add-bookmark").on("click", "button", function() {
    $("#bookmark-button").hide();
    $("#bookmark-form").show();
  })
})