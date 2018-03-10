class User < ApplicationRecord
  has_secure_password
  has_many :active_relationships, class_name: "Relationship",
    foreign_key: :follower_id, dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship",
    foreign_key: :followed_id, dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  has_many :activities
  has_many :lessons

  has_attached_file :avatar, styles: {medium: Settings.user.avatar_medium,
    thumb: Settings.user.avatar_header},
    default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  attr_accessor :activation_token

  before_save :downcase_email
  before_save :create_activation_digest

  paginates_per Settings.word.per_page

  class << self
    def digest string
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST
        : BCrypt::Engine.cost
      BCrypt::Password.create string, cost: cost
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  def authenticated? attribute, token
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  def activate
    update_attributes activated: true, activated_at: Time.zone.now
  end

  def forget
    update_attributes remember_digest: nil
  end

  def owner? user
    user == self
  end

  def follow other_user
    following << other_user
  end

  def unfollow other_user
    following.delete other_user
  end

  def following? other_user
    following.include? other_user
  end

  def learned_words abc
    !abc.blank? ?
      lessons = self.lessons.where("is_finished = (?) and category_id like (?)",true, abc) :
        lessons = self.lessons
    user_answers = Result.lesson_answers lessons.ids
    Answer.user_answers(user_answers).select :word_id, :content, :id, :is_correct
  end

  private

  def downcase_email
    email.downcase!
  end

  def create_activation_digest
    self.activation_token = User.new_token
    self.activation_digest = User.digest activation_token
  end
end
