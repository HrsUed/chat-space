$(function() {
  function buildHTML(message) {
    const content_html = message.content == "" ? `` : `<div class="message-body__content">${message.content}</div>`
    const image_html = message.image == null ? `` : `<div class="message-body__image"><img src="${message.image}"></div>`

    const html =
`
<div class="message-header">
  <div class="message-header__user-name">
    ${message.user_name}
  </div>
  <div class="message-header__posted-date">
    ${message.created_at}
  </div>
</div>
<div class="message-body">
  ${content_html}
  ${image_html}
</div>
`

    return html;
  }

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
      var html = buildHTML(data);
      var targetSelector = $(".messages");

      targetSelector.append(html);
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
