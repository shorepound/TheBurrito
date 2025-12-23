class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?, :admin_user?

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def logged_in?
    current_user.present?
  end

  def admin_user?
    current_user && current_user.is_admin.to_i > 0
  end

  def authenticate_user!
    return if logged_in?
    respond_to do |format|
      format.html { redirect_to root_path, alert: "Please sign in" }
      format.json { render json: { error: "Unauthorized" }, status: :unauthorized }
    end
  end

  def require_admin!
    return if admin_user?
    render json: { error: "Forbidden" }, status: :forbidden
  end
end
