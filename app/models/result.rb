class Result < ApplicationRecord
  belongs_to :lesson
  belongs_to :answer
  belongs_to :word

  validates :word, presence: true

  scope :lesson_answers, ->lessons do
    select(:answer_id).where "lesson_id in (?)", lessons
  end
end
