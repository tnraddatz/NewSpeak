require 'rails_helper'
require 'spec_helper'
RSpec.describe RelationshipsController, type: :controller do
  fixtures :relationships, :users, :outlets

  before do
    @user = users(:malerie)
    @outlet = outlets(:cnn)
  end
  describe "#Relationships :post" do
    context "invalid :create" do
      it "should require logged-in user" do
        expect{post :create}.to_not change{Relationship.count}
      end
    end
    context "valid :create" do
      it "should follow an outlet the standard way" do
        sign_in(@user)
        @user.unfollow(@outlet)
        expect{post :create, params: {followed_id: @outlet.id}}.to change{Relationship.count}.by(1)
      end
      it "should follow an outlet with ajax" do
        sign_in(@user)
        @user.unfollow(@outlet)
        expect{post :create, xhr: true, params: {followed_id: @outlet.id}}.to change{Relationship.count}.by(1)
      end
    end
  end

  describe "#Relationship :destroy" do
    context "invalid :delete" do
      it "should require logged-in user" do
        expect{delete :destroy, params: {id:relationships(:one).id}}.to_not change{Relationship.count}
      end
    end
    context "valid :delete" do
      it "should unfollow an outlet standard way" do
        sign_in(@user)
        expect{delete :destroy, params: {id:relationships(:one).id}}.to change{Relationship.count}.by(-1)
      end
      it "should unfollow an outlet with ajax" do
        sign_in(@user)
        expect{delete :destroy, xhr: true, params: {id:relationships(:one).id}}.to change{Relationship.count}.by(-1)
      end
    end
  end
end
