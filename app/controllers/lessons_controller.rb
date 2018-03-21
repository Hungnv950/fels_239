class LessonsController < ApplicationController
  before_action :load_lesson, only: [:show, :update]
  before_action :logged_in_user, except: [:index, :show, :words]
  after_action :log_update, only: [:create, :update]

  def show; end

  def create
    if params[:category_id]
      category_id = params[:category_id]
      @lesson = Lesson.new category_id: category_id, user_id: current_user.id
      if @lesson.save
        flash[:success] = t "lesson.created"
        redirect_to @lesson
      else
        flash[:success] = t "lesson.create_failed"
        redirect_to @categories
      end
    end
  end

  def update
    @lesson.update_attributes lesson_params
    if @lesson.is_finished
      flash[:success] = t "lesson.finished"
    else
      flash[:success] = t "lesson.saved"
    end
    redirect_to @lesson
  end

  private

  def lesson_params
    params.require(:lesson).permit :category_id, :user_id, :is_finished,
      results_attributes: [:id, :answer_id, :word_id]
  end

  def load_lesson
    return if @lesson = Lesson.find_by(id: params[:id])
    flash[:danger] = t "lesson.not_found"
    redirect_to root_url
  end

  def logged_in_user
    return if logged_in? && (@lesson.user_id == current_user.id || current_user.is_admin?)
    store_location
    flash[:danger] = t "lesson.permission"
    redirect_to @lesson
  end

  def log_update
    if action_name == "index"
      action_type = 2
    else
      action_type = (action_name == "create") ? 3 : 4
    end
    target_id = params[:id] ? params[:id] : @lesson.id
    Activity.create(
      :user_id => current_user.id,
        :target_id => target_id, :action_type => action_type)
  end
end
