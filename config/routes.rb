Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  get 'welcome/home'
  get '/about' => 'welcome#about'

  root to: 'welcome#home'
 
end