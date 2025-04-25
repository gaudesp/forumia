import { Turbo } from "@hotwired/turbo-rails"

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
