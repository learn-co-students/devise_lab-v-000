Rails.application.routes.draw do
  devise_for :users
  root 'welcome#home'
  get '/about' => "welcome#about"
  #devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

end
