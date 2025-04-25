import "@hotwired/turbo"
import { Application } from "@hotwired/stimulus"
import Rails from "@rails/ujs"
import "jquery"
import "bootstrap"
import "select2"
import "jscolor"
import "bbcoder"

window.Stimulus = Application.start()
Rails.start()

document.addEventListener("turbo:load", () => {
  $('#btn-preview').on('click', function() {
    $("#preview-bloc").css("display", "block");
    process();
  });

  $('#btn-refresh').on('click', function() {
    refresh();
  });

  $('#close-preview').on('click', function() {
    $("#preview-bloc").css("display", "none");
  });

  $('body').on('click', '.btn-quote', function() {
    var msg_id = $(this).parents(".topic-message").attr("id");
    $.get('/quote', { content: msg_id }, function(txt) {
      var tmp = $("#bbcoder").val();
      $("#bbcoder").val(tmp + "" + txt);
      $("#bbcoder").focus();
    });
  });

  $('body').toggleClass(localStorage.toggled);
  
  jscolor.installByClassName('jscolor');
  
  $('[data-toggle="tooltip"]').tooltip();

  $('#user_avatar').on('change', function() {
    var fileName = $(this).val();
    $(this).next('.custom-file-label').html(fileName.replace('C:\\fakepath\\', " "));
  });
  $('#user_background').on('change', function() {
    var fileName = $(this).val();
    $(this).next('.custom-file-label').html(fileName.replace('C:\\fakepath\\', " "));
  });
});

export function process() {
  let content = $("#bbcoder").val();
  $.get('/preview', { content: content }, function(txt) {
    $("#preview").html(txt);
    document.location = "#preview";
  });
}

export function refresh() {
  Turbo.visit(window.location.href);
}

export function darkLight() {
  if (localStorage.toggled != 'dark') {
    $('body').toggleClass('dark', true)
    localStorage.toggled = "dark"
  } else {
    $('body').toggleClass('dark', false)
    localStorage.toggled = ""
  }
}

window.darkLight = window.darkLight || darkLight
