class WelcomeController < ApplicationController
  def home
    @current_user = User.find_by(email: params[:email])
  end

  def about
    render text: "About the Website"
  end
end
