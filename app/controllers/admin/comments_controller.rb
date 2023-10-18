class Admin::CommentsController < ApplicationController
  before_action :authenticate_admin!

  def destroy
    #@post = Post.find(params[:id])
    #指定したコメントを削除する
    Comment.find(params[:id]).destroy
    #comment = @post.comments.find(params[:id])
    #comment.destroy
    #redirect_to admin_post_path(params[:post_id])
    #投稿詳細に戻る
    redirect_back fallback_location: root_path
  end



    private

  def comment_params
    params.require(:comment).permit(:comment, :post_id)
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end
end
