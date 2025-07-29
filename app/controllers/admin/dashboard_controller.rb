class Admin::DashboardController < Admin::BaseController
  def index
    @stats = {
      total_users: User.count,
      total_posts: Post.count,
      published_posts: Post.published.count,
      draft_posts: Post.draft.count,
      total_comments: Comment.count
    }
    
    @recent_posts = Post.includes(:user, :comments).recent.limit(10)
    @recent_comments = Comment.includes(:user, :post).recent.limit(10)
    @recent_users = User.order(created_at: :desc).limit(10)
  end
end