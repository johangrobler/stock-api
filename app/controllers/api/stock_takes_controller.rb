module Api
  class StockTakesController < ApplicationController



    include ActionView::Helpers::DateHelper
    skip_before_filter  :verify_authenticity_token
    respond_to :json
 
  
    def index

          return_data  = {
            stocks:StockTake.where(clinic_id:params[:clinic_id].to_i).order('id desc').all.collect{|stock| {
              id:stock.id,
              product_name:stock.product.name, 
              quantity:stock.quantity,

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