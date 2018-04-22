$(function() {
  function buildHTML(message) {
    var html = `<div class="message-header">
                  <div class="message-header__user-name">
                    ${message.user_name}
                  </div>
                  <div class="message-header__posted-date">
                    ${message.created_at}
                  </div>
                </div>
                <div class="message-body">`

    if (message.content != "") {
      html += `<div class="message-body__content">
                ${message.content}
              </div>`
    }
    if (message.image != null) {
      html += `<div class="message-body__image">
                 <img src="${message.image}">
               </div>`
    }
    html += `</div>`
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
      $(".messages").append(html);
    })
    .fail(function(){
      alert("メッセージの送信に失敗しました。");
    });
  });
});
