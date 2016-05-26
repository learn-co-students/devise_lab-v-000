class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def facebook
    @user = User.from_omniauth(request.ev["omniauth.auth"])
    sign_in_redirect @user
  end

end
