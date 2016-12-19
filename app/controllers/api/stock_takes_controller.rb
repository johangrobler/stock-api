module Api
  class StockTakesController < ApiBaseController

    # 1. create stock_take from app 
    # 2. assign to user an geostamp location of stocktake
    # 3. update quantity on Stock
    # 4  Sock will trigger notification if needed

    include ActionView::Helpers::DateHelper
    skip_before_filter  :verify_authenticity_token
    respond_to :json
 
  
    def index

          unless params[:latitude]
            params[:latitude]=-33.9379044
            params[:longitude]=18.8619449
          end

          return_data  = {
            stocks:@current_user.stock_takes.order('id desc').all.collect{|stock| {
              id:stock.id,
              product_name:stock.product.name, 
              quantity:stock.quantity,
              created_at:stock.created_at,
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
        longitude:params[:longitude],
        user_id:@current_user.id
      )

      Stock.find_by(clinic_id:params[:clinic_id],product_id:params[:product_id]).update_stock_quantity(params[:quantity])
 
      render json:stock_take
 


   end

 end
end