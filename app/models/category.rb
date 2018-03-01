class Category < ApplicationRecord
  has_many :words
  has_many :lessons

  paginates_per Settings.category.per_page
  scope :order_default, -> {order(created_at: :desc)}

  def self.search search
    where "name LIKE ?", "%#{search}%"
  end
end
