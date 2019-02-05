require 'rails_helper'
require "spec_helper"

RSpec.describe UsersController, type: :controller do

  fixtures :users, :articles, :outlets

  before do
    @user = users(:thomas)
    @other_user = users(:malerie)
    @outlet = outlets(:cnn)
    @recent_article = articles(:recent)
    @old_article = articles(:old)
    @fox_article = articles(:foxarticle)
  end

  describe "#Users :index" do
    context "redirects" do
      it "should redirect following when not logged in" do
        get :following, params:{id: @user.id}
        expect(response).to redirect_to(new_user_session_url)
      end
      it "should redirect users path when not logged in" do
        get :show, params:{id: @user.id}
        expect(response).to redirect_to(root_url)
      end
      it "should redirect users path when not current user" do
        sign_in(@user)
        get :show, params: { id: @other_user.id }
        expect(response).to redirect_to(root_url)
      end
    end
  end

  describe "#Users Feed" do
    render_views
    context "following" do
      it "should display 'no news sources' message when not following outlets" do
        sign_in(@user)
        get :show, params: {id: @user.id}
        expect(response.body).to include("You are not Currently Following any News Sources")
      end

      it "should display correct outlets when following" do
        @user.follow(@outlet)
        sign_in(@user)
        get :show, params: { id: @user.id }
        expect(response.body).to include(@outlet.siteurl)
      end

      it "should display correct articles when following outlet" do
        @user.follow(@outlet)
        sign_in(@user)
        get :show, params: { id: @user.id }
        expect(response.body).to include(@recent_article.title)
        expect(response.body).to include(@recent_article.title)
        expect(response.body).to include(@fox_article.title)
      end
    end
  end

end
