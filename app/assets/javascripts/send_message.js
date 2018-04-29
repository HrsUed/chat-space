$(document).on("turbolinks:load", function() {

  $("#new_message").on("submit", function(e) {
    e.preventDefault();
    var formData = new FormData(this);
    var url = $(this).attr("action");

    $.ajax({
      url: url,
      type: "POST",
      data: formData,
      dataType: "json",
      processData: false,
      contentType: false
    })
    .done(function(data){
      var targetSelector = $(".messages");

      targetSelector.append(buildMessageHTML(data));
      targetSelector.animate({scrollTop: targetSelector.get(0).scrollHeight});
      $(".form__text").val("");
    })
    .fail(function(){
      alert("メッセージの送信に失敗しました。");
    })
    .always(function(){
      // Rails5から追加となったsubmitのdisabled設定を解除
      $(".form__submit").removeAttr("disabled");

      // 選択されたファイルのクリア
      $("#message_image").val("");
    });
  });
});
