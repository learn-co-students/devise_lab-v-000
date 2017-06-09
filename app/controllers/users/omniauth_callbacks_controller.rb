class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

    def facebook
        @user = User.from_omniauth(request.env['omniauth.auth'])
        signin_and_redirect @user
    end

end
