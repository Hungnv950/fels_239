class Admin::CategoriesController < AdminController
  before_action :page_index
  before_action :load_category, only: [:edit, :update]
  before_action :load_categories

  def index
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    @category.save
    UserNotificationService.new(current_user).notify @category.id
    respond_to do |format|
      format.html {redirect_to @categories}
      format.js
    end
  end

  def edit; end

  def update
    @category.update_attributes category_params
    respond_to do |format|
      format.html {redirect_to @categories}
      format.js
    end
  end

  def destroy
    if params.has_key?(:id) && !params.has_key?(:category_ids)
      return unless @category = (Category.find_by id: params[:id])
      @category.destroy
    end
    if params.has_key?(:category_ids)
      @categories= Category.where id: params[:category_ids]
      return if @categories.size < 1
      @categories.destroy_all
    end
    @categories = Category.search(params[:search]).includes(:words)
      .order_default.page params[:page]
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
    return if @category = (Category.find_by id: params[:id])
    flash[:danger] = t "category.not_found"
    redirect_to admin_categories_url
  end
end
