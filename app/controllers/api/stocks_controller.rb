module Api
  class StocksController < ApplicationController
    
    include ActionView::Helpers::DateHelper
    skip_before_filter  :verify_authenticity_token
    respond_to :json
 
  
    def index

          return_data  = {
            stocks:Stock.where(clinic_id:params[:clinic_id].to_i).all.collect{|stock| {
              id:stock.id,
              product_id:stock.product_id,
              clinic_id:stock.clinic_id,
              product_name:stock.product.name,
              barcode:stock.product.barcode,
              quantity:stock.quantity,

            }
          }
        }

        render :json => return_data[:stocks] , :callback => params[:callback]

   end
 end
end
