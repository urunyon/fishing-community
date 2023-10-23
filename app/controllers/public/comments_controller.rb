class Public::CommentsController < ApplicationController
  before_action :authenticate_user!
  
  #非同期通信の為アクション後のリンク先は不要
  def create
    @post = Post.find(params[:post_id])
    @comment = current_user.comments.new(comment_params)
    @comment.post_id = @post.id
    @comment.save
  end
  
  def destroy
    @comment = Comment.find(params[:id]).destroy
    @comment.destroy
    @post = Post.find(params[:post_id])
  end
  
    private

  def comment_params
    params.require(:comment).permit(:comment)
  end
end
