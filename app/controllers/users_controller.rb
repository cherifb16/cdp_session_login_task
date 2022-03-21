class UsersController < ApplicationController
   
    helper_method :current_user
    def new
        if logged_in?
			redirect_to tasks_path, notice: "Please log out to create account"
		else
			@user = User.new
		end
    end

    def create
        @user = params[:user] ? User.new(params[:user]) : User.new_guest
        if @user.save
          current_user.move_to(@user) if current_user && current_user.guest?
          session[:user_id] = @user.id
          redirect_to root_url
        else
          render "new"
        end
      end

      def show
        @user = User.find(params[:id])
        
      end

    def edit
        @user = User.find(params[:id])
    end

    def update
        @user = User.find(params[:id])
        if @user.update(user_params)
            redirect_to user_path(@user.id), notice: "Account has successfully edited"
        else
            flash.now[:danger] = "Account is failed to edit"
            render :edit
        end
    end
    def destroy
        User.find(params[:id]).destroy
        flash[:success] = "User deleted."
        redirect_to sessions_new_path
      end
    private
    def user_params
        params.require(:user).permit(:email, :password, :password_confirmation)
    end

end
