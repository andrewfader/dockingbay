$(document).bind('page:load', function() { readyUp() });
$(document).ready(function() { readyUp() });
function readyUp() {
  $('table').dataTable({
    "bJQueryUI": true
  });

  $('input[type="submit"]').button();
}
