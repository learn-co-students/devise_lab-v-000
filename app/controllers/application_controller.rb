class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
<<<<<<< HEAD
=======

>>>>>>> 62ba3db58b3529f8549f94fc20de26e508e77de1
  def after_sign_in_path_for(resource)
    request.env['omniauth.origin'] || root_path
  end
end
