class WelcomeController < ApplicationController
  def home
    puts current_user.email
  end

  def index
  end

  def about
  end
end
