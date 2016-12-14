class Stock < ApplicationRecord
  belongs_to :clinic
  belongs_to :product

  def update_stock_quantity(quantity)
  	self.update_columns({quantity:quantity}) 
  	self.clinic.notify_contact_with_sms(self) if self.quantity <= self.replenisch_at_quantity   
  end

end
