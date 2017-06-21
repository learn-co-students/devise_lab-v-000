class WelcomeController < ApplicationController
  def home
    render :text => current_user.email
  end

  def about
    render :text => "About the Website"
  end

  def index
  end
end
