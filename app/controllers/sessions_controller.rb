class SessionsController < ApplicationController

def create
  # Oauth Login
  if auth_hash = request.env["omniauth.auth"]
    oauth_email = request.env["omniauth.auth"]["info"]["email"]
    if user = User.find_by(:email => oauth_email)
      session[:user_id] = user
      redirect_to root_path
    else
      user = User.new(:email => oauth_email, :password => SecureRandom.hex)
      if user.save
        session[:user_id] = user.id
        redirect_to root_path
      else
        raise user.errors.full_messages.inspect
      end
    end
  else
    # Normal Login
    user = User.find_by(:email => params[:email])
    if user && user.authentication(params[:password])
      session[:user_id] = user.id
      redirect_to root_path
    else
      render new_user_session_path
    end
  end
end

  def destroy
    reset_session
    redirect_to new_user_session_path
  end

end
