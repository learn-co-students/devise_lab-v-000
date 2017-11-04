Rails.application.routes.draw do
  root to: 'welcome#home'
  # devise_for :users
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  get '/about', to: 'welcome#about'

end
