class WelcomeController < ApplicationController
  def home
    
  end
  
  def index
    render text: 'Signed out successfully.'
  end
  
  def about
    render text: 'About the Website'
  end
end
