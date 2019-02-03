require 'rails_helper'

RSpec.describe OutletsController, type: :controller do
  fixtures :outlets, :articles

  before do
    @outlet_cnn = outlets(:cnn)
    @outlet_fox = outlets(:fox)
    @recent_article = articles(:recent)
    @old_article = articles(:old)
  end

  describe "#Outlets :show" do
    render_views
    context "with articles" do
      it "is able to show outlet specific articles" do
        get :show, params: { id: @outlet_cnn.id }
        expect(response.body).to include(@recent_article.title)
        expect(response.body).to include(@old_article.title)
      end
    end
    context "without articles" do
      it "should show alert message" do
        Article.delete_all
        get :show, params: { id: @outlet_cnn.id }
        expect(response.body).to include("Well done!")
      end
    end
  end

  describe "#Outlets :index" do
    render_views
    context "with outlets" do
      it "is able to show outlets" do
        get :index
        expect(response.body).to include(outlet_path(@outlet_cnn).to_s)
        expect(response.body).to include(outlet_path(@outlet_fox).to_s)
      end
    end
    context "without outlets" do
      it "should show alert message" do
        Article.delete_all
        Outlet.delete_all
        get :index
        expect(response.body).to_not include(outlet_path(@outlet_cnn).to_s)
        expect(response.body).to_not include(outlet_path(@outlet_fox).to_s)
        expect(response.body).to include("Well done!")
      end
    end
  end

end
