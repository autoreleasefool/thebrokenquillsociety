class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Helper method to get the current logged in user or nil
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def recent_announcements
    @recent_announcements  ||= Announcement.all.order('created_at DESC').limit(10)
  end
  helper_method :recent_announcements

  # Checks for a current user or redirects to the login page
  def authorize
    url = '/login?noauth=1'
    redirect_to url unless current_user
  end

  # Lists most recent works and users
  def index
    @recent_works = Work.all.order('created_at DESC').limit(10)
  end

end
