module Api
  class ClinicsController < ApplicationController

    include ActionView::Helpers::DateHelper
    skip_before_filter  :verify_authenticity_token
    respond_to :json
 
  
    def index

          # check for paramters and default to a location

          unless params[:latitude]
            params[:latitude]=-33.9379044
            params[:longitude]=18.8619449
          end
            
          clinics = Clinic.near([ params[:latitude],params[:longitude]], 5000000, :units => :km)
        

          return_data  = {
            clinics:clinics.collect{|c| {
              id:c.id,
              name:c.name,
              address:c.address,
              latitude:c.latitude,
              longitude:c.longitude,
              distance: Geocoder::Calculations.distance_between([c.latitude,c.longitude], [ params[:latitude],params[:longitude] ], :units => :km).to_i,
              stock: c.stocks.all.collect{|stock| {
                    id:stock.id,
                    product_id: stock.product_id,
                    product: stock.product.name,
                    barcode: stock.product.barcode,
                    quantity: stock.quantity
                }
              }

            }
          }
        }

        render :json => return_data[:clinics] , :callback => params[:callback]

   end

 end
end