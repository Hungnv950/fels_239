require "rails_helper"

RSpec.describe "admin routing", :type => :routing do
  it "routes /admin/index to admin controller" do
    expect(get("/admin")).
      to route_to("admin#index")
  end

  describe "admin/categories to namespace admin, categories controller" do
    it "routes /admin/categories/index to admin/categories controller" do
      expect(get("/admin/categories")).
        to route_to("admin/categories#index")
    end

    it "routes /admin/categories/new to admin/categories controller" do
      expect(get("/admin/categories/new")).
        to route_to(:controller => "admin/categories", :action => "index")
    end

    # it "routes /admin/categories/create to admin/categories controller" do
    #   expect(get("/admin/categories/create")).
    #     to route_to("admin/categories#create")
    # end
  end
end
