class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  devise :omniauthable, :omniauth_providers => [:facebook]
  
  #To take care of error when running test. Devise tests for 6 character minimum, while in spec/features/visitors/sign_up_spec.rb, the test parameter is 6 characters (please). As a result, test does not pass.
  validates :password, length: {minimum: 7}

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
    end      
  end
end
