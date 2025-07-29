class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post

  def create
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to @post, notice: 'Comment was successfully added.'
    else
      @comments = @post.comments.includes(:user).recent
      render 'posts/show', status: :unprocessable_entity
    end
  end

  def destroy
    @comment = @post.comments.find(params[:id])
    
    if @comment.user == current_user || current_user.admin?
      @comment.destroy
      redirect_to @post, notice: 'Comment was deleted.'
    else
      redirect_to @post, alert: 'Access denied.'
    end
  end

  private

  def set_post
    @post = Post.friendly.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end