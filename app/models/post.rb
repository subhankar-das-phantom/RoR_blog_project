class Post < ApplicationRecord
  extend FriendlyId
  include PgSearch::Model

  belongs_to :user
  has_many :comments, dependent: :destroy

  friendly_id :title, use: :slugged
  
  enum status: { draft: 0, published: 1 }

  # FIX: Use :content instead of :body
  validates :title, :content, presence: true
  validates :title, length: { minimum: 3, maximum: 100 }
  # FIX: Use :content instead of :body
  validates :content, length: { minimum: 10 }

  # FIX: Use :content in the search scope
  pg_search_scope :search_by_title_and_content,
                  against: [:title, :content],
                  using: {
                    tsearch: {
                      prefix: true,
                      any_word: true
                    }
                  }

  scope :published_posts, -> { where(status: :published) }
  scope :by_date_range, ->(start_date, end_date) { where(created_at: start_date..end_date) }
  scope :recent, -> { order(created_at: :desc) }

  def should_generate_new_friendly_id?
    title_changed? || super
  end

  # FIX: Use content instead of body
  def excerpt(limit = 150)
    content.truncate(limit)
  end
end
