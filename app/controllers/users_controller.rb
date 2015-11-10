class UsersController < ApplicationController

  # Only allowed logged out users to access certain pages
  before_action :logged_out_user, only: [:new, :create]
  # Only allow logged in users to access certain pages
  before_action :logged_in_user, only: [:edit, :update]
  # Only allow the original user or admin to perform certain actions
  before_action :check_user, only: [:edit, :update, :delete]

  # Cleaner HTTP requests
  require 'httparty'

  # User's profile
  def show
    @user = User.find(params[:id])
    @works = @user.works.order('created_at DESC').paginate(page: params[:page], per_page: 10)

    if @user.nanowrimo_name && @user.nanowrimo_name.length > 0
      response = HTTParty.get('http://nanowrimo.org/wordcount_api/wc/' + @user.nanowrimo_name)
      user_info = response.parsed_response
      @wordcount = user_info['wc']['user_wordcount']
    end
  end

  # Form to create a new user account
  def new
    @user = User.new
  end

  # Persists a new user to the database
  def create
    @user = User.new(user_params)
    @user.is_admin = false
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

  # Updates a user's account information
  def update
    @user = User.find(params[:id])
    if @user.update(user_params_update)
      flash[:success] = 'User\'s profile was updated.'
      redirect_to @user
    else
      @user_errors = {}
      @user.errors.each do |attr, msg|
        @user_errors[attr] = msg
      end
      render 'edit'
    end
  end

  # Deletes a single user entry
  def destroy
    user = User.find(params[:id])
    should_log_out_user = (user == current_user)
    name = user.name
    user.destroy
    flash[:success] = name + ' has been successfully deleted.'
    log_out if should_log_out_user
    redirect_back_or root_path
  end

  private

  # Parameters required/allowed to create a user entry
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :tag_list, :about, :nanowrimo_name)
  end

  # Parameters required/allowed to update a user entry
  def user_params_update
    params.require(:user).permit(:name, :tag_list, :about, :nanowrimo_name)
  end

  # Checks to ensure a valid user is logged in before actions are taken
  def check_user
    profile_user = User.find(params[:id])
    unless current_user == profile_user || current_user.is_admin?
      store_location
      flash[:error] = 'You are not authorized to perform this action.'
      redirect_to login_path
    end
  end

end
