Rails.application.routes.draw do

  root 'welcome#home'

  get '/about', to: 'welcome#about'

  devise_for :users

end
