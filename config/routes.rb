Rails.application.routes.draw do

    devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }


  root to: 'welcome#home'

  get 'about' => 'welcome#about'

end
