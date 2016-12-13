# rails g devise:install

===============================================================================

Some setup you must do manually if you haven't yet:

  1. Ensure you have defined default url options in your environments files. Here
     is an example of default_url_options appropriate for a development environment
     in config/environments/development.rb:

       config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }

     In production, :host should be set to the actual host of your application.

  2. Ensure you have defined root_url to *something* in your config/routes.rb.
     For example:

       root to: "home#index"

  3. Ensure you have flash messages in app/views/layouts/application.html.erb.
     For example:

       <p class="notice"><%= notice %></p>
       <p class="alert"><%= alert %></p>

  4. You can copy Devise views (for customization) to your app by running:

       rails g devise:views

===============================================================================

# rake routes
                  Prefix Verb   URI Pattern                    Controller#Action
        new_user_session GET    /users/sign_in(.:format)       devise/sessions#new
            user_session POST   /users/sign_in(.:format)       devise/sessions#create
    destroy_user_session DELETE /users/sign_out(.:format)      devise/sessions#destroy
           user_password POST   /users/password(.:format)      devise/passwords#create
       new_user_password GET    /users/password/new(.:format)  devise/passwords#new
      edit_user_password GET    /users/password/edit(.:format) devise/passwords#edit
                         PATCH  /users/password(.:format)      devise/passwords#update
                         PUT    /users/password(.:format)      devise/passwords#update
cancel_user_registration GET    /users/cancel(.:format)        devise_invitable/registrations#cancel
       user_registration POST   /users(.:format)               devise_invitable/registrations#create
   new_user_registration GET    /users/sign_up(.:format)       devise_invitable/registrations#new
  edit_user_registration GET    /users/edit(.:format)          devise_invitable/registrations#edit
                         PATCH  /users(.:format)               devise_invitable/registrations#update
                         PUT    /users(.:format)               devise_invitable/registrations#update
                         DELETE /users(.:format)               devise_invitable/registrations#destroy
                    root GET    /                              welcome#home
                    page GET    /pages/*id                     high_voltage/pages#show
