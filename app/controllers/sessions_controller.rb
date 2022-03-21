class SessionsController < ApplicationController
  def new
  end
  def create
   user = User.find_by(email: user_params[:email]).try(:authenticate, user_params[:password])
   if user
    #render plain: sprintf("welcome, %s!", user.email)
    redirect_to tasks_index_path
   else
    flash.now[:login_error] = "invalid username or password"
    render "new"
   end
  end
  def destroy
    # deletes user session
    session[:user_id] = nil
    redirect_to root_path, notice: 'Logged Out'
  end
  private
   def user_params
    params.require(:session).permit(:email, :password)
   end
 end
