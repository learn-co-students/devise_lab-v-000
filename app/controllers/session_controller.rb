class SessionController < ApplicationController
  def logout
    sign_out current_user
    flash[:notice] = 'Signed out successfully.'
    redirect_to root_path
  end
end