class SignupsController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
  def new
    @user = User.new
   end
   
   def create
    @user = User.create(user_params)
    if @user.save
     redirect_to :sessions_new
    else
     render "new"
    end
   end
   def edit
    @user = User.find(params[:id])
  end
  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end
   private
    def user_params
     params.require(:user).permit(:email, :password, :password_confirmation)
    end
end
