class Admin::SearchesController < ApplicationController
  before_action :authenticate_admin!
  
  def search
    @model = params[:model]
    @content = params[:content]
    @method = params[:method]
    @records = Post.search_for(@content, @method)
    @genres = Genre.all
  end
  
end
