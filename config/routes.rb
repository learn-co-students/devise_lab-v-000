Rails.application.routes.draw do
  
  root 'welcome#home'
  
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  get '/about', to: "welcome#about"
end
