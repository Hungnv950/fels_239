class ActivitiesController < ApplicationController
  before_filter :find_model

  protected
  def new
    @activity = Activity.new
  end

  def create
    @activity = Activity.new(activity_log_params)
  end

  private

  def find_activites
    @model = Activity.find_by id: params[:id]
  end
end
