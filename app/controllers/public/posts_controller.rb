class Public::PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :show, :edit, :update, :destroy]
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def new
    @post = Post.new
    @genres = Genre.all
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      flash[:notice] = "投稿に成功しました。"
      redirect_to posts_path(@post)
    else
      @genres = Genre.all
      render :new
    end
  end

  def index
    @genres = Genre.all
    if params[:latest]
      if params[:genre_id]
        @genre = Genre.find(params[:genre_id])
        @posts = @genre.posts.page(params[:page]).per(8).latest
        #特定ジャンル別の投稿を全て数えるため
        @genre_posts_all = @genre.posts
      else
        @posts = Post.page(params[:page]).per(8).latest
        #すべての投稿を数えるため
        @posts_all = Post.all
      end
    elsif params[:old]
      if params[:genre_id]
        @genre = Genre.find(params[:genre_id])
        @posts = @genre.posts.page(params[:page]).per(8).old
        #特定ジャンル別の投稿を全て数えるため
        @genre_posts_all = @genre.posts
      else
        @posts = Post.page(params[:page]).per(8).old
        #すべての投稿を数えるため
        @posts_all = Post.all
      end
    else
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
  end

  def show
    @post = Post.find(params[:id])
    @genres = Genre.all
    @comment = Comment.new
  end

  def edit
    @post = Post.find(params[:id])
    @genres = Genre.all
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:notice] = "投稿情報を変更しました"
      redirect_to post_path(@post)
    else
      @genres = Genre.all
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path, notice: "投稿を削除しました。"
  end

  def ensure_correct_user
    @post = Post.find_by(id: params[:id])
    return unless @post.user_id != current_user.id

    redirect_to posts_path
  end



  private

  def post_params
    params.require(:post).permit(:title, :body, :genre_id, :post_image)
  end

end