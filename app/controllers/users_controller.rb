class UsersController < ApplicationController

  # Only allowed logged out users to access certain pages
  before_action :logged_out_user, only: [:new, :create]
  # Only allow logged in users to access certain pages
  before_action :logged_in_user, only: [:edit, :update, :faves, :add_favourite, :remove_favourite]
  # Only allow the original user or admin to perform certain actions
  before_action :check_user, only: [:edit, :update, :delete]

  # Cleaner HTTP requests
  require 'httparty'

  # User's profile
  def show
    @user = User.friendly.find(params[:id])
    @works = @user.works.order('created_at DESC').paginate(page: params[:page], per_page: 10)
    @title = @user.name

    unless @user.nanowrimo_name.blank?
      formatted_name = @user.nanowrimo_name.gsub(/\s/,'-')
      formatted_name.gsub!(/\./,'')
      response = HTTParty.get('http://nanowrimo.org/wordcount_api/wc/' + formatted_name)
      user_info = response.parsed_response
      @wordcount = user_info['wc']['user_wordcount']
    end
  end

  # User's favourited works
  def faves
    @favourites = current_user.favourites.order('created_at DESC').paginate(page: params[:page], per_page: 10)
    @title = 'Favourites'
  end

  # Adds a work to the current user's favourites
  def add_favourite
    unless params[:work].blank?
      work = Work.friendly.find(params[:work])
      if Favourite.find_by(user_id: current_user.id, work_id: work.id).blank?
        fave = Favourite.new
        fave.user = current_user
        fave.work = work
        fave.save
      end
      redirect_to work
    end
  end

  # Removes a work from the current user's favourites
  def remove_favourite
    unless params[:work].blank?
      work = Work.friendly.find(params[:work])
      fave = Favourite.find_by(user_id: current_user.id, work_id: work.id)
      fave.destroy unless fave.blank?
      redirect_to work
    end
  end

  # Form to create a new user account
  def new
    @user = User.new
    @title = 'Sign up'
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
    @user = User.friendly.find(params[:id])
    @title = 'Edit user ' + @user.name
  end

  # Updates a user's account information
  def update
    @user = User.friendly.find(params[:id])
    @user.slug = nil
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
    user = User.friendly.find(params[:id])
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
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :tag_list, :about, :nanowrimo_name, :admin_description)
  end

  # Parameters required/allowed to update a user entry
  def user_params_update
    params.require(:user).permit(:name, :tag_list, :about, :nanowrimo_name, :admin_description)
  end

  # Checks to ensure a valid user is logged in before actions are taken
  def check_user
    profile_user = User.friendly.find(params[:id])
    unless current_user == profile_user || current_user.is_admin?
      store_location
      flash[:error] = 'You are not authorized to perform this action.'
      redirect_to login_path
    end
  end

end
