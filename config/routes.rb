Rails.application.routes.draw do
  root to: "welcome#home"
  get '/about', to: "welcome#about"
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
end
