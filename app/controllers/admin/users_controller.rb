class Admin::UsersController < AdminController
  before_action :load_user, only: :destroy

  def index
    @users = User.select(:id, :name, :email, :activated, :is_admin)
      .search(params[:search])
    @users_size = @users.size
    @users = @users.order_default.page params[:page]
    @user = User.new
    @title = t "user.create"
  end

  def destroy
    if @user.destroy
      flash[:success] = t "user.deleted"
    else
      flash[:success] = t "user.delete_failed"
    end
    redirect_to admin_users_url
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password,
      :activated, :is_admin
  end

  def load_user
    return if @user = User.find_by(id: params[:id])
    flash[:danger] = t "user.not_found"
    redirect_to root_url
  end
end
