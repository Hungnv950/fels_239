class Admin::WordsController < AdminController
  before_action :load_category, :load_words, only: [:index, :edit]
  before_action :load_word, only: [:edit, :update]

  def index
    @word = Word.new
    @title =  t "word.create"
    Settings.answer.MIN_ANSWER_NUMBER.times {@word.answers.build}
  end

  def new
    @word = Word.new
    Settings.answer.MIN_ANSWER_NUMBER.times {@word.answers.build}
    respond_to do |format|
      format.js
    end
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

  def destroy
    if params.has_key?(:id) && !params.has_key?(:word_ids)
      return unless @word = Word.find_by(id: params[:id])
      @word.destroy
    end
    if params.has_key?(:word_ids)
      @words = Word.where id: params[:word_ids]
      return if @words.size < 1
      @words.destroy_all
    end
    @words = Word.search_scope(params[:search], params[:category])
      .includes(:answers, :category)
        .order_default.page params[:page]
    @word = Word.new
    respond_to do |format|
      format.html {redirect_to @words}
      format.js
    end
  end

  def edit
    @title =  t "word.update"
    respond_to do |format|
      format.html {redirect_to @words}
      format.js
    end
  end

  def update
    @word.update_attributes word_params
    @words = Word.search_scope(params[:search], params[:category])
        .includes(:answers, :category)
          .order_default.page params[:page]
    respond_to do |format|
      format.html {redirect_to @words}
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

  def load_word
    @word = Word.find_by id: params[:id]
  end
end
