class Product < ApplicationRecord

	has_many :stocks
	has_many :stock_takes


	validates :name, presence: true 
	validates :barcode, presence: true
	validates :replenish_quantity, presence: true

  	validates :barcode, uniqueness: true
  	validates :name, uniqueness: true

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
