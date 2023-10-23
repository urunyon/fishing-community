class Public::FavoritesController < ApplicationController
  before_action :authenticate_user!

 #非同期通信の為「いいね」のリンク先は必要ない

  def create
    @post = Post.find(params[:post_id])
    favorite = @post.favorites.new(user_id: current_user.id)
    favorite.save
  end

  def destroy
    @post = Post.find(params[:post_id])
    favorite = @post.favorites.find_by(user_id: current_user.id)
    favorite.destroy
  end


end