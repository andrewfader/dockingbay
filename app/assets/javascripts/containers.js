$(document).bind('page:load', function() { readyUp() });
$(document).ready(function() { readyUp() });
function readyUp() {
  $('table').dataTable();
}
