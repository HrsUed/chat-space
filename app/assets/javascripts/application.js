// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

// 画像サイズも考慮してスクロールするためにreadyではなくonload方式で記述
// ただし、group/group_id/messages/indexを表示した際は実行されない
// TODO: 上記のただし分を修正し、グループ選択時にも最下部にスクロールするように修正
$(window).on("load", function() {
  scrollToBottom(".messages");
});

function scrollToBottom(targetName) {
  var targetSelector = $(targetName);
  var scrollPosition = targetSelector.get(0).scrollHeight;
  targetSelector.scrollTop(scrollPosition);
  console.log(targetSelector.scrollTop());
  // targetSelector.animate({scrollTop: scrollPosition}, 'fast');
};
