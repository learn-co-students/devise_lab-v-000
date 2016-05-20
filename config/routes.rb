Rails.application.routes.draw do

  root to: 'welcome#don'

  get '/home' => 'welcome#home'
  get '/about' => 'welcome#about'

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

end
