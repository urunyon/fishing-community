class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @users = User.page(params[:page]).per(10)
  end

  def show
    @user = User.find(params[:id])
    if params[:latest]
      @posts = @user.posts.latest
    elsif params[:old]
      @posts = @user.posts.old
    else
      @posts = @user.posts
    end
    @user_posts = @posts.page(params[:page]).per(8)
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
    @posts = Post.page(params[:page]).per(8)
    @genres = Genre.all
  end

  private

   def user_params
     params.require(:user).permit(:name, :nickname, :email)
   end
   
end
