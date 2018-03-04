$(document).ready(function(){
  $('body').on('click', '#duplicate_nested_form', function() {
    var count_answer = count_answer_input();
    count_answer = count_answer + 1;
    if(count_answer < 6) {
      $('input#count_answer').val(count_answer + 1);
      $('#table-form').append(
        '<tr class="center">\
            <td>\
              <input class="form-control answer_unique input_answer"\
                type="text"\
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

  var count_save = 2;
  var id_answer;
  $('body').on('click', '.remove_answer', function() {
    validate_checkbox();
    validate_answer();
    var total_answer = count_answer_input();
    if(total_answer <= count_save) {
      alert(I18n.t("word.min"));
      return;
    }
    event.preventDefault();
    id_answer = $(this).parents('tr').next('input').attr('value');
    if(id_answer) {
      confirm(I18n.t("category.confirm"));
      if(confirm) {
        $.ajax({
          url: '/admin/answers/destroy',
          type: 'DELETE',
          dataType: 'jsonp',
          data: {
            'id_answer': id_answer
          },
          success: function(){
          }
        });
      }
    }
    $(this).parents('tr').next('input').remove();
    $(this).parents('tr').remove();
  });

  $('body').on('click', '#create_word', function(){
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
      if(jQuery.inArray(input.val(), arr_words)!='-1') {
        alert(input.val() +' '+ I18n.t("word.exits"));
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

  function count_answer_input(){
    return parseInt($('#table-form input[type="checkbox"]').length);
  }
});
