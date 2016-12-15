class Product < ApplicationRecord

	has_many :stocks


	validates :name, presence: true 
	validates :barcode, presence: true
	validates :replenish_quantity, presence: true

  	validates :barcode, uniqueness: true
  	validates :name, uniqueness: true
  	
	after_create :create_stock

	def create_stock
 

		Clinic.all.each do |clinic|

			s = Stock.find_or_create_by(product:self,clinic:clinic)
			s.replenisch_at_quantity = 5  unless s.replenisch_at_quantity 
			s.save

		end
	end

end
