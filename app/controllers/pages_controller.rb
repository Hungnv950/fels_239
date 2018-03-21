class PagesController < ApplicationController
  def index
    @activities = Activity.all.order(created_at: :DESC)
    if @activities.size < 0
      flash[:primary] = "activity.nil"
      redirect_to root_url
    end
    @activities = @activities.map do |activity|
      activity.view_activities
    end
    @activities = Kaminari.paginate_array(@activities).page params[:page]
  end
end
