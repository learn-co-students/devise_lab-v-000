class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    user = User.from_omniauth(auth)
    session[:user_id] = user.id
    sign_in_and_redirect user
  end
end
