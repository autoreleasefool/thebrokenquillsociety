class UserMailer < ApplicationMailer
  default from: "no-reply@thebrokenquillsociety.com"

  def password_reset(user)
    @user = user
    mail to: user.email, subject: UntitledCWC::Application::WEBSITE_NAME + " - Password reset"
  end
end
