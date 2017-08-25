class WelcomeController < ApplicationController
  def home
    @current_user = User.find_by(session[:user_id])
  end

  def about
  end
end