class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :active_relationships, class_name:  "Relationship",
                                  foreign_key: "follower_id",
                                  dependent:   :destroy

  has_many :following, through: :active_relationships, source: :followed
  # Follows a user.
  def follow(outlet)
    following << outlet
  end

  # Unfollows a user.
  def unfollow(outlet)
    following.delete(outlet)
  end

  # Returns true if the current user is following the other user.
  def following?(outlet)
    following.include?(outlet)
  end
end
