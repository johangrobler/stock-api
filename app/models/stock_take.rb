class StockTake < ApplicationRecord
  belongs_to :product
  belongs_to :clinic


  after_create :push_stock_take


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
  
 
    pusher_client.trigger("mezzanine-stocktake", 'stocktake_event', {
              stock_take: self
    })
  
 	puts "pushed"

  end


end
