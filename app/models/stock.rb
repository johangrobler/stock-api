class Stock < ApplicationRecord
  belongs_to :clinic
  belongs_to :product

  
	validates :replenisch_at_quantity, presence: true 

  def update_stock_quantity(quantity)
  	self.update_columns({quantity:quantity}) 
  	self.clinic.notify_contact_with_sms(self) if self.quantity <= self.replenisch_at_quantity   
  end

  def push_stock_take
  	
  	require 'pusher'
    pusher_client = Pusher::Client.new(
        app_id: '226476',
        key: '62217549218f218bf085',
        secret: '3b2d56477030f12e48df',
        cluster: 'eu',
        encrypted: true
    )
  
 
    pusher_client.trigger("mezzanine-stocktake", 'stocktake_event', {
              stock: self
    })
  
 

  end

end
