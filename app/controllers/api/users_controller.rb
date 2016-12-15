module Api
  class UsersController < ApplicationController



    include ActionView::Helpers::DateHelper
    skip_before_filter  :verify_authenticity_token
    respond_to :json
 
  
   def show

      user = User.find_by(mobile:params[:id].gsub('+',''))
      if user
          user.generate_pin_and_sms
          render json:{pin:user.pin}
      else
          render json:{error:'User with this mobile number has not been added to users'}
      end
      #send user pin number
   end

   def create  


      user = User.find_by(mobile:params[:mobile], pin:params[:pin] )
      if user
        user.generate_token
      end
 
      render json:user
 


   end

 end
end