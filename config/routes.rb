Rails.application.routes.draw do
  root "welcome#home"
  get "/about" => "welcome#about"
  devise_for :user, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
end
