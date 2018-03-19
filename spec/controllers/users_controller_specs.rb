require "rails_helper"

RSpec.describe UsersController, type: :controller do
  describe "GET new" do
    it "assigns a blank user to the view" do
      get :new
      is_expected(assigns(:user)).to be_a_new(User)
    end
  end
end
