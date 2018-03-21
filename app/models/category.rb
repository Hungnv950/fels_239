class Category < ApplicationRecord
  validates :name, presence: true, uniqueness: true, numericality: false

  has_many :words
  has_many :lessons

  paginates_per Settings.category.per_page
  scope :order_default, -> {order created_at: :DESC}
  scope :search, (lambda do |query|
    where('name like :query', query: "%#{query}%")
  end)
end
