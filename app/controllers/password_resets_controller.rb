class PasswordResetsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user
      user.reset_password_token = SecureRandom.urlsafe_base64(24)
      user.reset_password_sent_at = Time.current
      user.save!(validate: false)
      UserMailer.with(user: user).password_reset.deliver_later
    end
    redirect_to root_path, notice: "If that email exists, you will receive reset instructions."
  end

  def edit
    @user = User.find_by(reset_password_token: params[:id])
    unless @user && @user.reset_password_sent_at && @user.reset_password_sent_at > 2.hours.ago
      redirect_to new_password_reset_path, alert: "Reset token expired or invalid." and return
    end
  end

  def update
    @user = User.find_by(reset_password_token: params[:id])
    unless @user && @user.reset_password_sent_at && @user.reset_password_sent_at > 2.hours.ago
      redirect_to new_password_reset_path, alert: "Reset token expired or invalid." and return
    end
    if @user.update(password: params[:user][:password])
      @user.update(reset_password_token: nil, reset_password_sent_at: nil)
      redirect_to root_path, notice: "Password updated. You can now sign in."
    else
      render :edit, status: :unprocessable_entity
    end
  end
end
