class SessionsController < ApplicationController
  skip_forgery_protection only: [:create]

  def create
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      respond_to do |format|
        format.html { redirect_to root_path, notice: "Signed in" }
        format.json { render json: { id: user.id, email: user.email, is_admin: user.is_admin.to_i > 0 } }
      end
    else
      respond_to do |format|
        format.html { redirect_to root_path, alert: "Invalid credentials" }
        format.json { render json: { error: "Invalid credentials" }, status: :unauthorized }
      end
    end
  end

  def destroy
    session.delete(:user_id)
    respond_to do |format|
      format.html { redirect_to root_path, notice: "Signed out" }
      format.json { head :no_content }
    end
  end
end
