class WelcomeController < ApplicationController

  helper_method :current_user

  def home
  end

  def about
  end

  # def destroy
  #   session.delete :user
  #   # redirect_to new_user_session_path
  #   redirect_to '/users/sign_in'
  # end

end
