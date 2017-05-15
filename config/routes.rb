Rails.application.routes.draw do
 # devise_for :users
  root 'welcome#home'
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  get '/about', to: 'static#about'
end
