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
//= require jquery3
//= require popper
//= require bootstrap
//= require select2-full
//= require jscolor
//= require risibank
//= require turbolinks
//= require_tree .


$(document).on('turbolinks:load', function() {
  $('#btn-preview').on('click',function(){
    $("#preview-bloc").css("display", "block");
    process();
  });
  $('#btn-refresh').on('click',function(){
    refresh();
  });
  $('#close-preview').on('click',function(){
    $("#preview-bloc").css("display", "none");
  });
  $('body').on('click', '.btn-quote', function(){
    var msg_id = ""
    msg_id = $(this).parents(".topic-message").attr("id")
    console.log(msg_id)
    $.get('/quote', {
      content: msg_id
    },
    function(txt) {
      var tmp = $("#bbcoder").val();
      var space = ""
      if ($.trim(tmp)) {
        space = "\n\n"
      }
      $("#bbcoder").val(tmp + space + txt);
      $("#bbcoder").focus()
    })
  })
  RisiBank.activate('bbcoder')
  $('body').toggleClass(localStorage.toggled)
  jscolor.installByClassName('jscolor')
  $('[data-toggle="tooltip"]').tooltip()
  $('#user_avatar').on('change',function() {
    var fileName = $(this).val()
    $(this).next('.custom-file-label').html(fileName.replace('C:\\fakepath\\', " "))
  })
  $('#user_background').on('change',function() {
    var fileName = $(this).val()
    $(this).next('.custom-file-label').html(fileName.replace('C:\\fakepath\\', " "))
  })
})

var content = "";
function process() {
  if (content != $("#bbcoder").val()) {
    content = $("#bbcoder").val();
    $.get('/preview', {
      content: content
    },
    function(txt) {
      $("#preview").html(txt);
      document.location = "#preview"
    })
  }
}

function refresh() {
  Turbolinks.visit(window.location.href);
}

function darkLight() {
  if (localStorage.toggled != 'dark') {
    $('body').toggleClass('dark', true)
    localStorage.toggled = "dark"
  } else {
    $('body').toggleClass('dark', false)
    localStorage.toggled = ""
  }
}
