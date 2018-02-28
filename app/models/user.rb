class User < ApplicationRecord
  has_many :activities
  has_many :lessons

  attr_accessor :activation_token

  has_secure_password

  before_save :downcase_email

  private

  def downcase_email
    email.downcase!
  end
end
