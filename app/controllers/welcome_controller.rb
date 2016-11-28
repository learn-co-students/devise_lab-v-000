class WelcomeController < ApplicationController

  def home 
    render :home
  end

  def about
    render :about
  end

  def destroy
    session.delete :user_id if session[:user_id]
    flash[:notice] = "Signed out successfully."
    redirect_to root_path
  end

end
