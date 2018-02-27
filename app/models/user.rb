class User < ApplicationRecord
  has_many :activities
  has_many :lessons

  attr_accessor :activation_token

  has_secure_password

  before_save :downcase_email
  validates :name, presence: true, length: {maximum: Settings.user.name}, allow_nil: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: Settings.user.email},
    format: {with: VALID_EMAIL_REGEX},
    uniqueness: {case_sensitive: false}, allow_nil: true
  validates :password, presence: true, length: {minimum: Settings.user.password}, allow_nil: true

  private

  def downcase_email
    email.downcase!
  end
end
