require "rails_helper"

RSpec.describe User, type: :model do

  let!(:user1){FactoryGirl.create :user}
  let(:user){FactoryGirl.create :user}
  let(:admin){FactoryGirl.create :admin, is_admin: true}

  subject {user}

  context "associations" do
    it {is_expected.to have_many :lessons}
    it {is_expected.to have_many :activities}
  end

  describe "db schema" do
    context "columns" do
      it {is_expected.to have_db_column(:email).of_type(:string)}
      it {is_expected.to have_db_column(:name).of_type(:string)}
      it {is_expected.to have_db_column(:adress).of_type(:string)}
      it {is_expected.to have_db_column(:is_admin).of_type(:boolean)}
      it {is_expected.to have_db_column(:password_digest).of_type(:string)}
      it {is_expected.to have_db_column(:remember_digest).of_type(:string)}
      it {is_expected.to have_db_column(:activation_digest).of_type(:string)}
      it {is_expected.to have_db_column(:activated).of_type(:boolean)}
      it {is_expected.to have_db_column(:activated_at).of_type(:datetime)}
      it {is_expected.to have_db_column(:reset_digest).of_type(:string)}
      it {is_expected.to have_db_column(:reset_sent_at).of_type(:datetime)}
    end
  end

  describe "validations" do
    it {should validate_presence_of(:name)}
    it {should validate_presence_of(:email) }
    it {should validate_uniqueness_of(:email)}
    # it {should validate_presence_of(:password)}
    it {should validate_length_of(:password)}

    context "when password is too short" do
      before {subject.password = Faker::Lorem.characters(2)}
      it "matches the error message" do
        subject.valid?
        subject.errors[:password].should include("is too short (minimum is 6 characters)")
      end
    end
  end

  describe "instance methods" do
    it {should respond_to(:authenticated?)}
    it {should respond_to(:activate)}
    it {should respond_to(:forget)}
    it {should respond_to(:owner?)}
    it {should respond_to(:follow)}
    it {should respond_to(:unfollow)}
    it {should respond_to(:following?)}
    it {should respond_to(:learned_words)}
  end
end
