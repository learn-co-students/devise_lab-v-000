class WelcomeController < ApplicationController
  def home
    if current_user != nil
      @current_email = current_user.email
    end
  end

  def about
    
  end
end