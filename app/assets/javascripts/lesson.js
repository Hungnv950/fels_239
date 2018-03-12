$(document).ready(function(){
  $('body').on('click', '#save_lesson', function() {
    $('#lesson_is_finished').val('false');
  });
  $('body').on('click', '#finish_lesson', function() {
    $('#lesson_is_finished').val('true');
  });
});
