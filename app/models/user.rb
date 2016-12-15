class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


	validates :name, presence: true 
	validates :mobile, presence: true
  	validates :mobile, uniqueness: true

  def generate_token
    self.token = loop do
      random_token = SecureRandom.urlsafe_base64(nil, false)
      break random_token unless User.exists?(token: random_token)
    end
    self.save
  end

  def generate_pin_and_sms

    self.pin = rand(0000..9999).to_s.rjust(4, "0") 
    self.save

	require 'rubygems'
	require 'clickatell'
    api = Clickatell::API.authenticate(Rails.application.secrets.clickatel_api_id, Rails.application.secrets.clickatel_username, Rails.application.secrets.clickatel_password)
	api.send_message(self.mobile, "Please confirm your phone number by entering this code on the app: "+self.pin)
	  
	end
end
