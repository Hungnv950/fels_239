$(document).ready(function(){
  $('#delete_all_category').click(function(){
    var category_ids = $('input:checkbox:checked').map(function(){
      return $(this).val();
    }).get();

    if(category_ids.length) {
      confirm(I18n.t("category.confirm"));
      if(confirm) {
        $.ajax({
          url: '/admin/categories/destroy',
          type: 'DELETE',
          dataType: "jsonp",
          data: {
            "category_ids": category_ids
          },
          success: function(){
              $("#notifi").append('<div class="alert \
                alert-success"><%= t "category.deleted" %></div>')
              $('#tbody').html('');
              $('#tbody').append('<%= j render "category" %>');
              $('#paginate').html('')
              $('#paginate').append('<%= j paginate(@categories,\
                remote: true).to_s %>')
          }
        });
      }
    }
  });
});
