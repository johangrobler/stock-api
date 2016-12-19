class ApiBaseController < ApplicationController

  include ActionController::HttpAuthentication::Token::ControllerMethods
  before_action :restrict_access 

  private

	def restrict_access
	  authenticate_or_request_with_http_token do |token, options|  
  			set_user(token)
    		User.exists?(token: token) 
    		true
	  end
	end

	def set_user(token)
		@current_user = User.find_by(token: token)
	end


end