class UserMailer < ApplicationMailer
  default from: "no-reply@localhost"

  def password_reset
    @user = params[:user]
    @url = edit_password_reset_url(@user.reset_password_token)
    mail(to: @user.email, subject: "Reset your password")
  end
end
