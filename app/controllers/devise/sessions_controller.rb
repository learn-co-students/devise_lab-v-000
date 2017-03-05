class Devise::SessionsController < Devise::OmniauthCallbacksController

	def new
		@user = User.new
	end

	def create
		@user = User.find_by(:email => params[:user][:email])
		if @user && @user.valid_password?(params[:user][:password])
			sign_in_and_redirect @user
			flash[:notice] = "Signed in successfully."
		else
			flash[:notice] = "Invalid email or password"
			redirect_to new_user_session_path
		end
	end


	def destroy
		session.clear
		flash[:notice] = "Signed out successfully."
		redirect_to '/'
	end

end