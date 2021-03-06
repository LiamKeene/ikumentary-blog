class Admin::UsersController < Admin::BaseController

  def index
    @users = User.all
  end
  
  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to [:admin, @user]
    else
      render 'new'
    end
  end

  def update
    @user = User.find(params[:id])
    
    if @user.update_attributes(user_params)
      redirect_to [:admin, @user]
    else
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    redirect_to [:admin, :users]
  end

  private
    # Never trust params from the interwebs!  Only allow white-listed params
    def user_params
      params.require(:user).permit(:name, :display_name, :email, :url, :login, :password, :password_confirmation, :user_type)
    end
end
