class WelcomeController < ApplicationController
  def home
  end

  def about
    render :'welcome/about'
  end

end
