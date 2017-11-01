class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    @user = User.from_omniauth(request.env["omniauth.auth"])
<<<<<<< HEAD
    sign_in_and_redirect @user      
=======
    sign_in_and_redirect @user 
>>>>>>> 62ba3db58b3529f8549f94fc20de26e508e77de1
  end
end