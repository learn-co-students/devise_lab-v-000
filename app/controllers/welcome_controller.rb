class WelcomeController < ApplicationController
  def home
    @user = current_user
  end

  def about
    render :text => "About the Website"
  end
end
