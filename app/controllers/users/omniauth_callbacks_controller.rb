class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    @user = User.from_omniauth(request.env["emniauth.auth"])
    sign_in_and_redirect @user
  end
end
