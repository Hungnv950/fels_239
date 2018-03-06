$(document).ready(function(){
  progress_count();
  $('body input').on('change', function() {
    progress_count();
  });
});

function progress_count(count) {
  var count = $('input:radio:checked').length;
  $('#progress_count').html(count);
}
