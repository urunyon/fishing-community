class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @genres = Genre.all
    if params[:genre_id]
      @genre = Genre.find(params[:genre_id])
      @posts = @genre.posts.page(params[:page]).per(8).order(created_at: :desc)
      #特定ジャンル別の投稿を全て数えるため
      @genre_posts_all = @genre.posts
    else
      @posts = Post.page(params[:page]).per(8).order(created_at: :desc)
      #すべての投稿を数えるため
      @posts_all = Post.all
    end
  end

  def show
    @post = Post.find(params[:id])
    @genres = Genre.all
    @comment = Comment.all
  end
  
  def edit
    @post = Post.find(params[:id])
    @genres = Genre.all
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:notice] = "投稿情報を変更しました"
      redirect_to admin_post_path(@post)
    else
      @genres = Genre.all
      render :edit
    end
  end
  
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to admin_posts_path
  end



  private

  def post_params
    params.require(:post).permit(:title, :body, :genre_id, :post_image)
  end
end
