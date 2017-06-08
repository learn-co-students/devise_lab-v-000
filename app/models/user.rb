class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :registerable, :recoverable, :rememberable, :trackable
  devise :database_authenticatable, :validatable, password_length: 7..20
  devise :omniauthable, :omniauth_providers => [:facebook]

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      #user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
    end      
  end

end
