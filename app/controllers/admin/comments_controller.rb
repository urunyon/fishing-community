class Admin::CommentsController < ApplicationController
  before_action :authenticate_admin!

  def destroy
    #指定したコメントを削除する
    Comment.find(params[:id]).destroy
    #投稿詳細に戻る
    redirect_back fallback_location: root_path, notice: "コメントを削除しました。"
  end



    private

  def comment_params
    params.require(:comment).permit(:comment, :post_id)
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end
end
