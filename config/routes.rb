Rails.application.routes.draw do
  root 'welcomes#home'
  get '/about', to: 'welcomes#about'
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
end
