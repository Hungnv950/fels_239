class Category < ApplicationRecord
  validates :name, presence: true, uniqueness: true, numericality: false

  has_many :words
  has_many :lessons

  paginates_per Settings.category.per_page
  scope :order_default, -> {order(created_at: :DESC)}

  def self.search search
    where "name LIKE ?", "%#{search}%"
  end
end
