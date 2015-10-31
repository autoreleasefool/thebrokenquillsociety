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
      flash[:error] = @user.errors.full_messages
      render 'new'
    end
  end

  # User's profile
  def show
    @user = User.find(params[:id])
  end

  # User's submitted works
  def works
    @user = User.find(params[:id])
  end

  private

  # Parameters required/allowed to create a user entry
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :tag_list, :about)
  end

end
