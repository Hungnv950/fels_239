class PagesController < ApplicationController
  def index
    @activities = Activity.all.order(created_at: :DESC).page params[:page]
  end
end
