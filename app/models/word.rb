class Word < ApplicationRecord
  validates :content, presence: true, uniqueness: true,
    numericality: false, length: {maximum: Settings.word.MAXIUM_SIZE}
  belongs_to :category

  has_many :results, dependent: :destroy
  has_many :answers, dependent: :destroy
  accepts_nested_attributes_for :answers, allow_destroy: true,
    :reject_if => proc {|attributes|
      attributes.all? {|k,v| v.blank?}
    }
  validates_presence_of :answers

  paginates_per Settings.word.per_page

  scope :order_default, -> {order created_at: :DESC}
  scope :search_scope, (lambda do |word, category|
    where('content like :word and category_id like :category',
      word: "%#{word}%", category: "%#{category}%")
  end)

  def answers_attributes answers_attributes
    count = 0
    answers = Array.new
    answers_attributes.each do |k, answer|
      count = count + 1 if answer[:is_correct] == 1
      if answers.include? answer[:content]
        return false
      end
      answers.push answer[:content]
    end
    if count == answers.size || count == 0
      return false
    end
  end

  private
end
