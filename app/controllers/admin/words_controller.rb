class Admin::WordsController < AdminController
  before_action :load_words, :load_category, only: [:index, :create]

  def index
    @word = Word.new
    2.times {@word.answers.build}
  end

  def new
     @word = Word.new
  end

  def create
    @word = Word.new word_params
    if params["word"]["answers_attributes"]
      @word.errors.add(:base, "answer_exist") if
        @word.answers_attributes params["word"]["answers_attributes"]
      if @word.valid?
        @word.save
        @words = Word.search_scope(params[:search], params[:category])
          .includes(:answers, :category)
            .order_default.page params[:page]
      end
    end
    respond_to do |format|
      format.html {redirect_to @categories}
      format.js
    end
  end

  private

  def load_words
    @words = Word.search_scope(params[:search], params[:category])
      .includes(:answers, :category)
        .order_default.page params[:page]
  end

  def load_category
    @categories_search = Category.select :id, :name
  end

  def word_params
    params.require(:word).permit :content, :category_id,
      answers_attributes: [:id, :is_correct, :content]
  end

  def validater words

  end
end
