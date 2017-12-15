class UsersController < ApplicationController
    
    def create
        @user = User.new(name: params[:user][:name])
        if params[:user][:password] == params[:user][:password_confirmation]
            @user.password = params[:user][:password]
            @user.save
            session[:user_id] = @user.id
        else
            redirect_to action: 'new'
        end
    end
    
    def show
        
    end
end