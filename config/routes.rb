Rails.application.routes.draw do

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  root "welcome#home"

  get '/', to: "welcome#home"
  get "/about", to: "welcome#about"

  get "/users/sign_out", to: "welcome#destroy"
  get "/users/sign_in", to: "sessions#create"
  get "/users/sign_up", to: "sessions#create"
end
