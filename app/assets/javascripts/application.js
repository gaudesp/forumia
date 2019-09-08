// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require_tree .
//= require jquery3
//= require popper
//= require bootstrap
//= require select2-full
//= require turbolinks

$(document).on('turbolinks:load', function() {
  $('body').toggleClass(localStorage.toggled);
  $('[data-toggle="tooltip"]').tooltip();
  var isPlaying = true
  if ( isPlaying == true) {
    $('#popup-youtube-player').get(0).contentWindow.postMessage('{"event":"command","func":"playVideo","args":""}','*');
  }
  $('#stop').on('click', function() {
    if ( isPlaying == true) {
      $('#popup-youtube-player').get(0).contentWindow.postMessage('{"event":"command","func":"pauseVideo","args":""}','*');
      isPlaying = false;
      $(this).children("i").attr("class", "fas fa-play");
    } else {
      $('#popup-youtube-player').get(0).contentWindow.postMessage('{"event":"command","func":"playVideo","args":""}','*');
      isPlaying = true;
      $(this).children("i").attr("class", "fas fa-pause");
    }
  })
})
function darkLight() {
  if (localStorage.toggled != 'dark') {
    $('body').toggleClass('dark', true);
    localStorage.toggled = "dark";
  } else {
    $('body').toggleClass('dark', false);
    localStorage.toggled = "";
  }
}
