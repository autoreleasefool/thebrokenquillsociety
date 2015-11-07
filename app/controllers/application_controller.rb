class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Making session helper methods available to all controllers
  include SessionsHelper

  def recent_announcements
    @recent_announcements  ||= Announcement.all.order('created_at DESC').limit(10)
  end
  helper_method :recent_announcements

  # Lists most recent works and users
  def index
    @recent_works = Work.all.order('created_at DESC').limit(10)
  end

end
