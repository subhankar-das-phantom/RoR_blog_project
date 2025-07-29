# In app/controllers/users_controller.rb
class UsersController < ApplicationController
  before_action :authenticate_user!
  
  # This before_action now ONLY runs for the show action, not the dashboard.
  before_action :set_user, only: [:show]

  # This action is for viewing a user's public profile page (e.g., /users/1).
  # It remains unchanged.
  def show
    @posts = @user.posts.published_posts.includes(:comments).recent.page(params[:page]).per(10)
  end

  # This is the private dashboard for the logged-in user.
  def dashboard
    # This is the FIX. We set @user directly from current_user.
    # This avoids the need for params[:id] and prevents the error.
    @user = current_user

    # All of your excellent dashboard logic will now work perfectly.
    @draft_posts = @user.posts.draft.order(updated_at: :desc).limit(5)
    @published_posts = @user.posts.published.order(updated_at: :desc).limit(5)
    @recent_comments = Comment.joins(:post)
                              .where(posts: { user: @user })
                              .includes(:user, :post)
                              .order(created_at: :desc)
                              .limit(10)
    @stats = {
      total_posts: @user.posts.count,
      published_posts: @user.posts.published.count,
      draft_posts: @user.posts.draft.count,
      total_comments: Comment.joins(:post).where(posts: { user: @user }).count
    }
  end

  private

  # This method is now only used by the :show action.
  def set_user
    @user = User.find(params[:id])
  end
end
