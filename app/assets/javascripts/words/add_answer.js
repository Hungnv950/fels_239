$(document).ready(function(){
  var count_answer = parseInt($('#count_answer').val());
  $('#duplicate_nested_form').click(function() {
    count_answer = count_answer + 1;
    if(count_answer < 6) {
      $('input#count_answer').val(count_answer + 1);
      $('#table-form').append(
        '<tr class="center">\
            <td>\
              <input class="form-control answer_unique" type="text"\
                name="word[answers_attributes]['+ count_answer +'][content]"\
                 id="word_answers_attributes_'+ count_answer +'_content" />\
            </td>\
            <td>\
              <input name="word[answers_attributes]['+ count_answer +'][is_correct]"\
                type="hidden" value="0" />\
                <input type="checkbox" value="1"\
                  name="word[answers_attributes]['+ count_answer +'][is_correct]"\
                    id="word_answers_attributes_'+ count_answer +'_is_correct" />\
            </td>\
            <td>\
              <span class="btn glyphicon glyphicon-remove remove_answer"\
                id=remove_answer'+count_answer+'></span>\
            </td>\
          </tr>'
      );
    }
    else {
      alert(I18n.t("word.max"))
    }
  });

  $('body').on('click', '.remove_answer', function() {
    var remove_answer_id = this.id;
    event.preventDefault();
    $(this).parents('tr').remove();
  });

  $('#create_word').click(function(){
    validate_checkbox();
    validate_answer();
  });

  function validate_answer(){
    var arr_words = [];
    $('form input.answer_unique').each(function(index){
      var input = $(this);
      if(input.val() == null || input.val() == '') {
          alert(input.val() +' '+ I18n.t("word.present"));
          event.preventDefault();
          return false;
        }
      if (jQuery.inArray(input.val(), arr_words)!='-1') {
        alert(input.val() +" "+ I18n.t("word.exits"));
        event.preventDefault();
        return false;
      }
      arr_words.push(input.val());
    });
  };

  function validate_checkbox() {
    var number_checked =
      parseInt($('#table-form input[type="checkbox"]:checked').length);
    var total_checkbox =
      parseInt($('#table-form input[type="checkbox"]').length);
    if(number_checked < 1 || number_checked == total_checkbox ){
      alert(I18n.t("word.checkbox"));
      event.preventDefault();
      return false;
    }
  }
});
