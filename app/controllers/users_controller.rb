class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
     @cards = Card.all
      if Stack.where(name: "reserve", user_id: current_user.id) == []
         Stack.create(name: "reserve", times_viewed_today: 0, user_id: current_user.id)
      end


      if Stack.where(name: "practice", user_id: current_user.id) == []
        Stack.create(name: "practice", times_viewed_today: 0, user_id: current_user.id)
      end

      if Stack.where(name: "learned", user_id: current_user.id) == []
        Stack.create(name: "learned", times_viewed_today: 0, user_id: current_user.id)
      end

     if  current_user.view == nil
        View.create(user_id: current_user.id, value: 0)
     end
  end



  def new
    @user = User.new()
  end

  def create
    new_user = params.require(:user).permit(:name, :email, :password, :password_confirmation)
    @user=User.new(new_user)
    if @user.save
      flash[:success] = "Welcome to Always in My Memory App!"
      sign_in @user
      redirect_to @user
    else
      render'new'
    end
  end

  def update
    @user = User.find(params[:id])
    @user.update_attributes(params[:user])
    render :show
  end

end