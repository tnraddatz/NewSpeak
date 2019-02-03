class Article < ApplicationRecord
  belongs_to :outlet
  default_scope -> {order(published_at: :desc)}
  validates :url, presence: true, uniqueness: true

  #Class Methods
  def self.update_feed(published_at, limit_num)
    Article.includes(:outlet).where('articles.published_at < ?', published_at.to_datetime).limit(limit_num)
  end

  def self.default_feed(limit_num)
    Article.includes(:outlet).limit(limit_num)
  end

end
