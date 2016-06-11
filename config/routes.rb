Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  root 'welcome#home'
  get 'about', to: 'welcome#about'
  get 'users/sign_out', to: 'welcome#signout'
end
