class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    @user = User.from_omniauth(request.env["omniauth.auth"])
    if @user.persisted?
      sign_in_and_redirect @user
    else
      failure
      redirect_to new_user_registration_path
    end
  end

  def failure
    flash[:notice] = "Invalid email or password."
    redirect_to new_user_session_path
  end
end