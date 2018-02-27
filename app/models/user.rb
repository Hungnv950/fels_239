class User < ApplicationRecord
  has_many :activities
  has_many :lessons
end
