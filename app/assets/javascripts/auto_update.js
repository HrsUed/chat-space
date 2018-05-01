$(function() {
  function updateMessages() {

    if ($("div").hasClass("messages")) {
      var targetSelector = $(".messages");

      var latest_message_id = $(".message:last-child").data("message-id");

      $.ajax({
        url: location.href,
        type: "GET",
        data: { latest_message_id: latest_message_id },
        dataType: "json",
        contentType: false
      })
      .done(function(messages) {
        messages.forEach(function(message) {
          targetSelector.append(buildMessageHTML(message));
        });
        targetSelector.animate({scrollTop: targetSelector.get(0).scrollHeight});
      })
      .fail(function() {

      });
    }
  }

  setInterval(updateMessages, 5000);

});
