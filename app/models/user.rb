class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :active_relationships, class_name:  "Relationship",
                                  foreign_key: "follower_id",
                                  dependent:   :destroy

  has_many :following, through: :active_relationships, source: :followed

   #fetch articles from following new outlets
   def fetch_articles(published_before: nil, limit_num: 6)
     if published_before
       articles = Article.includes(:outlet).where(outlet_name: following.pluck(:outlet_name))
                          .where('articles.published_at < ?', published_before.to_datetime)
     else
       articles = Article.includes(:outlet).where(outlet_name: following.pluck(:outlet_name))
     end
     articles.limit(limit_num)
   end

   #Fetch outlets a user is following
   def fetch_outlets(outlet: nil, limit_num: 6)
     if outlet
       articles = following.where("outlet_name > ?", outlet)
     else
       articles = following
     end
     articles.limit(limit_num)
   end

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
