require "rails_helper"

RSpec.describe "route for Users", type: :routing do
  describe "routing resources" do
    context "is valid" do
      it "routes to #show" do
        expect(get: "/users/1").to route_to("users#show", id: "1")
      end

      it "routes to #new" do
        expect(get: "/users/new").to route_to("users#new")
      end

      it "routes to #update via PUT" do
        expect(put: "/users/1").to route_to("users#update", id: "1")
      end

      it "routes to #update via PATCH" do
        expect(patch: "/users/1").to route_to("users#update", id: "1")
      end

      it "routes to #create via POST" do
        expect(post: "/users").to route_to("users#create")
      end

      it "routes to #delete via POST" do
        expect(DELETE: "/users/1").to route_to("users#destroy", id: "1")
      end
    end

    context "is invalid" do
      it "routes to #index" do
        expect(get: "/users").not_to route_to("users#index")
      end
    end
  end
end
