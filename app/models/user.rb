class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # validation rules

	validates :name, presence: true 
	validates :mobile, presence: true
  validates :mobile, uniqueness: true

  #relationships

  has_many :stock_takes

  # business rules
  
  # 1. Send SMS with pin on mobile app login
  # 2. Generate token and send to app  (token not reseting every login so user can login from differnt devices)


  def generate_token
    unless self.token
      self.token = loop do
        random_token = SecureRandom.urlsafe_base64(nil, false)
        break random_token unless User.exists?(token: random_token)
      end
      self.save
    end
  end

  def generate_pin_and_sms

    self.pin = rand(0000..9999).to_s.rjust(4, "0") 
    self.save

  	require 'rubygems'
  	require 'clickatell'
    api = Clickatell::API.authenticate(Rails.application.secrets.clickatel_api_id, Rails.application.secrets.clickatel_username, Rails.application.secrets.clickatel_password)
	  api.send_message(self.mobile, "Please enter pin: #{self.pin} on stock app to login ")
	  
	end
end
