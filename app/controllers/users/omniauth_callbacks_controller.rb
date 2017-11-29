class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  before_filer :authenticate_user!
  def facebook
    @user = User.from_omniauth(request.env["omniauth.auth"])
    sign_in_and_redirect @user
  end
end
