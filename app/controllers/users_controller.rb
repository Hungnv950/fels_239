class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :destroy]
  before_action :load_user, only: [:show]

  def index; end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    @user.avatar = "user.png"
    if @user.save
      UserMailer.account_activation(@user).deliver_now
      flash[:success] = t "account.check_email"
      redirect_to root_url
    else
      render :new
    end
  end

  private

  def load_user
    return if @user = User.find_by(id: params[:id])
    flash[:danger] = t "user.not_found"
    redirect_to root_url
  end

  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation
  end

  def logged_in_user
    return if logged_in?
    store_location
    flash[:danger] = t "user.please_login"
    redirect_to login_url
  end
end
