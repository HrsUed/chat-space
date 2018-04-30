$(function() {
  function updateMessages() {

    if ($("div").hasClass("messages")) {
      var targetSelector = $(".messages");

      $.ajax({
        url: location.href,
        type: "GET",
        dataType: "json",
        processData: false,
        contentType: false
      })
      .done(function(messages) {
        messages.forEach(function(message) {
          if ($("#message-id-" + message.id).val() == undefined) {
            targetSelector.append(buildMessageHTML(message));
          }
        });
        targetSelector.animate({scrollTop: targetSelector.get(0).scrollHeight});
      })
      .fail(function() {

      });
    }
  }

  setInterval(updateMessages, 5000);

});
