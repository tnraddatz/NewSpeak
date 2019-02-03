require 'rails_helper'

RSpec.describe StaticPagesController, type: :controller do
  fixtures :outlets, :articles
  before do
    @outlet_cnn = outlets(:cnn)
    @outlet_fox = outlets(:fox)
    @recent_article = articles(:recent)
    @old_article = articles(:old)
    @fox_article = articles(:foxarticle)
  end

  describe "#StaticPages :home" do
    render_views
    context "news feed" do
      it "is able to show all articles" do
        get :home
        expect(response.body).to include(@recent_article.title)
        expect(response.body).to include(@recent_article.title)
        expect(response.body).to include(@fox_article.title)
      end
      it "is able to show links to outlet source url" do
        get :home
        expect(response.body).to include(@outlet_cnn.siteurl)
        expect(response.body).to include(@outlet_fox.siteurl)
      end
    end
  end
end
