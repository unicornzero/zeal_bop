class User < ActiveRecord::Base
  has_many :authentications, class_name: 'UserAuthentication', dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable
  devise :omniauthable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # def self.create_from_omniauth(params)
  #   p params
  #   attributes = {
  #     email: params['info']['email'],
  #     password: Devise.friendly_token
  #   }
  #
  #   create(attributes)
  # end

end
