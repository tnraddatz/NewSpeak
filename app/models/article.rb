class Article < ApplicationRecord
  belongs_to :outlet
  default_scope -> {order(published_at: :desc)}
  validates :url, presence: true, uniqueness: true

  def self.fetch_articles(published_before: nil, limit_num: 9)
    if published_before
      articles = includes(:outlet).where('articles.published_at < ?', published_before.to_datetime)
    else
      articles = includes(:outlet)
    end
    articles.limit(limit_num)
  end

end
