class StockTake < ApplicationRecord
  belongs_to :product
  belongs_to :clinic
end
