$(function() {
  const resultSelector = $("#user-search-result");

  function buildHTML(user) {
    var html =
`
<div class="chat-group-user clearfix">
  <p class="chat-group-user__name">${user.name}</p>
  <a class="user-search-add chat-group-user__btn chat-group-user__btn--add" data-user-id="${user.id}" data-user-name="${user.name}">追加</a>
</div>
`
    return html;
  }

  // ユーザのインクリメンタルサーチ
  $(".edit_group").on("keyup", "#user-search-field", function() {
    var keyword = $("#user-search-field").val();
    console.log(keyword);

    if (keyword == "") {
      resultSelector.empty();
    } else {
      $.ajax({
        url: "/users",
        type: "GET",
        data: { keyword: keyword },
        dataType: "json",
        contentType: false
      })
      .done(function(users){
        if (users.length > 0) {
          $("#user-search-result").empty();
          users.forEach(function(user) {
            resultSelector.append(buildHTML(user));
          });
        }
      })
      .fail(function(){
        alert("ユーザ検索に失敗しました。");
      });
    }
  });

});
