class Admin::CategoriesController < AdminController
  before_action :page_index
  before_action :load_category, only: [:edit, :update]
  before_action :load_categories, only: [:index, :create, :update]

  def index
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    @category.save
    respond_to do |format|
      format.html {redirect_to @categories}
      format.js
    end
  end

  def edit; end

  def update
     if @category.update_attributes category_params
      flash[:success] = t "user.update_complete"
    else
      flash[:danger] = t "user.update_failed"
    end
    respond_to do |format|
      format.html {redirect_to @categories}
      format.js
    end
  end

  private

  def load_categories
    @categories = Category.search(params[:search]).includes(:words)
      .order_default.page params[:page]
  end

  def category_params
    params.require(:category).permit :name
  end

  def load_category
    @category = Category.find_by id: params[:id]
  end
end
