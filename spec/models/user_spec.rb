require 'rails_helper'

RSpec.describe User, type: :model do
  fixtures :users, :outlets
  before do
    @user = users(:thomas)
    @outlet = outlets(:cnn)
  end

  #Devise User
  describe "#User" do
    context "validations" do
      it "is valid with email address" do
        expect(@user).to be_valid
      end
      it "is not valid without email address" do
        @user.email = nil
        expect(@user).to be_invalid
      end
    end
  end

  describe "Model Methods" do
    context ".following" do
      it "is able to follow an outlet" do
        expect(@user.following?(@outlet)).to be_falsey
        @user.follow(@outlet)
        expect(@user.following?(@outlet)).to be_truthy
        expect(@outlet.followers.include?(@user)).to be_truthy
        @user.unfollow(@outlet)
        expect(@user.following?(@outlet)).to be_falsey
        expect(@outlet.followers.include?(@user)).to be_falsey
      end
      it "is able to unfollow an outlet" do
        @user.unfollow(@outlet)
        expect(@user.following?(@outlet)).to be_falsey
        expect(@outlet.followers.include?(@user)).to be_falsey
      end
    end
  end
end
