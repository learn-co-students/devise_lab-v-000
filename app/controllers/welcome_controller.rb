class WelcomeController < ApplicationController
  def home
        if user_signed_in?
            current_user
        else
          redirect_to sign_in_path
        end
  end

  def about
  end
end
