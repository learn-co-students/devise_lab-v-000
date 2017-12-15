require 'pry'

class SessionsController < ApplicationController
    
    def login

    end
    
    def create
        binding.pry
        @user = User.find_by(email: params[:user][:email])
        if @user.authenticate(params[:user][:password])
            session[:user_id] = @user.id
        else
            redirect_to action: 'application/about'
        end
    end
    
    def destroy
        if session.include? :user_id
            session[:user_id] = nil
        end
    end
    
end