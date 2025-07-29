class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :post, optional: true

  validates :message, :notification_type, presence: true

  scope :unread, -> { where(read: false) }
  scope :recent, -> { order(created_at: :desc) }

  def mark_as_read!
    update!(read: true)
  end
end