class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
	def facebook
		@user = User.from_omniauth(rquest.env["omniauth.auth"])
		sign_in_and_redirect @user
	end
end