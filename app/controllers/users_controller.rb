class UsersController < ApplicationController
  
	def show
		@user = User.find(params[:id])

	end

	def new
		@user = User.new()

	end

	def create
		user = params[:user]
		new_user = params.require(:user).permit(:name, :email, :password, :password_confirmation)
		@user=User.new(new_user)
		if @user.save
			flash[:sucess] = "Start shortening links!"
			sign_in @user
			redirect_to @user
		else
			render 'new'
		end

	end

	def update
	    @user = User.find(params[:id])
	    @user.update_attributes(params[:user])
	    render :show

	end

	
end