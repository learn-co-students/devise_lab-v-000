Rails.application.config.middleware.use OmniAuth::Builder do
 provider :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET']
 def facebook
   @user = User.from_omniauth(request.env["omniauth.auth"])
   sign_in_and_redirect @user
 end
end
