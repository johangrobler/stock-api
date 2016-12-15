class DashboardController < ApplicationController
  def summary

    @stocks = Stock.where('quantity <= replenisch_at_quantity')
    @products = Product.all
  end
end
