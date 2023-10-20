class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      flash[:notice] = "編集内容の保存に成功しました"
      redirect_to user_path
    else
      render :edit
    end
  end

  def confirm
    @user = current_user
  end

#ユーザーの退会用
  def withdrawal
    @user = User.find(current_user.id)
    @user.update(is_deleted: true)
    reset_session
    flash[:notice] = "ご利用ありがとうございました"
    redirect_to root_path
  end

#いいね一覧表示用
  def favorites
    @user = User.find(params[:id])
    favorites = Favorite.where(user_id: @user.id).pluck(:post_id)
    @favorite_posts = Post.find(favorites)
    #@post = Post.find(params[:id])
    @posts = Post.page(params[:page]).per(8)
  end

  private

   def user_params
     params.require(:user).permit(:name, :nickname, :email, :is_deleted)
   end
   
end
