class LessonsController < ApplicationController
  def index
    @lessons = Lesson.all
  end

  def show; end

  def create
    if params[:category_id]
      category_id = params[:category_id]
      @lesson = Lesson.new category_id: category_id, user_id: current_user.id,
          results_attributes: Lesson.generate_words(category_id)
      if @lesson.save
        flash[:success] = t "lesson.created"
        redirect_to @lesson
      else
        flash[:success] = t "lesson.create_failed"
        redirect_to @categories
      end
    else
      flash[:success] = t "lesson.created"
        redirect_to @lesson

    end
  end

  private

  def lesson_params
    params.require(:lesson).permit results_attributes: [:id, :word_id, :answer_id]
  end

  def load_lesson
    @lesson = Lesson.find_by id: params[:id]
  end
end
