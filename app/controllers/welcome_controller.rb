class WelcomeController < ApplicationController

  def index
    render controller: 'welcome',  template: 'welcome'
  end

  def welcome

  end

  def about

  end
end
