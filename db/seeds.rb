# Create admin user
admin = User.create!(
  first_name: "Admin",
  last_name: "User",
  email: "admin@example.com",
  password: "password123",
  password_confirmation: "password123",
  admin: true
)

# Create test users
users = []
5.times do |i|
  users << User.create!(
    first_name: "User#{i + 1}",
    last_name: "Test",
    email: "user#{i + 1}@example.com",
    password: "password123",
    password_confirmation: "password123"
  )
end

puts "Created #{users.count + 1} users (including admin)"

# Create test posts
posts = []
users.each_with_index do |user, user_index|
  # Create 3-5 posts per user
  rand(3..5).times do |post_index|
    status = rand > 0.3 ? :published : :draft
    
    post = user.posts.create!(
      title: "Sample Post #{user_index + 1}-#{post_index + 1}: #{['How to', 'Guide to', 'Understanding', 'Introduction to', 'Advanced'].sample} #{['Rails', 'Ruby', 'Web Development', 'Programming', 'Software Design'].sample}",
      body: "This is a sample blog post created for testing purposes. #{['Lorem ipsum dolor sit amet, consectetur adipiscing elit.', 'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.', 'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris.'].sample}\n\n#{['Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.', 'Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', 'Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium.'].sample}\n\n#{['Totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.', 'Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt.', 'Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit.'].sample}",
      status: status
    )
    
    posts << post if post.persisted?
  end
end

puts "Created #{posts.count} posts"

# Create test comments
comment_count = 0
posts.select(&:published?).each do |post|
  # Add 0-8 comments per published post
  rand(0..8).times do
    commenting_user = users.sample
    next if commenting_user == post.user && rand > 0.3 # Less likely to comment on own posts
    
    comment = post.comments.create!(
      user: commenting_user,
      body: [
        "Great post! Thanks for sharing your insights.",
        "I found this really helpful, especially the part about #{['implementation', 'best practices', 'common pitfalls', 'optimization', 'testing'].sample}.",
        "Interesting perspective. I've had similar experiences with this.",
        "Could you elaborate more on #{['the technical details', 'the implementation approach', 'the benefits', 'the challenges', 'the use cases'].sample}?",
        "This reminds me of a project I worked on last year.",
        "Well written and easy to follow. Keep up the good work!",
        "I disagree with some points, but overall a solid article.",
        "Have you considered #{['alternative approaches', 'performance implications', 'scalability issues', 'security concerns', 'maintenance aspects'].sample}?",
        "Thanks for the detailed explanation. This cleared up my confusion.",
        "Looking forward to more posts like this!"
      ].sample
    )
    
    comment_count += 1 if comment.persisted?
  end
end

puts "Created #{comment_count} comments"

# Create some notifications
users.each do |user|
  user.posts.published.each do |post|
    Notification.create!(
      user: user,
      post: post,
      message: "Your post '#{post.title}' has been published!",
      notification_type: 'post_published',
      read: rand > 0.5
    )
  end
end

puts "Created sample notifications"

puts "\n✅ Database seeded successfully!"
puts "\nTest credentials:"
puts "👤 Regular user: user1@example.com / password123"
puts "🔑 Admin: admin@example.com / password123"
puts "🛠️  Admin panel: username: admin, password: admin123"