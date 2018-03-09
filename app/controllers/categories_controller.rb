class CategoriesController < ApplicationController
  before_action :load_category, only: :show
  before_action :load_words, only: :words

  def index
    @categories = Category.order_default.select(:id, :name)
      .includes(:words).page params[:page]
  end

  def show
    @words = @category.words.includes(:answers).page params[:page]
  end

  def words
    render :show
  end

  private

  def load_category
    return if @category = Category.find_by(id: params[:id])
    flash[:danger] = t "category.not_found"
    redirect_to root_url
  end

  def load_words
    @words = Word.includes(:answers, :category).page params[:page]
  end
end
