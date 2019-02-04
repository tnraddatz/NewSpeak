class Outlet < ApplicationRecord
  has_many :articles
  validates :outlet_name, presence: true, uniqueness: true
  default_scope -> {order(outlet_name: :asc)}

  has_many :passive_relationships, class_name: "Relationship",
           foreign_key: "followed_id",
           dependent: :destroy

  has_many :followers, through: :passive_relationships, source: :follower

  #class methods
  def self.preview_outlet_images(limit_num)
    Outlet.limit(limit_num).pluck(:imageurl)
  end

  #  ^^ is this method needed or even used? You are chaining a limit and a pluck.
  # This really makes things complicated. You are making a method to pull out image urls.
  # It looks as you are falling into the trap of creating a view based API.
  # Meaning that you know how you want somethign to look, and not building something for its functionality.
  # This happens a lot. You start creating a controller, and you end up needing somethign that will make it easier to work with.
  # But... at the cost of data size, and db hits.


  #Instance Methods
  #Show articles from a single outlet
  # ## Update feed seems wrong. maye rename it to refresh_feed.
  # ## Remember that teh CRUD words should be reserved for their respective actions.
  def update_feed(published_at, limit_num)
    Outlet.includes(:articles).find_by_outlet_name(self.outlet_name).articles.where('articles.published_at < ?', published_at.to_datetime).references(:articles).limit(limit_num)
  end

  #Show articles from a single outlet
  def default_feed(limit_num)
    Outlet.includes(:articles).find_by_outlet_name(self.outlet_name).articles.limit(limit_num)
    # Inside the model, self is Outlet. so, stating Outlet over and over again is an antipattern.
    # Also I think you might want to re-read the section in the rails guides on how relationships work.
    # Im confused on how this... default_feed works
    # Outlet.articles <- this should return basically what youre asking for above. Thats why you have a `has_many :articles`
  end
end
