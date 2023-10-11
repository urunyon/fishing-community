class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @posts = Post.page(params[:page])
  end
  
  def show
    @post = Post.find(params[:id])
  end
  
  def destroy
    @post = Post.find(params[:id])
  end
  
  private
  
  def post_params
    params.require(:post).permit(:title, :body, :genre_id, :post_image)
  end
end
