class Admin::AnswersController < AdminController
  def destroy
    return unless @answer = Answer.find_by(id: params[:id_answer])
    @answer.destroy
    @words = Word.search_scope(params[:search], params[:category])
      .includes(:answers, :category)
        .order_default.page params[:page]
    respond_to do |format|
      format.js
    end
  end
end
