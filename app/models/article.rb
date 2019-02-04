class Article < ApplicationRecord
  belongs_to :outlet

  default_scope -> {order(published_at: :desc)}

  validates :url, presence: true, uniqueness: true

  scope :update_feed, ->(published_at, limit) {
    includes(:outlet).where('articles.published_at < ?', published_at.to_datetime).limit(limit)
  }

  scope :default_feed, ->(limit) {includes(:outlet).limit(limit)}


end
