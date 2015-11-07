module SessionsHelper

  ##############################
  #     Managing sessions      #
  ##############################

  # Creates a new session for the provided user
  def log_in(user)
    session[:user_id] = user.id
  end

  # Deletes a user's session
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

  # Gets the currently logged in user, or nil
  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end

  # Checks if the provided user matches the current user
  def current_user?(user)
    user == current_user
  end

  # Checks if any user is logged in
  def logged_in?
    !current_user.nil?
  end

  ##############################
  #      Authentication        #
  ##############################

  # Checks if a user is currently logged in
  def logged_in_user
    unless logged_in?
      store_location
      redirect_to login_path, noauth: '1'
    end
  end

  # Ensures a valid user is logged in (current user or admin)
  def correct_user
    @user = User.find(params[:id])
    unless current_user?(@user) || current_user.admin?
      store_location
      redirect_to login_path, noauth: '2'
    end
  end

  # Checks if the current user is an admin
  def admin_user
    unless current_user.admin?
      redirect_to login_path, noauth: '3'
    end
  end

  ##############################
  #        Redirection         #
  ##############################

  # Redirects to a stored page, or to the default location
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  # Stores a url in the session
  def store_location
    session[:forwarding_url] = request.url if request.get?
  end

end
