class WelcomeController < ApplicationController
  def home # implicitly renders app/views/welcome/home.html.erb (Homepage view file)
  end

  def about # implicitly renders app/views/welcome/about.html.erb
  end
end
