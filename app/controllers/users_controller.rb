class UsersController < ApplicationController

  # Only allow logged in users to access certain pages
  before_action :logged_in_user, only: [:edit, :update]
  # Only allow the original user or admin to perform certain actions
  before_action :correct_user, only: [:edit, :update]
  # Only allow the admin to perform certain actions
  before_action :admin_user, only: :destroy

  # User's profile
  def show
    @user = User.find(params[:id])
  end

  # User's submitted works
  def works
    @user = User.find(params[:id])
    @user_works = Work.find_by(user_id: @user.id)
  end

  # Form to create a new user account
  def new
    @user = User.new
  end

  # Persists a new user to the database
  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      redirect_back_or root_path
    else
      @user_errors = {}
      @user.errors.each do |attr, msg|
        @user_errors[attr] = msg
      end
      render 'new'
    end
  end

  # Form to update a user's account
  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      # TODO: show success
      redirect_to @user
    else
      @user_errors = {}
      @user.errors.each do |attr, msg|
        @user_errors[attr] = msg
      end
      render 'edit'
  end

  # Deletes a single user entry
  def destroy
    User.find(params[:id]).destroy
    redirect_back_or root_path
  end

  private

  # Parameters required/allowed to create a user entry
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :tag_list, :about)
  end

end
