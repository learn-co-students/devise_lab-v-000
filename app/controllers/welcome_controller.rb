class WelcomeController < ApplicationController
  def home
    current_user
  end
end
