class Outlet < ApplicationRecord
	has_many :articles
	validates :outlet_name, presence: true, uniqueness: true
	default_scope -> {order(outlet_name: :asc)}
	has_many :passive_relationships, class_name:  "Relationship",
                                   foreign_key: "followed_id",
                                   dependent:   :destroy
	has_many :followers, through: :passive_relationships, source: :follower

	#class methods
	def self.preview_outlet_images(limit_num)
		Outlet.limit(limit_num).pluck(:imageurl)
	end

	#Instance Methods
	#Show articles from a single outlet
	def update_feed(published_at, limit_num)
    Outlet.includes(:articles).find_by_outlet_name(self.outlet_name).articles.where('articles.published_at < ?', published_at.to_datetime).references(:articles).limit(limit_num)
	end

  #Show articles from a single outlet
  def default_feed(limit_num)
    Outlet.includes(:articles).find_by_outlet_name(self.outlet_name).articles.limit(limit_num)
  end
end
