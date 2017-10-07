class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user

  def current_user
    @user = (User.find_by(id: session[:user_id]) || User.new)
  end

  def after_sign_in_path_for(resource)
    request.env["onmiauth.origin"] || root_path
  end
end
