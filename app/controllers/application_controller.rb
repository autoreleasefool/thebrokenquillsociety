class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Only allowed logged in users to perform some actions
  before_action :logged_in_user, only: [:admin, :update_admin_options]
  # Only allowed admins to perform some actions
  before_action :admin_user, only: [:admin, :update_admin_options]

  # Updates user last seen before each action
  before_action :set_last_seen,
    if: proc { logged_in? && (session[:last_seen].nil? || session[:last_seen] < 15.minutes.ago)}

  # Making session helper methods available to all controllers
  include SessionsHelper

  # Gets the 10 most recent announcements for the sidebar
  def recent_announcements
    @recent_announcements  ||= Announcement.all.order('created_at DESC').limit(10)
  end
  helper_method :recent_announcements

  # Indicates whether the admin has chosen to disable admin options
  def show_admin_options
    unless current_user.blank? || !current_user.is_admin?
      options = AdminOption.find_by user_id: current_user.id
      @show_admin_options = (options != nil) ? options.options_enabled? : false
    else
      @show_admin_options = false
    end
  end
  helper_method :show_admin_options

  # Lists most recent works and users
  def index
    @recent_works = Work.all.order('created_at DESC').limit(10)
  end

  # Displays the user's search results
  def search
    @work_search_results = nil
    @user_search_results = nil

    if params.has_key?(:q) && params[:q].length > 0
      searchKeys = params[:q].split
      @work_search_results = Work.tagged_with(searchKeys, :any => true, :order_by_matching_tag_count => true).paginate(page: params[:page], per_page: 10)
      @user_search_results = User.tagged_with(searchKeys, :any => true, :order_by_matching_tag_count => true).paginate(page: params[:page], per_page: 3)
    else
      @work_search_results = Work.all.order('created_at DESC').paginate(page: params[:page], per_page: 10)
      @user_search_results = User.all.order('created_at DESC').paginate(page: params[:page], per_page: 3)
    end
  end

  # Displays page of admin options
  def admin
    @options = AdminOption.find_by user_id: current_user.id
    @options = AdminOption.new unless !@options.blank?
  end

  # Sets the admin's options
  def update_admin_options
    @options = AdminOption.find_by user_id: current_user.id
    if @options.blank?
      @options = AdminOption.new(admin_option_params)
      @options.user = current_user
      success = @options.save
    else
      success = @options.update(admin_option_params)
    end

    if success
      if @options.options_enabled?
        flash[:success] = 'Admin options successfully enabled.'
      else
        flash[:success] = 'Admin options successfully disabled.'
      end
    else
      flash[:error] = 'Could not update options.'
    end
    render 'admin'
  end

  private

  # Updates the time the user was last known to perform some action
  def set_last_seen
    current_user.update_attribute(:last_seen, Time.now)
    session[:last_seen] = Time.now
  end

  # Parameters required/allowed to create an admin options entry
  def admin_option_params
    params.require(:admin_options).permit(:options_enabled)
  end

end
