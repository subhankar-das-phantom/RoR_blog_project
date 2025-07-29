class PublishPostJob < ApplicationJob
  queue_as :default

  def perform(post)
    # Simulate sending notification email
    Rails.logger.info "Sending publication notification for post: #{post.title}"
    
    # Create notification record
    Notification.create!(
      user: post.user,
      post: post,
      message: "Your post '#{post.title}' has been published!",
      notification_type: 'post_published',
      read: false
    )
    
    # Here you would typically send an actual email
    # UserMailer.post_published(post).deliver_now
    
    Rails.logger.info "Post publication notification completed for: #{post.title}"
  end
end