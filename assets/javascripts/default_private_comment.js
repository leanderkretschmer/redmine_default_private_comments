// default_private_comment.js
document.addEventListener("DOMContentLoaded", function () {
  var checkbox = document.getElementById("issue_private_notes");
  if (checkbox && !checkbox.checked) {
    checkbox.checked = true;
  }
});
