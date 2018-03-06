class CategoriesController < ApplicationController
  before_action :load_category
  def index
    @categories = Category.all
  end

  def show
    @category = Category.find_by id: params[:id]
    @words = @category.words.includes :answers
  end

  def words
    @words = Word.search_scope(params[:search], params[:category])
      .includes(:answers, :category)
        .order_default.page params[:page]
    render :show
  end

  def load_category
    @categories_search = Category.select :id, :name
  end
end
