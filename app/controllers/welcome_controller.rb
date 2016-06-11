class WelcomeController < ApplicationController
  def home
    # sign_out current_user
    @email = current_user.email unless current_user.nil?
  end

  def sign_out
  end

  def about
  end
end
