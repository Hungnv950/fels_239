require "rails_helper"

RSpec.describe "routes static", type: :routing do
  describe "home page" do
    it "routes root / to the pages controllers" do
      expect(get("/")).
        to route_to(:controller => "pages", :action => "index")
    end
  end

  describe "log" do
    context "sign up" do
      it "routes /signup to the users controller" do
        expect(get("/signup")).
          to route_to(:controller => "users", :action => "new")
      end

      it "routes /signup to the users controller" do
        expect(post("/signup")).
          to route_to(:controller => "users", :action => "create")
      end
    end

    context "login" do
      it "routes /login to the sessions controller" do
        expect(get("/login")).
          to route_to(:controller => "sessions", :action => "new")
      end

      it "routes /login to the sessions controller" do
        expect(post("/login")).
          to route_to(:controller => "sessions", :action => "create")
      end
    end
  end

  context "logout" do
    it "routes /logout to the sessions controller" do
      expect(delete("/logout")).
        to route_to(:controller => "sessions", :action => "destroy")
    end
  end
end
