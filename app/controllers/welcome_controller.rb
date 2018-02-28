class WelcomeController < ApplicationController

  def home
    current_user.email
  end

end
