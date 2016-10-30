class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def after_sign_in_path_for(resource)
    request.env['omniauth.origin'] || root_path
  end

  def current_user
    User.find_by(id: session[:user_id])
  end

  def auth
    @auth = request.env["omniauth.auth"]
  end
end
