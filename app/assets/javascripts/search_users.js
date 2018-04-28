$(document).on("turbolinks:load", function() {
  const resultSelector = $("#user-search-result");
  const userListSelector = $("#user-list");

  function buildSearchResultHTML(user) {
    var html =
`
<div class="chat-group-user clearfix">
  <p class="chat-group-user__name">${user.name}</p>
  <a class="user-search-add chat-group-user__btn chat-group-user__btn--add" data-user-id="${user.id}" data-user-name="${user.name}">追加</a>
</div>
`
    return html;
  }

  function buildAddedUserHTML(user_name, user_id) {
    var html =
`
<div class="chat-group-user clearfix">
  <p class="chat-group-user__name">${user_name}</p>
  <a class="user-search-add chat-group-user__btn chat-group-user__btn--remove" data-user-id="${user_id}">削除</a>
</div>
`

    return html;
  }


  // ユーザのインクリメンタルサーチ
  $(".edit_group").on("keyup", "#user-search-field", function() {
    var keyword = $("#user-search-field").val();

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
            resultSelector.append(buildSearchResultHTML(user));
          });
        }
      })
      .fail(function(){
        alert("ユーザ検索に失敗しました。");
      });
    }
  });

  // ユーザの追加
  resultSelector.on("click", ".chat-group-user__btn--add", function() {
    var user_name = $(this).attr("data-user-name");
    var user_id = $(this).attr("data-user-id");
    userListSelector.append(buildAddedUserHTML(user_name, user_id));
    $("[data-user-id=" + user_id + "]").parent().get(0).remove();  // 検索結果からの削除
  });

  // ユーザの削除
  userListSelector.on("click", ".chat-group-user__btn--remove", function() {
    $(this).parent().get(0).remove();
  });
});
