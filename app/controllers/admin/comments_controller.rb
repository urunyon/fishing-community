class Admin::CommentsController < ApplicationController
  before_action :authenticate_admin!

  def destroy
    @post = Post.find(params[:id])
    #Comment.find(params[:comment_id]).destroy
    comment = @post.comments.find(params[:id])
    redirect_to admin_post_path(params[:post_id])
  end

    private

  def comment_params
    params.require(:comment).permit(:comment, :post_id)
  end

  def set_comment
    　　@comment = Comment.find(params[:id])
  end
end
