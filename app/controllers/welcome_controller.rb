class WelcomeController < ApplicationController

  def home
    @current_user = User.find_by_id(params[:id])
  end

  def about
  end
end
