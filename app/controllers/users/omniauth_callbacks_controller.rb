class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    #make @user instance from class method, with auth_hash as argument
    @user = User.from_omniauth(request.env["omniauth.auth"])
    sign_in_and_redirect @user 
  end
end