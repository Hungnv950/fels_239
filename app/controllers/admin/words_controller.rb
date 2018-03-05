class Admin::WordsController < AdminController
  before_action :load_words, :load_category, only: :index

  def index; end

  private

  def load_words
    @words = Word.search_scope(params[:search],
      params[:category]).includes(:answers, :category)
        .order_default.page params[:page]
  end

  def load_category
    @categories_search = Category.select :id, :name
  end
end
