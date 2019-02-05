require 'rails_helper'

RSpec.describe Outlet, type: :model do
  fixtures :outlets

  before do
    @outlet = outlets(:cnn)
  end

  describe "#Outlet" do
    context "validations" do
      it "is valid with outlet name" do
        expect(@outlet).to be_valid
      end
      it "is not valid without outlet name" do
        @outlet.outlet_name = nil
        expect(@outlet).to be_invalid
      end
      it "is not valid with duplicate outlet names" do
        dup_outlet = @outlet.dup
        expect(dup_outlet).to be_invalid
      end
    end
  end

  describe "Model Methods" do
    context "feed" do
      it "should not contain articles from another source" do
        article_holder = @outlet.fetch_articles(limit_num: 3)
        article_holder.each do |article|
          expect(article.outlet_name).to include("CNN")
        end
      end
      it "should return max amount of articles regardless of limit parameter" do
        article_holder = @outlet.fetch_articles(published_before: "2019-01-16 18:28:01 -0500", limit_num: 100)
        expect(article_holder.count).to eq(1)
        article_holder = @outlet.fetch_articles(limit_num:100)
        expect(article_holder.count).to eq(2)
      end
      it "is able to return both articles in default feed" do
        article_holder = @outlet.fetch_articles(limit_num: 2)
        expect(article_holder.count).to eq(2)
      end
      it "is able to return the oldest article using fetch_articles" do
        article_holder = @outlet.fetch_articles(published_before: "2019-01-16 18:28:01 -0500", limit_num: 1)
        expect(article_holder.count).to eq(1)
        expect(article_holder[0].published_at.to_s).to include("2018-01-16 18:28:01 -0500")
      end
    end
  end
end
