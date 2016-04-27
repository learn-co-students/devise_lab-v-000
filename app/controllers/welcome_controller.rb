class WelcomeController < ApplicationController

  def index
  end
  
  def about
    render :text => "About the Website"
  end

end