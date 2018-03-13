class Answer < ApplicationRecord
  belongs_to :word
  validates :content, presence: true, length: {maximum: Settings.answer.size}

  scope :user_answers, (lambda do |user_answers|
    where("id in (?)", user_answers)
  end)
  scope :correct_answers, ->{where is_correct: true}
  scope :wrong_answers, ->{where is_correct: false}

  paginates_per Settings.answer.per_page
end
