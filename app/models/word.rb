class Word < ApplicationRecord
  belongs_to :category

  has_many :results, dependent: :destroy
  has_many :answers, dependent: :destroy

  paginates_per Settings.word.per_page
  scope :order_default, -> {order created_at: :DESC}
  scope :search_scope, (lambda do |word, category|
    where('content like :word and category_id like :category',
      word: "%#{word}%", category: "%#{category}%")
  end)
end
