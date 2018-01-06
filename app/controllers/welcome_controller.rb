class WelcomeController < ApplicationController 
    
  def home 
#    if session[:user_id]
#      binding.pry
#      @user = User.find(session[:user_id]) 
#    else 
#        binding.pry
#        redirect_to 'users/sign_in' 
#    end 
  end 
    
  def about
    render :text => "About the Website"
  end
    
    
end 