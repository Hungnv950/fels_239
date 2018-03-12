class Answer < ApplicationRecord
  belongs_to :word
  belongs_to :result
  validates :content, presence: true, length: {maximum: Settings.answer.size}
end
