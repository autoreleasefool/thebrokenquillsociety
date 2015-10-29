class UsersController < ApplicationController

  # Form to create a new user account
  def new
  end

  # Persists a new user to the database
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to '/', notice: 'Account created successfully'
    else
      flash[:error] = 'An error occured!'
      render 'new'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :about)
  end

end
