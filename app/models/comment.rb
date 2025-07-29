class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :body, presence: true, length: { minimum: 5, maximum: 1000 }

  scope :recent, -> { order(created_at: :desc) }
end