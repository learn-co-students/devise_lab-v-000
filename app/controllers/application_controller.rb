require 'pry'

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  def welcome
  
    redirect_to action: 'show' if session[:user_id].present?
  end
  
  def show
    
    @user = current_user
  end
  
  def after_sign_in_path_for(resource)
  
    show_path(current_user)
  end
  
  def about
        
    end
end
