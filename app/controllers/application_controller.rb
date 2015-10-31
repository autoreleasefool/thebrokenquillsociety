class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def authorize
    url = '/login?noauth=1'
    redirect_to url unless current_user
  end

  def index
    @recent_works = Work.all.order('created_at DESC')
    @recent_users = User.all.order('created_at DESC')
  end

end
