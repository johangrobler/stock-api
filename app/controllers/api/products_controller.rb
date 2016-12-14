module Api
  class ProductsController < ApplicationController

    include ActionView::Helpers::DateHelper
    skip_before_filter  :verify_authenticity_token
    respond_to :json
 
  
    def index

          return_data  = {
            products:Product.all.collect{|p| {
              id:p.id,
              name:p.name,
              name:p.barcode

            }
          }
        }

        render :json => return_data[:products] , :callback => params[:callback]

   end
 end
end