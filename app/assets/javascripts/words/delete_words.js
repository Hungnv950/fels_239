$(document).ready(function(){
  $('#delete_all_words').click(function(){
    var word_ids = $('input:checkbox:checked').map(function(){
      return $(this).val();
    }).get();

    if(word_ids.length) {
      confirm(I18n.t("category.confirm"));
      if(confirm) {
        $.ajax({
          url: '/admin/words/destroy',
          type: 'DELETE',
          dataType: "jsonp",
          data: {
            "word_ids": word_ids
          },
          success: function(){
          }
        });
      }
    }
  });
});
