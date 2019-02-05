class Outlet < ApplicationRecord
	has_many :articles
	validates :outlet_name, presence: true, uniqueness: true
	default_scope -> {order(outlet_name: :asc)}
	has_many :passive_relationships, class_name:  "Relationship",
                                   foreign_key: "followed_id",
                                   dependent:   :destroy
	has_many :followers, through: :passive_relationships, source: :follower

	def self.preview_outlet_images(limit_num)
	  Outlet.limit(limit_num).pluck(:imageurl)
	end

	def fetch_articles(published_before: nil, limit_num: 6)
		if published_before
			articles = Outlet.includes(:articles).find_by_outlet_name(self.outlet_name).articles
			                 .where('articles.published_at < ?', published_before.to_datetime).references(:articles)
		else
			articles = Outlet.includes(:articles).find_by_outlet_name(self.outlet_name).articles
		end
		articles.limit(limit_num)
	end

	def self.fetch_outlets(outlet: nil, limit_num: 6)
		if outlet
			outlets = Outlet.where("outlet_name > ?", outlet).limit(limit_num)
		else
			outlets = Outlet.limit(limit_num)
		end
		outlets
	end

end
