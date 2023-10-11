class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @users = User.page(params[:page]).per(10)
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def edit
    @user = user.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "変更を保存しました。"
      redirect_to admin_user_path(@user)
    else
      render :edit
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :nickname, :email, :is_deleted)
  end
end
