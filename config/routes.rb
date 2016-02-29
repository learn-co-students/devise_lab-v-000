Rails.application.routes.draw do
  get 'omniauth_callbacks/controllers/users'

  devise_for :users
  root 'welcome#index'
  get '/about', to: 'welcome#about'

end
