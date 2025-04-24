function bbcoder(code) {
  try {
    var old = "";
    var textarea = document.getElementById("bbcoder");
    var value = textarea.value;
    var startPos = textarea.selectionStart;
    var endPos = textarea.selectionEnd;
    var selectedText = value.substring(startPos, endPos);

    switch (code) {
    case 'B':
      textarea.value = value.replaceBetween(startPos, endPos, "[b]" + selectedText + "[/b]");
      break;
    case 'I':
      textarea.value = value.replaceBetween(startPos, endPos, "[i]" + selectedText + "[/i]");
      break;
    case 'U':
      textarea.value = value.replaceBetween(startPos, endPos, "[u]" + selectedText + "[/u]");
      break;
    case 'S':
      textarea.value = value.replaceBetween(startPos, endPos, "[s]" + selectedText + "[/s]");
      break;
    case 'IMAGE':
      textarea.value = value.replaceBetween(startPos, endPos, "[img]" + selectedText + "[/img]");
      break;
    case 'YOUTUBE':
      textarea.value = value.replaceBetween(startPos, endPos, "[ytb]" + selectedText + "[/ytb]");
      break;
    case 'LINK':
      textarea.value = value.replaceBetween(startPos, endPos, "[url]" + selectedText + "[/url]");
      break;
    case 'LEFT':
      textarea.value = value.replaceBetween(startPos, endPos, "[left]" + selectedText + "[/left]");
      break;
    case 'CENTER':
      textarea.value = value.replaceBetween(startPos, endPos, "[center]" + selectedText + "[/center]");
      break;
    case 'RIGHT':
      textarea.value = value.replaceBetween(startPos, endPos, "[right]" + selectedText + "[/right]");
      break;
    default:
      alert('Argument invalide.');
      break;
    }
  } catch (e) {
    alert(e.toString());
  }
}

String.prototype.replaceBetween = function(start, end, what) {
  return this.substring(0, start) + what + this.substring(end);
};

window.bbcoder = bbcoder;
