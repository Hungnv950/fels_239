class AdminController < ApplicationController
  layout "admin"

  before_action :logged_in_user
  before_action :require_admin

  def index; end

  private

  def require_admin
    unless current_user.is_admin?
      redirect_to root_path
    end
  end

  def logged_in_user
    return if logged_in?
    store_location
    flash[:danger] = t "user.please_login"
    redirect_to login_url
  end
end
