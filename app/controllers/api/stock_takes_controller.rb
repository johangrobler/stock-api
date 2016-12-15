module Api
  class StockTakesController < ApplicationController



    include ActionView::Helpers::DateHelper
    skip_before_filter  :verify_authenticity_token
    respond_to :json
 
  
    def index

          unless params[:latitude]
            params[:latitude]=-33.9379044
            params[:longitude]=18.8619449
          end

          return_data  = {
            stocks:StockTake.order('id desc').all.collect{|stock| {
              id:stock.id,
              product_name:stock.product.name, 
              quantity:stock.quantity,
              distance: Geocoder::Calculations.distance_between([stock.latitude,stock.longitude], [ params[:latitude],params[:longitude] ], :units => :km).to_i
         

            }
          }
        }

        render json:return_data[:stocks] , callback:params[:callback]

   end

   def create  


      stock_take = StockTake.create(
        clinic_id:params[:clinic_id],
        product_id:params[:product_id],
        quantity:params[:quantity],
        latitude:params[:latitude],
        longitude:params[:longitude]
      )

      Stock.find_by(clinic_id:params[:clinic_id],product_id:params[:product_id]).update_stock_quantity(params[:quantity])
 
      render json:stock_take
 


   end

 end
end