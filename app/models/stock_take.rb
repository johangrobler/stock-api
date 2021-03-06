class StockTake < ApplicationRecord
  include ActionView::Helpers::DateHelper
  belongs_to :product
  belongs_to :clinic
  belongs_to :user

  after_create :push_stock_take

  # 1. Push live websocket call to subscribers


  def push_stock_take
  	
 	  puts "push"

  	require 'pusher'
    pusher_client = Pusher::Client.new(
        app_id: '226476',
        key: '62217549218f218bf085',
        secret: '3b2d56477030f12e48df',
        cluster: 'eu',
        encrypted: true
    )
  
 
    pusher_client.trigger("mezzanine-stocktake", 'stocktake_event_1', {
              stock_take: {
              	quantity:self.quantity,
              	product:self.product.name,
              	clinic:self.clinic.name,
                latitude:self.clinic.latitude.to_f,
                longitude:self.clinic.longitude.to_f,
              	created_at: time_ago_in_words(self.created_at),
              	replenish_quantity:self.product.replenish_quantity
              }
    })
  
 	puts "pushed"

  end


end
