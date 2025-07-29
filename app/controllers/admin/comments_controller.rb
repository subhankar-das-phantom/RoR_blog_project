# In app/controllers/admin/comments_controller.rb

class Admin::CommentsController < Admin::BaseController
  before_action :set_comment, only: [:destroy]

  def index
    @comments = Comment.includes(:user, :post).order(created_at: :desc)
  end

  def destroy
    @comment.destroy
    redirect_to admin_comments_path, notice: 'Comment was successfully deleted.'
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end
end
