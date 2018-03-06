class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def show
    @category = Category.find_by id: params[:id]
    @words = @category.words.includes :answers
  end

  def words
    @words = Word.includes :answers, :category
    render :show
  end
end
