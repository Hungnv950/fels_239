class LessonsController < ApplicationController
  before_action :load_lesson, only: [:show, :update]

  def index
    @lessons = Lesson.all
  end

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
      results_attributes: [:id, :answer_id]
  end

  def load_lesson
    @lesson = Lesson.find_by id: params[:id]
  end
end
