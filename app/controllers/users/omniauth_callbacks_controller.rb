class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  require 'pry'
 
 def facebook

  @user = User.from_omniauth(request.env["omniauth.auth"])
     sign_in_and_redirect @user     
  end
end

# namespace its part of the class, however its placed in new folder  