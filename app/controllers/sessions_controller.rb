class SessionsController < ApplicationController

  # Form to let a user login to their account
  def new
  end

  # Creates a new user session
  def create
    user = User.find_by_email(params[:email])

    # If the user exists and the password entered is valid
    if user && user.authenticate(params[:password])
      # Save the user id inside the browser cookie
      session[:user_id] = user.id
      redirect_to '/'
    else
      redirect_to '/login'
    end
  end

  # Closes a session when the user logs out
  def destroy
    session[:user_id] = nil
    redirect_to '/login'
  end

end
