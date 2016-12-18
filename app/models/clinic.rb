class Clinic < ApplicationRecord
	
	has_many :stocks
	has_many :stock_takes

	validates :name, presence: true
	validates :address, presence: true
	validates :mobile, presence: true

	geocoded_by :address   						# can also be an IP address
	after_validation :geocode          			# auto-fetch coordinates
	reverse_geocoded_by :latitude, :longitude	# flild store location

	after_create :create_stock
	after_update :create_stock



	def create_stock
		puts self.name
		Product.all.each do |product|
				s = Stock.find_or_create_by(product:product,clinic:self)
				s.replenisch_at_quantity = product.replenish_quantity 
				s.save
		end
	end

	def notify_contact_with_sms(stock)
		
		puts "send sms to #{self.mobile} to replenish stock"
		
		require 'rubygems'
        require 'clickatell' 
        api = Clickatell::API.authenticate(Rails.application.secrets.clickatel_api_id, Rails.application.secrets.clickatel_username, Rails.application.secrets.clickatel_password)
        api.send_message(self.mobile, "#{self.name}'s stock level for #{stock.product.name} is at #{stock.quantity} and needs replenishment")
     

	end
end
