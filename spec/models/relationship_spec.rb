require 'rails_helper'

RSpec.describe Relationship, type: :model do
  fixtures :users, :outlets
  before do
    @relationship = Relationship.new(follower_id: users(:thomas).id,
                                     followed_id: outlets(:cnn).id)
  end
  
  describe "#Relationships" do
    context "validation" do
      it "is valid" do
        expect(@relationship).to be_valid
      end
      it "is not valid without follower_id" do
        @relationship.follower_id = nil
        expect(@relationship).to be_invalid
      end
      it "is not valid without followed_id" do
        @relationship.followed_id = nil
        expect(@relationship).to be_invalid
      end
    end
  end
end
