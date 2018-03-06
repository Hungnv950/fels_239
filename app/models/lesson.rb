class Lesson < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :results, dependent: :destroy
  has_many :words, through: :results
  has_many :answers, through: :results
  accepts_nested_attributes_for :results, allow_destroy: true

  before_create :create_words

  class << self

    def generate_words category_id
      @category = Category.find_by id: category_id
      @words = @category.words.select(:id).order("RANDOM()")
        .limit(Settings.lesson.words_size).map(&:id)
      result = @words.each_with_index.map{|v, index| [index, {word_id: v}]}.to_h
      result
    end
  end

  private

  def create_words
    words = self.category.words.order("RANDOM()")
      .limit(Settings.lesson.words_size)
    words.each{|word| self.results.build word_id: word.id}
  end
end
