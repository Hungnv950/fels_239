module ApplicationHelper

  def full_title page_title = ""
    base_title = t "home.home"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  def pagination obj, per
    obj.paginate page: params[:page], per_page: per
  end

  def page_index
    params[:page] ?
      (params[:page].to_i - 1) * Settings.category.per_page + 1 : 1
  end

  def path_for_word_object object
    object.persisted? ? admin_word_url(object) : admin_words_url
  end
end
