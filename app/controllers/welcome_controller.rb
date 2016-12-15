class WelcomeController < ApplicationController
  def index
  	redirect_to '/dashboard/summary' if admin_signed_in?
  end
end
