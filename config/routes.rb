Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  root 'welcome#home'
  get '/about' => 'welcome#about'
end
# routes created by devise_for :users
#       PREFIX        HTTP VERB       URL            CONTROLLER#ACTION

#       new_user_session GET    /users/sign_in       devise/sessions#new
#           user_session POST   /users/sign_in       devise/sessions#create
#   destroy_user_session DELETE /users/sign_out      devise/sessions#destroy
#          user_password POST   /users/password      devise/passwords#create
#      new_user_password GET    /users/password/new  devise/passwords#new
#     edit_user_password GET    /users/password/edit devise/passwords#edit
#                        PATCH  /users/password      devise/passwords#update
#                        PUT    /users/password      devise/passwords#update
#cancel_user_registration GET    /users/cancel       devise_invitable/registrations#cancel
#      user_registration POST   /users               devise_invitable/registrations#create
#   new_user_registration GET    /users/sign_up      devise_invitable/registrations#new
#  edit_user_registration GET    /users/edit         devise_invitable/registrations#edit
#                       PATCH  /users                devise_invitable/registrations#update
#                         PUT    /users              devise_invitable/registrations#update
#                         DELETE /users              devise_invitable/registrations#destroy
#                    root GET    /                   welcome#home
#                    page GET    /pages/*id          high_voltage/pages#show
