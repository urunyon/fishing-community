class Public::HomesController < ApplicationController

  def top
    @genres = Genre.all
    @posts = Post.order("created_at DESC").limit(4)
  end
  
  def about
  end
  
end
