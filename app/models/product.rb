class Product < ApplicationRecord

	# relationships

	has_many :stocks
	has_many :stock_takes
 
	# validation rules

	validates :name, presence: true 
	validates :barcode, presence: true
	validates :replenish_quantity, presence: true
  	validates :barcode, uniqueness: true
  	validates :name, uniqueness: true
 
	# business rules
	
	# 1. Add product to all clinics as stock
	# 2. Set stock replenish quantity 

	after_create :create_stock
	after_update :create_stock

	def create_stock 

		Clinic.all.each do |clinic|
			s = Stock.find_or_create_by(product:self,clinic:clinic)
			s.replenisch_at_quantity = self.replenish_quantity 
			s.save
		end
	end

end
