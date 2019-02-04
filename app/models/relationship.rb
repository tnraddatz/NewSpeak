class Relationship < ApplicationRecord
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "Outlet"

  # this can work. but its not very railsy. You could use a polymorphic here. But if you are only going to have this 1-1
  # relationship, then you can just do
  #
  # UserFollowingOutlet table
  # id | user_id | outlet_id
  #
  # and a user would have_many: :outlets, through: :user_following_outlets

  # duplicate?
  validates :follower_id, presence: true
  validates :followed_id, presence: true
end
