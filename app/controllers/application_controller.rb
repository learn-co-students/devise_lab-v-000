class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def after_sign_in_path_for(resource)
    # raise request.env['omniauth.origin'].inspect
    # request.env['omniauth.origin'] || welcome_home_path
    welcome_home_path
  end
end
