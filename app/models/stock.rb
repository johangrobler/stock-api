class Stock < ApplicationRecord
 
  belongs_to :clinic
  belongs_to :product

  # validation rules
  
  validates :replenisch_at_quantity, presence: true 

  # 1. check if quantity update is requires replenish
  # 2. trigger replenish sms notification on client 

  def update_stock_quantity(quantity)
  	self.update_columns({quantity:quantity}) 
  	self.clinic.notify_contact_with_sms(self) if self.quantity <= self.replenisch_at_quantity    
  end


end
