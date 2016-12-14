module Api
  class UserController < ApplicationController



    include ActionView::Helpers::DateHelper
    skip_before_action  :verify_authenticity_token
    respond_to :json
 
  
 

   def create  


      user = User.find_by(mobile:params[:mobile], pin:params[:pin] )
 
 
      render json:user
 


   end

 end
end