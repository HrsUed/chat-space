$(function() {
  $(".edit_group").on("keyup", "#user-search-field", function(e) {
    var keyword = $("#user-search-field").val();

    $.ajax({
      url: "/users",
      type: "GET",
      data: { keyword: keyword },
      dataType: "json",
      contentType: false
    })
    .done(function(names){
      console.log(names);
    })
    .fail(function(){

    })
    .always(function(){

    });
  });
});
