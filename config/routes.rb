Rails.application.routes.draw do
  devise_for :users
  root to: 'static#home'

  get '/about', to: 'static#about'
end
