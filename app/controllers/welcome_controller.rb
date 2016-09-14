class WelcomeController < ApplicationController

  def home
    puts current_user.email
  end

end