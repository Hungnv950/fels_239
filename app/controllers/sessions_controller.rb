class SessionsController < ApplicationController
  before_action :load_user, except: [:index, :new, :create]

  def new; end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user && user.authenticate(params[:session][:password])
      if user.activated?
        log_in user
        params[:session][:remember_me] == "1" ? remember(user) : forget(user)
        redirect_back_or user
      else
        message  = t("account.not_actived") + t("account.check_email")
        flash[:warning] = message
        redirect_to root_url
      end
    end
  end

  def destroy
    log_out
    redirect_to root_url
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
end
