module Api
  class UsersController < ApplicationController



    include ActionView::Helpers::DateHelper
    skip_before_filter  :verify_authenticity_token
    respond_to :json
 
  
 

   def create  


      user = User.find_by(mobile:params[:mobile], pin:params[:pin] )
      if user
        user.generate_token
      end
 
      render json:user
 


   end

 end
end