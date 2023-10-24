class Admin::CommentsController < ApplicationController
  before_action :authenticate_admin!

  #管理者側はコメント削除時は確認を入れるために同期通信してる
  def destroy
    Comment.find(params[:id]).destroy
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
