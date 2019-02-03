require 'rails_helper'

RSpec.describe Article, type: :model do
  fixtures :articles, :outlets
  before do
    @recent_article = articles(:recent)
    @old_article = articles(:old)
    @fox_article = articles(:foxarticle)
  end

  describe "#Article" do
    context "validations" do
      it "is valid with url" do
        expect(@recent_article).to be_valid
      end
      it "is not valid without url" do
        @recent_article.url = nil
        expect(@recent_article).to be_invalid
      end
      it "is not allow to have duplicates" do
        duplicate_outlet = @recent_article.dup
        expect(duplicate_outlet).to be_invalid
      end
    end
  end

  describe "Model Methods" do
    context "feed" do
      it "is able to return both articles in default feed" do
        article_holder = Article.default_feed(2)
        expect(article_holder.count).to eq(2)
      end
      it "is able to return the oldest article using update feed" do
        article_holder = Article.update_feed("2019-01-16 18:28:01 -0500", 2)
        expect(article_holder.count).to eq(2)
        expect(article_holder[0].published_at.to_s).to include("2018-01-16 18:28:01 -0500")
        expect(article_holder[1].published_at.to_s).to include("2017-01-16 18:28:01 -0500")
      end
    end
  end
end
