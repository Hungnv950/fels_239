class CategoriesController < ApplicationController
  before_action :load_category, only: :show
  before_action :load_words, only: [:show, :words]
  before_action :load_category_search, only: [:show, :words]

  def index
    @categories = Category.category_words.order_default.select(:id, :name)
      .includes(:words).page params[:page]
  end

  def show; end

  def words
    render :show
  end

  private

  def load_category
    return if @category = Category.find_by(id: params[:id])
    flash[:danger] = t "category.not_found"
    redirect_to root_url
  end

  def load_category_search
    @categories_search = Category.order_default.category_words
  end

  def load_words
    category_id = params[:category] ? category_id = params[:category] : params[:id]
    word = params[:word]
    learned = params[:learned]
    @words = Word.search_scope(word, category_id).page params[:page]
  end
end
