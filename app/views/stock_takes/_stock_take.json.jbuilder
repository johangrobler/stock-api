json.extract! stock_take, :id, :product_id, :clinic_id, :latitude, :longitude, :quantity, :created_at, :updated_at
json.url stock_take_url(stock_take, format: :json)