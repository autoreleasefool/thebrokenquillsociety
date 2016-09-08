class PasswordResetsController < ApplicationController
  def new
  end

  # Create a link for the user to reset their password
  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:success] = "Email sent with password reset instructions"
      redirect_to root_url
    else
      flash.now[:error] = "Email address not found"
      render 'new'
    end
  end

  def edit
  end
end
