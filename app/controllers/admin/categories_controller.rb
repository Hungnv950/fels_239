class Admin::CategoriesController < AdminController
  before_action :page_index
  def index
    search = params[:search]
    @categories = Category.search(search).includes(:words).page params[:page]
  end
end
