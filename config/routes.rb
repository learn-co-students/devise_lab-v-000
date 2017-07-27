Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
#   get 'new/user/session' => 'session#new'
   resources :users
   root 'welcome#home'
   get '/about', to: 'welcome#about'

end
