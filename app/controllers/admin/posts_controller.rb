# In app/controllers/admin/posts_controller.rb

class Admin::PostsController < Admin::BaseController
  before_action :set_post, only: [:show, :edit, :update, :destroy, :toggle_status]

  def index
    @posts = Post.order(created_at: :desc).page(params[:page]).per(10)
  end

  def show
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    # In admin, you might want to assign a default user or the current admin
    # @post.user = current_admin 

    if @post.save
      redirect_to admin_post_path(@post), notice: 'Post was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to admin_post_path(@post), notice: 'Post was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
    redirect_to admin_posts_path, notice: 'Post was successfully deleted.'
  end

  def toggle_status
    @post.update(status: @post.published? ? 'draft' : 'published')
    redirect_to admin_posts_path, notice: "Post status has been changed to #{@post.status}."
  end

  private

  def set_post
    # For admin, finding by primary key is often more reliable
    @post = Post.find(params[:id])
  end

  def post_params
    # Ensure this matches the form fields and your database column 'content'
    params.require(:post).permit(:title, :content, :status, :slug)
  end
end
