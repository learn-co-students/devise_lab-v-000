class WelcomeController < ApplicationController
    def home
        render :home
    end
    
    def about
        render :text => "About the Website"
    end
end
