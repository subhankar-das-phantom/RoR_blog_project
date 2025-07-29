# In app/controllers/posts_controller.rb
class PostsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show, :search]
  
  # This is the first fix: Add :publish to the before_action filters
  before_action :set_post, only: [:show, :edit, :update, :destroy, :publish]
  before_action :authorize_owner, only: [:edit, :update, :destroy, :publish]

  def index
    @posts = Post.published_posts.includes(:user).recent.page(params[:page]).per(10)
  end

  def show
    unless @post.published? || (user_signed_in? && @post.user == current_user)
      redirect_to root_path, alert: 'Post not found.'
    else
      @comment = Comment.new
      @comments = @post.comments.includes(:user).recent
    end
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to @post, notice: 'Post was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: 'Post was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path, notice: 'Post was successfully deleted.'
  end

  def search
    @query = params[:q]
    @posts = Post.published_posts.search_by_title_and_content(@query).page(params[:page]).per(10)
    render :index
  end

  # This is the second fix: Add the new action that handles the "Publish" button.
  def publish
    if @post.update(status: 'published')
      redirect_to dashboard_user_path, notice: "Post '#{@post.title}' was successfully published."
    else
      redirect_to dashboard_user_path, alert: 'Could not publish the post.'
    end
  end

  private

  def set_post
    @post = Post.friendly.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content, :status)
  end
  
  def authorize_owner
    redirect_to root_path, alert: "You are not authorized to perform this action." unless @post.user == current_user
  end
end
