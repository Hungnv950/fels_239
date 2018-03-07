class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_locale
  include SessionsHelper
  include ApplicationHelper

  layout :user_layout

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  private

  def user_layout
    admin? ? "admin" : "application"
  end

  def admin?
    false
  end
end
