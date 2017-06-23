class WelcomeController < ApplicationController
  def home
  end

  def about
    render :text => "About the website"
  end
  
end
