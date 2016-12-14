class Product < ApplicationRecord

	has_many :stocks

	after_create :create_stock

	def create_stock
 

		Clinic.all.each do |clinic|

				s = Stock.find_or_create_by(self:product,clinic:clinic)
				s.replenisch_at_quantity = 5  unless s.replenisch_at_quantity 
				s.save

		end
	end

end
