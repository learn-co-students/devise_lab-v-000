Rails.application.routes.draw do
  root 'welcome#home'
  get '/about', to: 'welcome#about'
  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }
end
