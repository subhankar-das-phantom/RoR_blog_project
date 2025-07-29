class Api::V1::PostsController < Api::V1::BaseController
  skip_before_action :authenticate_api_user!, only: [:index, :show]

  def index
    @posts = Post.published_posts
                 .includes(:user, :comments)
                 .recent
                 .page(params[:page])
                 .per(params[:per_page] || 20)

    render json: {
      posts: @posts.map do |post|
        {
          id: post.id,
          title: post.title,
          body: post.body,
          slug: post.slug,
          status: post.status,
          created_at: post.created_at,
          updated_at: post.updated_at,
          author: {
            id: post.user.id,
            name: post.user.full_name
          },
          comments_count: post.comments.count
        }
      end,
      pagination: {
        current_page: @posts.current_page,
        total_pages: @posts.total_pages,
        total_count: @posts.total_count
      }
    }
  end

  def show
    @post = Post.published_posts.friendly.find(params[:id])
    
    render json: {
      id: @post.id,
      title: @post.title,
      body: @post.body,
      slug: @post.slug,
      status: @post.status,
      created_at: @post.created_at,
      updated_at: @post.updated_at,
      author: {
        id: @post.user.id,
        name: @post.user.full_name
      },
      comments: @post.comments.includes(:user).recent.map do |comment|
        {
          id: comment.id,
          body: comment.body,
          created_at: comment.created_at,
          author: {
            id: comment.user.id,
            name: comment.user.full_name
          }
        }
      end
    }
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Post not found' }, status: :not_found
  end
end