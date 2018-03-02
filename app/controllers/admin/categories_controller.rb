class Admin::CategoriesController < AdminController
  before_action :page_index
  def index
    @categories = Category.search(params[:search]).includes(:words)
      .order_default.page params[:page]
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    @category.save
    @categories = Category.includes(:words).order_default.page params[:page]
    respond_to do |format|
      format.html {redirect_to @categories}
      format.js
    end
  end

  private

  def category_params
    params.require(:category).permit :name
  end
end
