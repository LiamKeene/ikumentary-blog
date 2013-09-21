class UsersController < ApplicationController

  def index
    @users = User.all
  end
  
  def show
    @user = User.find(params[:id])
  end

  def new
  end

  def create
    @user = User.new(user_params)

    @user.save
    redirect_to @user
  end

  private
    # Never trust params from the interwebs!  Only allow white-listed params
    def user_params
      params.require(:user).permit(:name, :display_name, :email, :url, :login, :password, :password_confirmation, :user_type)
    end
end