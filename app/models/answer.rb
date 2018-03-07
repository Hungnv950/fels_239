class Answer < ApplicationRecord
  belongs_to :word
  validates :content, presence: true, length: {maximum: Settings.answer.size}
end
