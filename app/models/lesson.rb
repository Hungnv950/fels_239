class Lesson < ApplicationRecord

  belongs_to :user
  belongs_to :category
  has_many :results, dependent: :destroy
  accepts_nested_attributes_for :results, allow_destroy: true

  class << self

    def generate_words category_id
      @category = Category.find_by id: category_id
      @words = @category.words.select(:id).order("RANDOM()")
        .limit(Settings.lesson.words_size).map(&:id)
      result = @words.each_with_index.map{|v, index| [index, {word_id: v}]}.to_h
      result
    end
  end
end
