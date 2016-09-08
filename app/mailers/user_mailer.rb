class UserMailer < ApplicationMailer

  def password_reset(user)
    @user = user
    mail to: user.email, subject: UntitledCWC::Application::WEBSITE_NAME + " - Password reset"
  end
end
