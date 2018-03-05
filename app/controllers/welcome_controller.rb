class WelcomeController < ApplicationController

  def home

  end

  def about
    #could remove welcome/about view and add line below
    #navbar is styled in layout so text below is only thing unique to page
    #render :text => "About the Website"
  end

end