class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, :omniauth_providers => [:facebook]

  def self.from_omniauth(auth)
    #look for or create a user with that provider and uid attributes from auth hash
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      #set email attribute from auth hash
      user.email = auth.info.email
      #make up random password
      #remember: this is reset every time they sign in using omniauth
      user.password = Devise.friendly_token[0,20]
    end      
  end

end
